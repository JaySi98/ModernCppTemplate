cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# Prevention from building in the source directory
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed. Please make a build directory and run CMake from there.\n")
endif()

# ===========================
# Project options
# ===========================
include(cmake/pico_sdk_import.cmake)
include(cmake/package-managers.cmake)
include(cmake/doxygen.cmake)
include(cmake/compiler.cmake)
include(cmake/settings.cmake)
include(cmake/sources.cmake)
include(cmake/sanitizers.cmake)

message(STATUS "Started CMake for ${PROJECT_NAME} v${PROJECT_VERSION}...\n")

project(
    "Template" 
    VERSION 0.1.0 
)

# Set the compiler options
enable_language(C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

set(PICO_EXAMPLES_PATH ${PROJECT_SOURCE_DIR})

# ===========================
# adding exec/lib
# ===========================
pico_sdk_init()
add_executable(${PROJECT_NAME}  
    ${SOURCES}
)

if(ENABLE_UNIT_TESTING)
    add_library(${PROJECT_NAME}_LIB ${HEADERS} ${SOURCES})
endif()

# ===========================
# Project properties
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

target_link_libraries(${PROJECT_NAME} pico_stdlib)
pico_add_extra_outputs(${PROJECT_NAME})

message(STATUS "Successfully added all dependencies and linked against them.\n")

# ===========================
# Custom commands 
# ===========================
# add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
#     COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}>)

# add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
#     COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${PROJECT_NAME}>
#     ${PROJECT_NAME}.hex
#     COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}>
#     ${PROJECT_NAME}.bin)

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
