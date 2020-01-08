set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5
    COMPONENTS
        Test
    REQUIRED
)

if(Qt5_FOUND AND TARGET Qt5::qmake AND NOT TARGET Qt5::deployqt AND (WIN32 OR APPLE))
    get_target_property(_qt5_qmake_location Qt5::qmake IMPORTED_LOCATION)

    execute_process(
        COMMAND "${_qt5_qmake_location}" -query QT_INSTALL_PREFIX
        RESULT_VARIABLE return_code
        OUTPUT_VARIABLE qt5_install_prefix
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(WIN32)
        set(deployqt_filename windeployqt.exe)
    elseif(APPLE)
        set(deployqt_filename macdeployqt)
    endif()
        
    set(imported_location "${qt5_install_prefix}/bin/${deployqt_filename}")

    if(EXISTS ${imported_location})
        add_executable(Qt5::deployqt IMPORTED)

        set_target_properties(Qt5::deployqt PROPERTIES
            IMPORTED_LOCATION ${imported_location}
        )
    endif()
endif()

add_subdirectory(auto)
if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/manual)
    add_subdirectory(manual)
endif()
