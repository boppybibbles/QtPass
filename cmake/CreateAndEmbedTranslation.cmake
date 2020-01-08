function(generate_qrc QRC_FILE QM_FILES)
    # mimic QMake's `embed_translations` behavior
    #TODO: implement via `configure_file`
    set(file ${CMAKE_CURRENT_BINARY_DIR}/qmake_qmake_qm_files.qrc)

    file(WRITE ${file}
        "<!DOCTYPE RCC><RCC version=\"1.0\">\n"
        "<qresource prefix=\"/localization\">\n"
    )

    foreach(QM_FILE IN LISTS QM_FILES)
        get_filename_component(QM_FILENAME ${QM_FILE} NAME)
        file(APPEND ${file}
            "<file alias=\"${QM_FILENAME}\">${QM_FILE}</file>\n"
        )
    endforeach()

    file(APPEND ${file}
        "</qresource>\n"
        "</RCC>\n"
    )
    set(${QRC_FILE} ${file} PARENT_SCOPE)
endfunction()

function(create_and_embed_translation TARGET INPUT_FILES)
    qt5_create_translation(QM_FILES ${INPUT_FILES}
#        OPTIONS
#            -locations none
#            -no-ui-lines
    )
    generate_qrc(QRC_FILE "${QM_FILES}")
    target_sources(${TARGET} PRIVATE ${QRC_FILE})
endfunction()
