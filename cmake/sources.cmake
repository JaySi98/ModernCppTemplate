set(HEADERS
    ${STM32CUBEMX_HEADERS}
)

set(SOURCES
    src/main.c
    ${STM32CUBEMX_SOURCES}
)

set(STM32CUBEMX_SOURCES
    Core/Src/main.c
    Core/Src/stm32f4xx_it.c
    Core/Src/sysmem.c
    Core/Src/stm32f4xx_hal_msp.c
    Core/Src/syscalls.c
    Core/Src/system_stm32f4xx.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2c.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2c_ex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c
    Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_uart.c
)

set(CUBEMX_INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_SOURCE_DIR}/Core/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/${MCU_FAMILY}_HAL_Driver/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/${MCU_FAMILY}_HAL_Driver/Inc/Legacy
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/CMSIS/Device/ST/${MCU_FAMILY}/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/CMSIS/Include
)

# potential changes here
set(STARTUP_SCRIPT      ${CMAKE_CURRENT_SOURCE_DIR}/Core/Startup/startup_stm32f411retx.s)
set(MCU_LINKER_SCRIPT   ${CMAKE_CURRENT_SOURCE_DIR}/Core/Startup/STM32F411RETX_FLASH.ld) 

# inside test directory
set(TEST_SOURCES
    mainTest.c
)


# STM files
# set(STM32CUBEMX_HEADERS
#     Drivers/CMSIS/Device/ST/STM32F4xx/Include/stm32f411xe.h
#     Drivers/CMSIS/Device/ST/STM32F4xx/Include/stm32f4xx.h
#     Drivers/CMSIS/Device/ST/STM32F4xx/Include/system_stm32f4xx.h

#     Drivers/CMSIS/Include/cmsis_armcc.h
#     Drivers/CMSIS/Include/cmsis_version.h
#     Drivers/CMSIS/Include/core_cm1.h
#     Drivers/CMSIS/Include/core_cm7.h
#     Drivers/CMSIS/Include/tz_context.h
#     Drivers/CMSIS/Include/cmsis_armclang.h
#     Drivers/CMSIS/Include/core_armv8mbl.h
#     Drivers/CMSIS/Include/core_cm23.h
#     Drivers/CMSIS/Include/core_sc000.h
#     Drivers/CMSIS/Include/cmsis_compiler.h
#     Drivers/CMSIS/Include/core_armv8mml.h
#     Drivers/CMSIS/Include/core_cm33.h
#     Drivers/CMSIS/Include/core_sc300.h
#     Drivers/CMSIS/Include/cmsis_gcc.h
#     Drivers/CMSIS/Include/core_cm0.h
#     Drivers/CMSIS/Include/core_cm3.h
#     Drivers/CMSIS/Include/mpu_armv7.h
#     Drivers/CMSIS/Include/cmsis_iccarm.h
#     Drivers/CMSIS/Include/core_cm0plus.h
#     Drivers/CMSIS/Include/core_cm4.h
#     Drivers/CMSIS/Include/mpu_armv8.h

#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_flash.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_pwr_ex.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_cortex.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_flash_ramfunc.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_pwr.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_def.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_gpio_ex.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_rcc_ex.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_dma_ex.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_gpio.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_rcc.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_dma.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_tim_ex.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_exti.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_i2c_ex.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_tim.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_flash_ex.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_i2c.h
#     Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_uart.h

#     Drivers/STM32F4xx_HAL_Driver/Inc/Legacy/stm32_hal_legacy.h

#     Core/Inc/main.h
#     Core/Inc/stm32f4xx_hal_conf.h
#     Core/Inc/stm32f4xx_it.h
# )
