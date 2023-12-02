# ModernCppTemplate 

### About 
This project is an attempt to create template for C/C++ projects using modern cmake. It's designed to suit my personal requirements, but it might be useful for other developers too. 

## Requirements 
In order to be able to work with this template, you will need: 
* CMake - version 3.15 and above 
* GCC Compiler 
* Doxygen - for ability to generate docs
    sudo apt-get install doxygen doxygen-doc graphviz 
* cmocka test framework
* arm-none-eabi-gcc compiler
    https://askubuntu.com/questions/1243252/how-to-install-arm-none-eabi-gdb-on-ubuntu-20-04-lts-focal-fossa
    https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
    https://askubuntu.com/questions/1031103/how-can-i-install-gdb-arm-none-eabi-on-ubuntu-18-04-bionic-beaver
* stlink-tools
    sudo apt install stlink-tools

## Getting Started 
1. Change project name in CmakeLists.txt
2. If used on different MCU: change all files inside cubeMX folder by files and add appropiate changes inside cmake/sources.cmake
3. Add new header and source files to cmake/sources.cmake
4. Compile, build and run

## Commands 
how to: 

2. build 
cmake -S . -B build/ 
cmake --build build 

4. generate documentation
cmake .. -DENABLE_DOXYGEN=1
cmake --build . --target doxygen-docs
xdg-open docs/html/index.html 

5. run tests
./build/test/UnitTests
cd build && ctest -C -VV Debug

6. upload to board
st-flash write build/Template.bin 0x8000000

7. probe board
    st-info --probe

8. read binary from board
    st-flash read dummy.bin 0 0xFFFF


## Datasheets
1.Board Manual:
- 23 - LEDs
- 32 - Pinout