# ModernCppTemplate 

### About 
This project is an attempt to create template for C/C++ projects using modern cmake. It's designed to suit my personal requirements, but it might be useful for other developers too. 
### Acknowledgements 
This project is mostly a combination of other templates listed below: 
* https://github.com/filipdutescu/modern-cpp-template 
* https://github.com/TheLartians/ModernCppStarter 
* https://github.com/pabloariasal/modern-cmake-sample 


* https://www.labri.fr/perso/fleury/posts/programming/using-clang-tidy-and-clang-format.html
* https://github.com/StableCoder/cmake-scripts#sanitizer-builds-sanitizerscmake
## Features 

## Requirements 
In order to be able to work with this template, you will need: 
* CMake - version 3.15 and above 
* C Compiler 
* Doxygen - for ability to generate docs
sudo apt-get install doxygen doxygen-doc graphviz 
* clang-tidy
* clang-format
* lcov
* cmocka test framework
## Getting Started 

## Commands 
how to: 
1. install 
cmake -S . -B build/ 
cmake --build <build_directory> --target install --config <desired_config> 
2. build 
cmake -S . -B build/ -DBUILD_EXECUTABLE=ON 
cmake --build build 
3. remove installed 
sudo xargs rm < build/install_manifest.txt 
4. generate documentation
cmake .. -DENABLE_DOXYGEN=1
cmake --build . --target doxygen-docs
xdg-open docs/html/index.html 
5. run tests
./build/test/UnitTests
cd build && ctest -C -VV Debug
6. format code
cmake --build build/ --target clang-format
