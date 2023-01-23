based on:
    * https://github.com/filipdutescu/modern-cpp-template
    * https://github.com/TheLartians/ModernCppStarter
    * https://github.com/pabloariasal/modern-cmake-sample

potencial requirements:
- ninja
- Graphviz 

how to:
  1. install
    cmake -S . -B build/ 
    - cmake --build <build_directory> --target install --config <desired_config>
  2. build
    - cmake -S . -B build/  -DProject_BUILD_EXECUTABLE:BOOL=ON
    - cmake --build build
  3. remove installed
    - sudo xargs rm < build/install_manifest.txt


TODO:
  * change exec-lib logic
  * improve test cmake
  * add missing files 
  * set readme
  * change clang-format 
  * add cpm
  * add popular libs as optional