cmake_minimum_required(VERSION 3.15)

add_executable(tst_ui
   WIN32
#   MACOSX_BUNDLE
)

target_sources(tst_ui
    PRIVATE
        tst_ui.cpp
)

target_link_libraries(tst_ui
    PRIVATE
        qtpass::lib
        Qt5::Test
)

if(TARGET Qt5::deployqt)
    # execute windeployqt in a tmp directory after build
    if (WIN32)
        set(DEPLOYQT_COMMAND Qt5::deployqt "$<TARGET_FILE_DIR:tst_ui>/$<TARGET_FILE_NAME:tst_ui>")
        #set(DEPLOYQT_COMMAND Qt5::deployqt --dir "$<TARGET_FILE_DIR:tst_ui>" "$<TARGET_FILE_DIR:tst_ui>/$<TARGET_FILE_NAME:tst_ui>")
    elseif(APPLE)
        set(DEPLOYQT_COMMAND Qt5::deployqt "$<TARGET_FILE_DIR:tst_ui>/../.." -always-overwrite)
    endif()
  
    add_custom_command(TARGET tst_ui
        POST_BUILD
        #COMMAND ${CMAKE_COMMAND} -E remove_directory "${CMAKE_CURRENT_BINARY_DIR}/deployqt"
        #COMMAND set PATH=%PATH%$<SEMICOLON>${qt5_install_prefix}/bin
        COMMAND ${DEPLOYQT_COMMAND}
    )

    # copy deployment directory during installation
    #install(
    #    DIRECTORY
    #    "${CMAKE_CURRENT_BINARY_DIR}/windeployqt/"
    #    DESTINATION ${FOO_INSTALL_RUNTIME_DESTINATION}
    #)
endif()

include(GNUInstallDirs)
install(TARGETS tst_ui
    RUNTIME
        DESTINATION ${CMAKE_INSTALL_BINDIR}
#    BUNDLE
#        DESTINATION ${CMAKE_INSTALL_BINDIR}
)

add_test(ui tst_ui --platform offscreen)
