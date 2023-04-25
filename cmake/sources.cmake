set(HEADERS
)

set(SOURCES
    src/main.c
)

# inside test directory
set(TEST_SOURCES
    mainTest.c
)

# changes regarding MCU
set(MCU_FAMILY STM32F4xx)
set(MCU_MODEL STM32F411xE)
set(CPU_PARAMETERS
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard)

set(STM32CUBEMX_SOURCES
    cubeMX/Core/Src/stm32f4xx_it.c
    cubeMX/Core/Src/sysmem.c
    cubeMX/Core/Src/stm32f4xx_hal_msp.c
    cubeMX/Core/Src/syscalls.c
    cubeMX/Core/Src/system_stm32f4xx.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2c.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2c_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c
    cubeMX/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_uart.c
)

set(CUBEMX_INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Core/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Drivers/${MCU_FAMILY}_HAL_Driver/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Drivers/${MCU_FAMILY}_HAL_Driver/Inc/Legacy
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Drivers/CMSIS/Device/ST/${MCU_FAMILY}/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Drivers/CMSIS/Include
)

set(STARTUP_SCRIPT      ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Core/Startup/startup_stm32f411retx.s)
set(MCU_LINKER_SCRIPT   ${CMAKE_CURRENT_SOURCE_DIR}/cubeMX/Core/Startup/STM32F411RETX_FLASH.ld) 
