include(BuildHelpers)

set(SUBPROJ_NAME                          app)

set(${SUBPROJ_NAME}_CXX_STANDARD          17)
set(${SUBPROJ_NAME}_CXX_EXTENSIONS        OFF)
set(${SUBPROJ_NAME}_CXX_STANDARD_REQUIRED YES)

set(${SUBPROJ_NAME}_MAJOR_VERSION         0)
set(${SUBPROJ_NAME}_MINOR_VERSION         0)
set(${SUBPROJ_NAME}_PATCH_VERSION         1)

# Insert here your source files
set(${SUBPROJ_NAME}_HEADERS
    "")

set(${SUBPROJ_NAME}_SOURCES
    "main.cpp")

qt5_add_resources(${SUBPROJ_NAME}_RESOURCES
    "${PROJECT_ROOT_DIR}/res/app.qrc")

# ############################################################### #
# Options ####################################################### #
# ############################################################### #

include(OptionHelpers)
generate_basic_options_executable(${SUBPROJ_NAME})

# Insert here your specififc options for build:
# .............................................

# ############################################################### #
# Set all target sources ######################################## #
# ############################################################### #

set(
    ${SUBPROJ_NAME}_ALL_SRCS
    ${${SUBPROJ_NAME}_HEADERS}
    ${${SUBPROJ_NAME}_SOURCES}
    ${${SUBPROJ_NAME}_RESOURCES})

# ############################################################### #
# Create target for build ####################################### #
# ############################################################### #

add_executable(
    ${SUBPROJ_NAME}
    ${${SUBPROJ_NAME}_ALL_SRCS})

# Enable C++17 on this project
set_target_properties(
    ${SUBPROJ_NAME} PROPERTIES
    CXX_STANDARD          ${${SUBPROJ_NAME}_CXX_STANDARD}
    CXX_EXTENSIONS        ${${SUBPROJ_NAME}_CXX_EXTENSIONS}
    CXX_STANDARD_REQUIRED ${${SUBPROJ_NAME}_CXX_STANDARD_REQUIRED})
    
# Set specific properties
set_target_properties(
    ${SUBPROJ_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin"
    ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib"
    OUTPUT_NAME              "${SUBPROJ_NAME}$<$<CONFIG:Debug>:d>")

# Set version
set_target_properties(
    ${SUBPROJ_NAME} PROPERTIES
    VERSION ${${SUBPROJ_NAME}_MAJOR_VERSION}.${${SUBPROJ_NAME}_MINOR_VERSION}.${${SUBPROJ_NAME}_PATCH_VERSION})
    
# Set include directories for this project and if it will use as installing
target_include_directories(
    ${SUBPROJ_NAME}
    PRIVATE   $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>)

# Link qt
# Configure Qt behaviour
set_target_properties(
    ${SUBPROJ_NAME} PROPERTIES
    CMAKE_AUTOMOC ON
    CMAKE_AUTORCC ON)

target_link_libraries(${SUBPROJ_NAME} PRIVATE Qt5::Core Qt5::Quick Qt5::Widgets)

# Link core
target_link_libraries(${SUBPROJ_NAME} PRIVATE core)

# ############################################################### #
# Commands ###################################################### #
# ############################################################### #

prepend(OUT ${SUBPROJ_NAME}_TRANSLATION_TARGETS
    PREFIX ${CMAKE_CURRENT_SOURCE_DIR}
    FILES
        ${${SUBPROJ_NAME}_HEADERS}
        ${${SUBPROJ_NAME}_SOURCES})

if (WIN32)
    add_custom_command(TARGET ${SUBPROJ_NAME} PRE_BUILD
        COMMAND "${CMAKE_COMMAND}" -E
        env PATH="${_qt_bin_dir}" "${LUPDATE_EXECUTABLE}"
        ${PROJECT_ROOT_DIR}/res/${SUBPROJ_NAME}.qrc
        ${${SUBPROJ_NAME}_TRANSLATION_TARGETS}
        -ts
        ${PROJECT_ROOT_DIR}/res/translations/main_ru.ts
        ${PROJECT_ROOT_DIR}/res/translations/main_en.ts)

    add_custom_command(TARGET ${SUBPROJ_NAME} PRE_BUILD
        COMMAND "${CMAKE_COMMAND}" -E
        env PATH="${_qt_bin_dir}" "${LRELEASE_EXECUTABLE}"
        ${PROJECT_ROOT_DIR}/res/translations/main_ru.ts
        ${PROJECT_ROOT_DIR}/res/translations/main_en.ts)

    add_custom_command(TARGET ${SUBPROJ_NAME} POST_BUILD
        COMMAND "${CMAKE_COMMAND}" -E
        env PATH="${_qt_bin_dir}" "${WINDEPLOYQT_EXECUTABLE}"
        --verbose 0
        --no-compiler-runtime
        --qmldir "${PROJECT_ROOT_DIR}/res"
        \"$<TARGET_FILE:${SUBPROJ_NAME}>\"
        COMMENT "Deploying Qt..."
        )
endif()

# ############################################################### #
# Installing #################################################### #
# ############################################################### #

# Create export targets
install(
    TARGETS ${SUBPROJ_NAME}
    EXPORT  ${SUBPROJ_NAME}-targets)

# Set out paths
install(
    TARGETS ${SUBPROJ_NAME}
    RUNTIME DESTINATION  ${${SUBPROJ_NAME}_INSTALL_BIN_PREFIX}
    ARCHIVE DESTINATION  ${${SUBPROJ_NAME}_INSTALL_LIB_PREFIX}
    LIBRARY DESTINATION  ${${SUBPROJ_NAME}_INSTALL_LIB_PREFIX})
