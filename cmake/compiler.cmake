# from here:
#
# https://github.com/lefticus/cppbestpractices/blob/master/02-Use_the_Tools_Available.md
# Courtesy of Jason Turner

function(set_project_warnings project_name)
    set(GCC_WARNINGS
        -Wmisleading-indentation    # warn if indentation implies blocks where blocks
                                    # do not exist
        -Wduplicated-cond           # warn if if / else chain has duplicated conditions
        -Wduplicated-branches       # warn if if / else branches have duplicated code
        -Wlogical-op                # warn about logical operations being used where bitwise were
                                    # probably wanted
        -Wuseless-cast              # warn if you perform a cast to the same type
    )

    set(PROJECT_WARNINGS ${GCC_WARNINGS})
    
    target_compile_options(${PROJECT_NAME} PUBLIC ${PROJECT_WARNINGS})
endfunction()
