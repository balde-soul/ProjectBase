################################################################
# this fucntion make sure the file exist, and generate a target name
################################################################
function(touch_file touch_target generated_target_posefix url hash dir file_name)
    find_file(found_download_file ${${file_name}} ${${dir}})
    set(actual_download_command axel -k -n 10 -av ${${url}} -o ${${dir}}/${${file_name}})
    if(${found_download_file} STREQUAL "found_download_file-NOTFOUND")
        set(download_command ${actual_download_command})
    else()
        file(SHA256 ${${dir}}/${${file_name}} exist_sha)
        if(${exist_sha} STREQUAL ${${hash}})
            message(STATUS "${${file_name}} found in ${${dir}}")
            set(download_command )
        else()
            set(download_command ${actual_download_command})
        endif()
    endif()

    add_custom_target(touch_${${generated_target_posefix}} ALL COMMAND ${download_command})
    set(${touch_target} touch_${${generated_target_posefix}} PARENT_SCOPE)
endfunction(touch_file)

#function(touch_fold target_fold)
#    set(old_parent ${${target_fold}})
#    set(parent "")
#    while(NOT (${old_parent} STREQUAL ${parent}))
#        get_filename_component(parent ${${target_fold}} PATH)
#        find_path(temp )
#    endwhile()
#endfunction(touch_fold)


################################################################
# this function get the name of the file from the download url
################################################################
function(get_file_name_from_url file_name url)
    string(REPLACE "/" ";" split ${${url}})
    list(LENGTH split length)
    math(EXPR list_last "${length} - 1")
    list(GET split ${list_last} last_item)
    set(${file_name} ${last_item} PARENT_SCOPE)
    unset(split)
    unset(length)
endfunction(get_file_name_from_url)