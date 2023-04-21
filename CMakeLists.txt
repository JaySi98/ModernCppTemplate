cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

project(
    "Template" 
    VERSION 0.1.0 
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

# MCU settings - potential changes here
set(MCU_FAMILY STM32F4xx)
set(MCU_MODEL STM32F411xx)
set(CPU_PARAMETERS
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard)

# Set the compiler options
set(EXECUTABLE ${CMAKE_PROJECT_NAME})
enable_language(C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# ===========================
# adding exec/lib
# ===========================
add_executable(${PROJECT_NAME} 
    ${SOURCES} 
    ${STM32CUBEMX_SOURCES}
    ${STARTUP_SCRIPT}
)

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

target_compile_definitions(${PROJECT_NAME} PRIVATE
    ${MCU_MODEL}
    USE_HAL_DRIVER
)

target_compile_options(${PROJECT_NAME} PRIVATE
    ${CPU_PARAMETERS}
    $<$<COMPILE_LANGUAGE:CXX>:
        -Wno-volatile
        -Wold-style-cast
        -Wuseless-cast
        -Wsuggest-override>
    $<$<CONFIG:Debug>:-Og -g3 -ggdb>
    $<$<CONFIG:Release>:-Og -g0>
)

target_link_options(${PROJECT_NAME} PRIVATE
    -T${MCU_LINKER_SCRIPT}
    ${CPU_PARAMETERS}
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map
    --specs=nosys.specs
    -Wl,--start-group
    -lc
    -lm
    -lstdc++
    -Wl,--end-group
    -Wl,--print-memory-usage
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
    ${CUBEMX_INCLUDE_DIRECTORIES}
)

if(BUILD_EXECUTABLE AND ENABLE_UNIT_TESTING)
    target_include_directories(
        ${PROJECT_NAME}_LIB
        PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
        ${CUBEMX_INCLUDE_DIRECTORIES}
    )
endif()

message(STATUS "Finished setting up include directories.\n")

# ===========================
# Custom commands 
# ===========================
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}>)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${PROJECT_NAME}>
    ${PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}>
    ${PROJECT_NAME}.bin)

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
