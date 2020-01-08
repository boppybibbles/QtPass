cmake_minimum_required(VERSION 3.15)

add_executable(tst_util
   WIN32
#   MACOSX_BUNDLE
)

target_sources(tst_util
    PRIVATE
        tst_util.cpp
)

target_link_libraries(tst_util
    PRIVATE
        qtpass::lib
        Qt5::Test
)

include(GNUInstallDirs)
install(TARGETS tst_util
    RUNTIME
        DESTINATION ${CMAKE_INSTALL_BINDIR}
    BUNDLE
        DESTINATION ${CMAKE_INSTALL_BINDIR}
)

add_test(util tst_util)
