#!/bin/sh

# run from root folder
cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_TOOLCHAIN_FILE=cmake/gcc-arm-none-eabi.cmake \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=true \
    -DENABLE_CLANG_TIDY=ON \
    -DENABLE_CLANG_FORMAT=ON \
    -DENABLE_DOXYGEN=ON \
    # -DUSE_SANITIZER=Address,Leak \
    # -DENABLE_CODE_COVERAGE=ON