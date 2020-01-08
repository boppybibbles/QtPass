cmake_minimum_required(VERSION 3.12)

project(QtPass
    VERSION 1.3.2
    DESCRIPTION "QtPass is a GUI for pass, the standard unix password manager."
    HOMEPAGE_URL "https://qtpass.org"
    LANGUAGES CXX
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

option(ENABLE_SINGLE_APP "Enable multiple simultaneous application instances" ON)
option(ENABLE_STATIC "Link application statically" OFF)

add_subdirectory(src)
add_subdirectory(main)

include(CTest)
add_subdirectory(tests)

include(CPack)
