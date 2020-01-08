## Building the TBB examples is optional. set this to TRUE if you
## want to build the examples
set(BUILD_TBB_EXAMPLES FALSE)
set(TBB_PREFIX tbb44)
set(TBB_URL ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/tbb44_20160316oss_src.tgz)
set(TBB_URL_MD5 1908b8901730fa1049f0c45d8d0e6d7d)

if (WIN32)
	set(TBB_MAKE gmake) ## you can set the full path to the file here
else (WIN32)
	set(TBB_MAKE make)
endif (WIN32)

# set the number of CPUs used for compiling to 8 or 4 or as many as you
# have in your system.
set(NCPU 8)

# add instructions to build the TBB source
if (BUILD_TBB_EXAMPLES)
	set(TBB_EXAMPLES_STEP ${TBB_PREFIX}_examples
endif (BUILD_TBB_EXAMPLES)
ExternalProject_Add(${TBB_PREFIX}
	PREFIX ${TBB_PREFIX}
	URL ${TBB_URL}
	URL_MD5 ${TBB_URL_MD5}
	CONFIGURE_COMMAND ""
	BUILD_COMMAND  ${TBB_MAKE} -j${NCPU} tbb_build_prefix=${TBB_PREFIX}
	BUILD_IN_SOURCE 1
	INSTALL_COMMAND ""
	LOG_DOWNLOAD 1
	LOG_BUILD 1
	STEP_TARGETS ${TBB_PREFIX}_info ${TBB_EXAMPLES_STEP}
)

# get the unpacked source directory path
ExternalProject_Get_Property(${TBB_PREFIX} SOURCE_DIR)
message(STATUS "Source directory of ${TBB_PREFIX} ${SOURCE_DIR}")
# build another dependency
ExternalProject_Add_Step(${TBB_PREFIX} ${TBB_PREFIX}_info
	COMMAND ${TBB_MAKE} info tbb_build_prefix=${TBB_PREFIX}
	DEPENDEES build
	WORKING_DIRECTORY ${SOURCE_DIR}
	LOG 1
) 
        
# build the examples if you're interested
if (BUILD_TBB_EXAMPLES)
	ExternalProject_Add_Step(${TBB_PREFIX} ${TBB_PREFIX}_examples
	  COMMAND make -j${NCPU} examples tbb_build_prefix=${TBB_PREFIX}
	  DEPENDEES build
	  WORKING_DIRECTORY ${SOURCE_DIR}
	  LOG 1
	)
endif (BUILD_TBB_EXAMPLES)
# Set separate directories for building in Debug or Release mode
set(TBB_DEBUG_DIR ${SOURCE_DIR}/build/${TBB_PREFIX}_debug)
set(TBB_RELEASE_DIR ${SOURCE_DIR}/build/${TBB_PREFIX}_release)
message(STATUS "TBB Debug directory ${TBB_DEBUG_DIR}")
message(STATUS "TBB Release directory ${TBB_RELEASE_DIR}")

# set the include directory variable and include it
set(TBB_INCLUDE_DIRS ${SOURCE_DIR}/include)
include_directories(${TBB_INCLUDE_DIRS})

# link the correct TBB directory when the project is in Debug or Release mode
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
	# in Debug mode
	link_directories(${TBB_RELEASE_DIR})
	set(TBB_LIBS tbb_debug tbbmalloc_debug)
	set(TBB_LIBRARY_DIRS ${TBB_DEBUG_DIR})
else (CMAKE_BUILD_TYPE STREQUAL "Debug")
	# in Release mode
	link_directories(${TBB_RELEASE_DIR})
	set(TBB_LIBS tbb tbbmalloc)
	set(TBB_LIBRARY_DIRS ${TBB_RELEASE_DIR})
endif (CMAKE_BUILD_TYPE STREQUAL "Debug")

# verify that the TBB header files can be included
set(CMAKE_REQUIRED_INCLUDES_SAVE ${CMAKE_REQUIRED_INCLUDES})
set(CMAKE_REQUIRED_INCLUDES ${CMAKE_REQUIRED_INCLUDES} 	${TBB_INCLUDE_DIRS})
check_include_file_cxx("tbb/tbb.h" HAVE_TBB)
set(CMAKE_REQUIRED_INCLUDES ${CMAKE_REQUIRED_INCLUDES_SAVE})
 if (NOT HAVE_TBB)
	message(STATUS "Did not build TBB correctly as cannot find tbb.h. Will build it.")
	set(HAVE_TBB 1)
endif (NOT HAVE_TBB)
        
# Optional: install the TBB libraries when the application being built gets installed
# when you run "make install"
if (UNIX)
	install(DIRECTORY ${TBB_LIBRARY_DIRS}/ DESTINATION lib
     	USE_SOURCE_PERMISSIONS FILES_MATCHING PATTERN "*.so*")
else (UNIX)
	## Similarly for Windows.
endif (UNIX)