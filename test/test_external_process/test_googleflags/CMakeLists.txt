cmake_minimum_required(VERSION 3.5)
project(test_googleflags)

get_filename_component(test_external_process_dir ${test_googleflags_SOURCE_DIR} PATH)
get_filename_component(test_dir ${test_external_process_dir} PATH)
get_filename_component(src_dir ${test_dir} PATH)

set(CMAKE_MODULE_PATH ${src_dir}/external_process/ ${CMAKE_MODULE_PATH})
include(cmake_module_set)
message("module_path: ${CMAKE_MODULE_PATH}")
include(external_setting)
include(gflags)

set(sources "${${PROJECT_NAME}_SOURCE_DIR}/test_gflags.cpp")
add_executable(${PROJECT_NAME} ${sources})
target_link_libraries(${PROJECT_NAME} ${gflags_target_name})
add_dependencies(${PROJECT_NAME} ${gflags_target_name})