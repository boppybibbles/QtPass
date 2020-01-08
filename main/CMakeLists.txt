cmake_minimum_required(VERSION 3.15)

add_executable(qtpass WIN32 MACOSX_BUNDLE)

#if (APPLE)
#    set_target_properties(qtpass PROPERTIES OUTPUT_NAME QtPass)
#endif()

target_sources(qtpass
    PRIVATE
        main.cpp
)

target_link_options(qtpass
    PRIVATE
        $<$<AND:$<BOOL:${ENABLE_STATIC}>,$<OR:$<COMPILE_LANG_AND_ID:CXX,GNU>,$<COMPILE_LANG_AND_ID:CXX,Clang>>>:-static>
        $<$<AND:$<BOOL:${ENABLE_STATIC}>,$<COMPILE_LANG_AND_ID:CXX,MSVC>>:/INCREMENTAL:NO>
        $<$<AND:$<BOOL:${ENABLE_STATIC}>,$<COMPILE_LANG_AND_ID:CXX,MSVC>>:/NODEFAULTLIB:MSVCRT>
)

target_link_libraries(qtpass
    PRIVATE
        qtpass::lib
)

include(GNUInstallDirs)
install(TARGETS qtpass
    RUNTIME
        DESTINATION ${CMAKE_INSTALL_BINDIR}
    BUNDLE
        DESTINATION ${CMAKE_INSTALL_BINDIR}
)
