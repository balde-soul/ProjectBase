set(external_install_path ${CMAKE_CURRENT_BINARY_DIR}/install CACHE STRING "the path for installing the external")
option(external_build_shared "the lib link type for building the external" ON)
set(external_download_dir ${CMAKE_CURRENT_BINARY_DIR} CACHE STRING "the dir for download the source of the third party repo")

##################################################################
# this macro set the project version selected variable tab
# project: the name of the project
# all_version: the versions which the process supported and can be choose
# default_version: the default version which we supported
#
# what we can get after this macro: we get the variable ${project}_version
##################################################################
macro(version_selector project all_version default_version)
    set(${project}_all_version ${${all_version}})
    set(${project}_version ${default_version} CACHE STRING "${project} version")
    set_property(CACHE ${project}_version PROPERTY STRINGS ${${project}_all_version})
endmacro(version_selector)

##################################################################
# this macro find the matched tag for the project which is in the git
# project: the name of the project
# supported_version: the versions which the process supported or the project has
# supported_tag: the tags which corresponding to the supported_version
# version: the version which user choose for the project
#
# what we can get after this macro: we get the variable ${project}_tag
##################################################################
macro(version_tag_matcher project supported_version supported_tag version)
    if(${${version}} IN_LIST ${supported_version})
        list(LENGTH ${supported_version} ${project}_supported_version_length)
        list(LENGTH ${supported_tag} ${project}_supported_tag_length)
        if(${${project}_supported_version_length} EQUAL ${${project}_supported_tag_length})
            list(FIND ${supported_version} ${${version}} matched_index)
            if(NOT(${matched_index} EQUAL -1))
                list(GET ${supported_tag} ${matched_index} matched_tag)
                if(NOT(matched_tag EQUAL -1))
                    message(STATUS "find tag ${matched_tag} for ${project}")
                    set(${project}_tag ${matched_tag})
                else()
                    message(FATAL_ERROR "index: ${matched_index} not in supported_tag: ${${supported_tag}}")
                endif()
            else()
                message(FATAL_ERROR "can not find ${${version}} in supported_version: ${${supported_version}}")
            endif()
        else()
            message(FATAL_ERROR "${${project}} supported_version: ${${supported_version}} vs. supported_tag: ${${supported_tag}} , should be in same length")
        endif()
    else()
        message(FATAL_ERROR "version of ${${project}}: ${${version}} is not in the supported_version: ${${supported_version}}")
    endif()
endmacro(version_tag_matcher)

##################################################################
# this macro
##################################################################
macro(external_project_build_type project supported_build_type default_build_type)
    list(FIND ${supported_build_type} ${${default_build_type}} index)
    if(${index} EQUAL -1)
        message(FATAL_ERROR "default_build_type: ${${default_build_type}} is not in the supported_build_type: ${${supported_build_type}}")
    endif()
    set(${project}_build_type ${${default_build_type}} CACHE STRING "the specifical option for gtest, if the gtest_build_type is set")
    set_property(CACHE ${project}_build_type PROPERTY STRINGS ${${supported_build_type}})
    if(gtest_build_type STREQUAL "FOLLOW_CMAKE_BUILD_TYPE")
        set(gtest_build_type ${CMAKE_BUILD_TYPE})
    elseif(${${project}_build_type} IN_LIST ${supported_build_type})
    else()
        message(FATAL_ERROR "unsupported gtest_build_type: ${${project}_build_type}")
    endif()
endmacro(external_project_build_type)

macro(default_external_project_build_type project)
    list(APPEND supported_build_type "FOLLOW_CMAKE_BUILD_TYPE" "Release" "Debug")
    set(default_build_type "FOLLOW_CMAKE_BUILD_TYPE")
    external_project_build_type(${project} supported_build_type default_build_type)
endmacro(default_external_project_build_type)