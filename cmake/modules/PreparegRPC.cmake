# Find components
find_package(ZLIB REQUIRED)
find_package(c-ares CONFIG REQUIRED)
find_package(Protobuf CONFIG REQUIRED)
find_package(gRPC CONFIG REQUIRED)

# Configure executables
get_property(PROTOC_EXECUTABLE TARGET protobuf::protoc PROPERTY LOCATION)
get_property(GRPC_PLUGIN_EXECUTABLE TARGET gRPC::grpc_cpp_plugin PROPERTY LOCATION)
