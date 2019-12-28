# Find components
find_package(Qt5 COMPONENTS Core Quick Widgets REQUIRED)

# Configure qt search environment
get_target_property(_qmake_executable Qt5::qmake IMPORTED_LOCATION)
get_filename_component(_qt_bin_dir "${_qmake_executable}" DIRECTORY)

# Deployment
find_program(WINDEPLOYQT_EXECUTABLE windeployqt HINTS "${_qt_bin_dir}")

# Localization generators
find_program(LUPDATE_EXECUTABLE lupdate HINTS "${_qt_bin_dir}")
find_program(LRELEASE_EXECUTABLE lrelease HINTS "${_qt_bin_dir}")
