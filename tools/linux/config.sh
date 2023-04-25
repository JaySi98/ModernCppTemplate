#!/bin/sh

# run from root folder
cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_TOOLCHAIN_FILE=cmake/gcc-arm-none-eabi.cmake \
    -DENABLE_DOXYGEN=ON \
    # -DUSE_SANITIZER=Address,Leak \