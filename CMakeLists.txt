cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

project(
    "Template" 
    VERSION 0.1.0 
    LANGUAGES C
)

# Prevention from building in the source directory
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed. Please make a build directory and run CMake from there.\n")
endif()

# ===========================
# Project options
# ===========================
include(cmake/package-managers.cmake)
include(cmake/doxygen.cmake)
include(cmake/compiler.cmake)
include(cmake/settings.cmake)
include(cmake/utils.cmake)
include(cmake/sources.cmake)
include(cmake/sanitizers.cmake)

message(STATUS "Started CMake for ${PROJECT_NAME} v${PROJECT_VERSION}...\n")

# Set the compiler options
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")

# ===========================
# adding exec/lib
# ===========================
add_executable(${PROJECT_NAME} ${EXE_SOURCES})

if(ENABLE_UNIT_TESTING)
    add_library(${PROJECT_NAME}_LIB ${HEADERS} ${SOURCES})
endif()

# ===========================
# Project properties
# ===========================

set_target_properties(
  ${PROJECT_NAME}
  PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${CMAKE_BUILD_TYPE}"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${CMAKE_BUILD_TYPE}"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}"
)

if(BUILD_EXECUTABLE AND ENABLE_UNIT_TESTING)
    set_target_properties(
        ${PROJECT_NAME}_LIB
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${CMAKE_BUILD_TYPE}"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/${CMAKE_BUILD_TYPE}"
        OUTPUT_NAME ${PROJECT_NAME}
    )
endif()

message(STATUS "Added all header and implementation files.\n")

# ===========================
# Project standard and warnings
# ===========================
set_project_warnings(${PROJECT_NAME})

message(STATUS "Applied compiler warnings. Using standard C${CMAKE_C_STANDARD}.\n")

# ===========================
# Project dependencies
# ===========================

# find_package(package_name package_version REQUIRED package_type [other_options])
#target_link_libraries(
#  ${PROJECT_NAME}
#  PUBLIC
#    dependency1 ...
#  PRIVATE
#    dependency2 ...
#    PROJECT_OPTIONS
#    PROJECT_WARNINGS
#)

#if(BUILD_EXECUTABLE AND ENABLE_UNIT_TESTING)
#  target_link_libraries(
#    ${PROJECT_NAME}_LIB
#    PUBLIC
#      dependency1 ...
#  )
#endif()

# For Windows, it is necessary to link with the MultiThreaded library.
# On Linux and Mac this variable is ignored. 
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")

message(STATUS "Successfully added all dependencies and linked against them.\n")


# ===========================
# Set the build/user include directories
# ===========================
target_include_directories(
    ${PROJECT_NAME}
    PUBLIC
    $<INSTALL_INTERFACE:include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

if(BUILD_EXECUTABLE AND ENABLE_UNIT_TESTING)
    target_include_directories(
        ${PROJECT_NAME}_LIB
        PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
    )
endif()

message(STATUS "Finished setting up include directories.\n")

# ===========================
# Format the project using the `clang-format` target 
# ===========================
if(ENABLE_CLANG_FORMAT)
    add_clang_format_target()
endif()

# ===========================
# Unit testing
# ===========================
if(ENABLE_UNIT_TESTING)
    enable_testing()
    add_subdirectory(test)
endif()
