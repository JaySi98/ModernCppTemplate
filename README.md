# ModernCppTemplate 

### About 
This project is an attempt to create template for C/C++ projects using modern cmake. It's designed to suit my personal requirements, but it might be useful for other developers too. 
### Acknowledgements 
This project is mostly a combination of other templates listed below: 
* https://github.com/filipdutescu/modern-cpp-template 
* https://github.com/TheLartians/ModernCppStarter 
* https://github.com/pabloariasal/modern-cmake-sample 

## Requirements 
In order to be able to work with this template, you will need: 
* CMake - version 3.15 and above 
* GCC Compiler 
* Doxygen - for ability to generate docs
sudo apt-get install doxygen doxygen-doc graphviz 
* cmocka test framework

## Getting Started 
1. Change project name in CmakeLists.txt
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
