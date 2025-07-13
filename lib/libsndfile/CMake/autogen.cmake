# lib/libsndfile/CMake/autogen.cmake の内容を以下のように修正

# find_program (AUTOGEN autogen) # この行は残しても問題ないですが、使わないならコメントアウトしてもOK

# # 以下は全てコメントアウト、または削除
# # if (NOT DEFINED AUTOGEN)
# #     message (FATAL_ERROR "Need GNU autogen to generate '${dir}/${basefilename}.c'.")
# # endif ()

function (lsf_autogen dir basefilename)
    # Only generate the file if it does not already exist.
    if (NOT (EXISTS "${CMAKE_SOURCE_DIR}/${dir}/${basefilename}.c"))

        # # 以下は全てコメントアウト、または削除 (内側のチェック)
        # # if (NOT AUTOGEN)
        # #    message (FATAL_ERROR "Need GNU autogen to generate '${dir}/${basefilename}.c'.")
        # # endif ()

        # AUTOGENが定義されている（つまり見つかった）場合のみ、autogenを実行
        if (DEFINED AUTOGEN)
            execute_process (
                COMMAND ${AUTOGEN} --writable ${basefilename}.def
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/${dir}
                )
        else()
            message(WARNING "Skipping autogen process for '${dir}/${basefilename}.c' because 'autogen' program not found.")
        endif()
    endif ()
endfunction ()