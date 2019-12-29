param (
    [string]$grpcSourceDir=".",
    [string]$installDir=(Join-Path -Path $grpcSourceDir -ChildPath install),
    [switch]$install=$true,
    [string]$buildType="Release"
)

# Save current directory
pushd

$startTime = Get-Date

try {
if ($buildType -ne "Release" -And $buildType -ne "Debug" -And $buildType -ne "RelWithDebInfo" -And $buildType -ne "MinSizeRel") {
    throw "Invalid '-buildType' argument. Expected -buildType=[Release|Debug|RelWithDebInfo|MinSizeRel], but get '-buildType=$buildType'"
}

if (!(Test-Path $grpcSourceDir)) {
    throw "Invalid '-grpcSourceDir' argument. Get '-grpcSourceDir=$grpcSourceDir'"
}

if ($install -eq $true -And $installDir -eq "") {
    throw "Invalid '-installDir' argument. Get '-installDir=$installDir'"
}

Write-Output "gRPC source directory: $grpcSourceDir" 
Write-Output "Install directory: $installDir"
Write-Output "Need install: $install"
Write-Output "Build type: $buildType"

# Root build directory
$buildDir = Join-Path -Path $grpcSourceDir -ChildPath .build/$buildType
Write-Output "Root build directory: $buildDir"

# Create if not already exists
if (!(Test-Path $buildDir)) {
    New-Item $buildDir -ItemType directory
    Write-Output "Create root build directory successful"
}

# Clear build directory
Remove-Item -Path $buildDir/* -recurse
Write-Output "Clear root build directory successful"

<#########################################################################
# gRPC build directory
$grpcBuildDir = Join-Path -Path $buildDir -ChildPath grpc
Write-Output "gRPC build directory: $grpcBuildDir"

# zlib build directory
$zlibBuildDir = Join-Path -Path $buildDir -ChildPath zlib
Write-Output "zlib build directory: $zlibBuildDir"

# c-ares build directory
$caresBuildDir = Join-Path -Path $buildDir -ChildPath "c-ares"
Write-Output "c-ares build directory: $caresBuildDir"

# protobuf build directory
$protobufBuildDir = Join-Path -Path $buildDir -ChildPath protobuf
Write-Output "protobuf build directory: $protobufBuildDir"

# gflags build directory
$gflagsbufBuildDir = Join-Path -Path $buildDir -ChildPath gflags
Write-Output "gflags build directory: $gflagsBuildDir"

# nanopb build directory
$nanopbBuildDir = Join-Path -Path $buildDir -ChildPath nanopb
Write-Output "nanopb build directory: $nanopbBuildDir"

# ssl build directory
$sslBuildDir = Join-Path -Path $buildDir -ChildPath ssl
Write-Output "ssl build directory: $sslBuildDir"

# benchmark build directory
$benchmarkBuildDir = Join-Path -Path $buildDir -ChildPath benchmark
Write-Output "benchmark build directory: $benchmarkBuildDir"

# Create if not already exists
if (!(Test-Path $grpcBuildDir)) {
    New-Item $grpcBuildDir -ItemType directory
    Write-Output "Create gRPC build directory successful"
}
#########################################################################>

cd $buildDir

cmake ../.. `
	-G "Ninja" `
	-DCMAKE_CXX_COMPILER=cl `
	-DCMAKE_C_COMPILER=cl `
	-DCMAKE_INSTALL_PREFIX="$installDir" `
	-DCMAKE_BUILD_TYPE="$buildType" `
    -DgRPC_INSTALL=ON `
    -DgRPC_BUILD_CSHARP_EXT=OFF `
    -DgRPC_BUILD_TESTS=OFF `
    -Dprotobuf_BUILD_TESTS=OFF 

Write-Output "---------------------------------------------------------------"
    
cmake --build .

Write-Output "---------------------------------------------------------------"

# If need install grpc third_party
if ($install -eq $true) {
    cmake --install .
    Write-Output "---------------------------------------------------------------"
}

# zlib install directory
$zlibDir = $installDir
Write-Output "zlib install directory: $zlibDir"

# c-ares install directory
$caresDir = Join-Path -Path $installDir -ChildPath "lib\cmake\c-ares"
Write-Output "c-ares install directory: $caresDir"

# protobuf install directory
$protobufDir = Join-Path -Path $installDir -ChildPath "cmake"
Write-Output "protobuf install directory: $protobufDir"

# ssl install directory
$sslDir = Join-Path -Path $installDir -ChildPath ssl
Write-Output "ssl install directory: $sslDir"

# benchmark install directory
$benchmarkDir = Join-Path -Path $installDir -ChildPath "lib\cmake\benchmark"
Write-Output "benchmark install directory: $benchmarkDir"

cmake ../.. `
    -G "Ninja" `
    -DCMAKE_CXX_COMPILER=cl `
    -DCMAKE_C_COMPILER=cl `
    -DCMAKE_INSTALL_PREFIX="$installDir" `
    -DCMAKE_BUILD_TYPE="$buildType" `
    -DgRPC_INSTALL=ON `
    -DgRPC_BUILD_CSHARP_EXT=OFF `
    -DgRPC_BUILD_TESTS=OFF `
    -DgRPC_PROTOBUF_PROVIDER=package `
    -DgRPC_ZLIB_PROVIDER=package `
    -DgRPC_CARES_PROVIDER=package `
    -DgRPC_SSL_PROVIDER=package `
    -DgRPC_BENCHMARK_PROVIDER=package `
    -DgRPC_PROTOBUF_PACKAGE_TYPE=CONFIG `
    -DProtobuf_DIR="$protobufDir" `
    -Dc-ares_DIR="$caresDir" `
    -Dbenchmark_DIR="$benchmarkDir" `
    -DZLIB_ROOT="$zlibDir"
    
Write-Output "---------------------------------------------------------------"

cmake --build .

Write-Output "---------------------------------------------------------------"

# If need install grpc
if ($install -eq $true) {
    cmake --install .
    Write-Output "---------------------------------------------------------------"
}
}
catch {
    Write-Error "Some shit happened"
}
finally {
    $endTime = Get-Date
    $buildTime = New-TimeSpan -Start $startTime -End $endTime
    Write-Output "Build completed in: $buildTime"
    
    popd
    Read-Host -Prompt "Press Enter to continue"
}
