# ############################################################### #
# Args:
#   Option:
#       IF_DIFFERENT        copy files if different (optional)
#   One arg:
#       TARGET              files will be copied before build this target
#       DESTINATION         folder destination
#   Multi args:
#       FILES_PATTERNS      files for copy, regex supported
# ############################################################### #
function(copy_files_before_build)
    set(options IF_DIFFERENT)
    set(oneValueArgs TARGET DESTINATION)
    set(multiValueArgs FILES_PATTERNS)
    cmake_parse_arguments(BH "${options}" "${oneValueArgs}" "${multiValueArgs}" "${ARGN}")

    file(GLOB FILES ${BH_FILES_PATTERNS})

    set(_COMMAND copy)
    if (${BH_IF_DIFFERENT})
        set(_COMMAND copy_if_different)
    endif()

    set(COPY_TARGETS "")

    foreach(FILE ${BH_FILES_PATTERNS})
        get_filename_component(CURRENT_TARGET ${FILE} NAME_WE)
        add_custom_target(${CURRENT_TARGET}
            COMMAND ${CMAKE_COMMAND} -E ${_COMMAND} "${FILE}" "${BH_DESTINATION}")

        set(COPY_TARGETS ${COPY_TARGETS} ${CURRENT_TARGET})
    endforeach()

    add_dependencies(${BH_TARGET} ${COPY_TARGETS})
endfunction()

# ############################################################### #
# Args:
#   Multi args:
#       FILES_PATTERNS      files for copy, regex supported
# ############################################################### #
function(prepend)
    set(options "")
    set(oneValueArgs PREFIX OUT)
    set(multiValueArgs FILES)
    cmake_parse_arguments(BH "${options}" "${oneValueArgs}" "${multiValueArgs}" "${ARGN}")

    set(SOURCE_FILES "")

    foreach(SOURCE_FILE ${BH_FILES})
        set(SOURCE_FILES "${SOURCE_FILES}" "${BH_PREFIX}/${SOURCE_FILE}")
    endforeach()

    set(${BH_OUT} "${SOURCE_FILES}" PARENT_SCOPE)
endfunction()
