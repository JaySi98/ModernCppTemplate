cmake_minimum_required(VERSION 3.15)

project(${CMAKE_PROJECT_NAME}Tests LANGUAGES C)

message(STATUS "Adding tests under ${CMAKE_PROJECT_NAME}Tests...")

# include(FetchCmocka.cmake)
find_package(cmocka REQUIRED)

add_executable(UnitTests ${TEST_SOURCES})

if(BUILD_EXECUTABLE)
	set(${CMAKE_PROJECT_NAME}_TEST_LIB ${CMAKE_PROJECT_NAME}_LIB)
else()
	set(${CMAKE_PROJECT_NAME}_TEST_LIB ${CMAKE_PROJECT_NAME})
endif()

target_compile_features(UnitTests PRIVATE c_std_99)
target_link_libraries(UnitTests PUBLIC cmocka ${${CMAKE_PROJECT_NAME}_TEST_LIB})

add_test(UnitTests UnitTests)

message(STATUS "Finished adding unit tests for ${CMAKE_PROJECT_NAME}.\n")
