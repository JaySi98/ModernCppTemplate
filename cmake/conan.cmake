if(ENABLE_CONAN)

	# Setup Conan requires and options
	set(${PROJECT_NAME}_CONAN_REQUIRES "")
	set(${PROJECT_NAME}_CONAN_OPTIONS "")

	# If `conan.cmake` (from https://github.com/conan-io/cmake-conan) does not exist, download it.
	if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
		file(
			DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.15/conan.cmake"
			"${CMAKE_BINARY_DIR}/conan.cmake")
		message(STATUS "Cmake-Conan downloaded succesfully.\n")
	endif()

	include(${CMAKE_BINARY_DIR}/conan.cmake)

	conan_add_remote(
		NAME bincrafters
		URL
		https://api.bintray.com/conan/bincrafters/public-conan
	)

	conan_cmake_run(
		REQUIRES
		${${PROJECT_NAME}_CONAN_REQUIRES}
		OPTIONS
		${${PROJECT_NAME}_CONAN_OPTIONS}
		BASIC_SETUP
		CMAKE_TARGETS # Individual targets to link to
		BUILD
		missing
	)

	conan_basic_setup()

	message(STATUS "Conan has been setup.\n")
endif()
