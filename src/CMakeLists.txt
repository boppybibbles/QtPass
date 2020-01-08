cmake_minimum_required(VERSION 3.15)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5
    COMPONENTS
        Widgets
        LinguistTools
    REQUIRED
)

if (ENABLE_SINGLE_APP)
    find_package(Qt5
        COMPONENTS
            Network
        REQUIRED
    )
endif()

add_library(qtpasslib OBJECT)
add_library(qtpass::lib ALIAS qtpasslib)

set(TS_FILES
    ${CMAKE_SOURCE_DIR}/localization/localization_ar_MA.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_ca.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_cs_CZ.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_de_DE.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_de_LU.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_el_GR.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_en_GB.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_en_US.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_es_ES.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_fr_BE.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_fr_FR.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_fr_LU.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_gl_ES.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_he_IL.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_hu_HU.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_it_IT.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_lb_LU.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_nb_NO.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_nl_BE.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_nl_NL.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_pl_PL.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_pt_PT.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_ru_RU.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_sq_AL.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_sv_SE.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_tr_TR.ts
    ${CMAKE_SOURCE_DIR}/localization/localization_zh_CN.ts
)

include(CreateAndEmbedTranslation)
create_and_embed_translation(qtpasslib "${CMAKE_SOURCE_DIR};${TS_FILES}")

target_sources(qtpasslib
    PRIVATE
        configdialog.cpp
        configdialog.h
        configdialog.ui
        debughelper.h
        deselectabletreeview.h
        enums.h
        executor.cpp
        executor.h
        filecontent.cpp
        filecontent.h
        imitatepass.cpp
        imitatepass.h
        keygendialog.cpp
        keygendialog.h
        keygendialog.ui
        mainwindow.cpp
        mainwindow.h
        mainwindow.ui
        pass.cpp
        pass.h
        passwordconfiguration.h
        passworddialog.cpp
        passworddialog.h
        passworddialog.ui
        qprogressindicator.cpp
        qprogressindicator.h
        qpushbuttonasqrcode.cpp
        qpushbuttonasqrcode.h
        qpushbuttonwithclipboard.cpp
        qpushbuttonwithclipboard.h
        qtpass.cpp
        qtpass.h
        qtpasssettings.cpp
        qtpasssettings.h
        realpass.cpp
        realpass.h
        settingsconstants.cpp
        settingsconstants.h
        simpletransaction.cpp
        simpletransaction.h
        $<$<BOOL:${ENABLE_SINGLE_APP}>:singleapplication.cpp>
        $<$<BOOL:${ENABLE_SINGLE_APP}>:singleapplication.h>
        storemodel.cpp
        storemodel.h
        trayicon.cpp
        trayicon.h
        userinfo.h
        usersdialog.cpp
        usersdialog.h
        usersdialog.ui
        util.cpp
        util.h
    PRIVATE
        ${CMAKE_SOURCE_DIR}/resources.qrc
        ${QM_FILES}
        $<$<PLATFORM_ID:Windows>:${CMAKE_SOURCE_DIR}/windows.rc>
)

target_include_directories(qtpasslib
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(qtpasslib
    PUBLIC
       SINGLE_APP=$<BOOL:${ENABLE_SINGLE_APP}>
       VERSION="${PROJECT_VERSION}"
       $<$<PLATFORM_ID:Windows>:WINSTORE=1>
       $<$<CONFIG:Release>:QT_DEBUG_NO_OUTPUT>
)

target_compile_options(qtpasslib
    PUBLIC
        $<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/W3>
    PUBLIC
        $<$<OR:$<COMPILE_LANG_AND_ID:CXX,Clang>,$<COMPILE_LANG_AND_ID:CXX,GNU>>:-Wall>
)

target_link_options(qtpasslib
    PUBLIC
# enabled by default
#        $<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/DYNAMICBASE>
#        $<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/NXCOMPAT>
    PUBLIC
        $<$<AND:$<PLATFORM_ID:Windows>,$<COMPILE_LANG_AND_ID:CXX,GNU>>:LINKER:--nxcompat>
        $<$<AND:$<PLATFORM_ID:Windows>,$<COMPILE_LANG_AND_ID:CXX,GNU>>:LINKER:--dynamicbase>
)

target_compile_features(qtpasslib
    PUBLIC
        cxx_auto_type
)

target_link_libraries(qtpasslib
    PUBLIC
        Qt5::Widgets
        $<$<BOOL:${ENABLE_SINGLE_APP}>:Qt5::Network>
        $<$<PLATFORM_ID:Windows>:Mpr>
)
