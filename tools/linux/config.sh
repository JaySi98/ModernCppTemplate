#!/bin/sh

# run from root folder
cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DENABLE_UNIT_TESTING=OFF \
    -DWARNINGS_AS_ERRORS=ON \
    -DENABLE_DOXYGEN=ON \
    # -DUSE_SANITIZER=Address,Leak \