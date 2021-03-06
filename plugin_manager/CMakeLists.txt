include(popular_message)
cmakelists_base_header()

include(obj_name_provide)
set(module PluginManager)
set(plugin_manager_module_name ${module} CACHE INTERNAL "module name")
obj_name_provide(CMAKE_BUILD_TYPE project_base_build_shared_lib module)

 #生成链接库
aux_source_directory(. ${module}_files)
set(CMAKE_CXX_FLAGS "-DPROJECT_BASE_FUNCTION=1 ${CMAKE_CXX_FLAGS}")
set(${module}_lib_src_reg *.h *.hpp *.cpp *.cc)
file(GLOB ${module}_lib_src ${${module}_lib_src_reg})
message(DEBUG "${${module}_target_name}: ")
debug_the_src_with_abspath(${module}_lib_src)
add_library(${${module}_target_name} ${${module}_build_link_type} ${${module}_lib_src})
target_link_libraries(${${module}_target_name} PUBLIC ${boost_target_name})
add_dependencies(${${module}_target_name} ${boost_target_name})

include(test_engineer_config)
build_test_option(${module})
message(DEBUG "build_test: ${_build_${module}_test}")
if(_build_${module}_test)
    add_subdirectory(plugin_manager_test)
else()
endif()

# install plugin_manager
## header
file(GLOB ${module}_install_heads *.hpp)
message(DEBUG "the install header of the lib: ${${module}_install_heads}")
install(FILES ${${module}_install_heads} DESTINATION  ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME}/${module})

## obj
install(
    TARGETS
    ${${module}_target_name}
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)