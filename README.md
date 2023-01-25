# ModernCppTemplate 

### About 
This project is an attempt to create template for C/C++ projects using modern cmake. It's designed to suit my personal requirements, but it might be useful for other developers too. 
### Acknowledgements 
This project is mostly a combination of other templates listed below: 
* https://github.com/filipdutescu/modern-cpp-template 
* https://github.com/TheLartians/ModernCppStarter 
* https://github.com/pabloariasal/modern-cmake-sample 

## Features 

## Requirements 
In order to be able to work with this template, you will need: 
* CMake - version 3.15 and above 
* C++ Compiler - must support C++ 17 standard 
* Graphviz - for Docker and ability to generate docs 

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

## TODO 
* correct workflows 
* test formating 
* test analyzers
* improve test cmake 
* set readme 

* add cpm 
* add popular libs as optional 

For later:
* add version for ansi C 
* add version for QT 
* add version for STM 
* add version for rpi pico
