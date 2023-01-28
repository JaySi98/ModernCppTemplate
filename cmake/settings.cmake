
# Project options
option(BUILD_EXECUTABLE     "Build the project as an executable, rather than a library." OFF)
option(BUILD_HEADERS_ONLY   "Build the project as a header-only library."                OFF)

# Compiler options
option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors." OFF)

# Package managers options(Conan, Vcpkg)
option(ENABLE_CONAN "Enable the Conan package manager for this project." OFF)
option(ENABLE_VCPKG "Enable the Vcpkg package manager for this project." OFF)

# Unit testing options(GoogleTest, Catch2)
option(ENABLE_UNIT_TESTING  "Enable unit tests for the projects (from the `test` subfolder)." ON)
option(USE_GTEST            "Use the GoogleTest project for creating unit tests."             ON)
option(USE_GOOGLE_MOCK      "Use the GoogleMock project for extending the unit tests."        ON)
option(USE_CATCH2           "Use the Catch2 project for creating unit tests."                 OFF)

# Static analyzers options(Clang-Tidy, Cppcheck)
option(ENABLE_CLANG_TIDY    "Enable static analysis with Clang-Tidy." OFF)
option(ENABLE_CPPCHECK      "Enable static analysis with Cppcheck."   OFF)

# Code coverage options
option(ENABLE_CODE_COVERAGE "Enable code coverage through GCC."       ON)

# Doxygen
option(ENABLE_DOXYGEN       "Enable Doxygen documentation builds of source." OFF)

# CCCACHE options
option(ENABLE_CCACHE "Enable the usage of Ccache, in order to speed up rebuild times." ON)
find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif()

# Address Sanitizers options
option(ENABLE_ASAN "Enable Address Sanitize to detect memory error." OFF)
if(ENABLE_ASAN)
    add_compile_options(-fsanitize=address)
    add_link_options(-fsanitize=address)
endif()

# Generate compile_commands.json for clang based tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Export all symbols when building a shared library
if(BUILD_SHARED_LIBS)
  set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
  set(CMAKE_CXX_VISIBILITY_PRESET hidden)
  set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
endif()
