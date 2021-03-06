include(popular_message)
cmakelists_base_header()

include(obj_name_provide)
set(module CodecTest)
set(codec_test_module_name ${module} CACHE INTERNAL "module name")
obj_name_provide(CMAKE_BUILD_TYPE project_base_build_shared_lib module)

 # generate executable
set(CMAKE_CXX_FLAGS "-DPROJECT_BASE_FUNCTION=1 ${CMAKE_CXX_FLAGS}")

file(GLOB test_${module}_src *.h *.cc)
debug_the_src_with_abspath(test_${module}_src)
add_executable(${${codec_test_module_name}_target_name} ${test_${module}_src})
target_link_libraries(${${codec_test_module_name}_target_name} ${${codec_module_name}_target_name})
target_link_libraries(${${codec_test_module_name}_target_name} ${${tensor_module_name}_target_name})
target_link_libraries(${${codec_test_module_name}_target_name} ${${boost_module_name}_target_name})

# install multilanguage
## header
file(GLOB ${module}_install_heads *.hpp)
message(DEBUG "the install header of the lib: ${${module}_install_heads}")
install(FILES ${${module}_install_heads} DESTINATION  ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME}/${module})

## obj
install(
    TARGETS
    ${${codec_test_module_name}_target_name}
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin 
    LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

