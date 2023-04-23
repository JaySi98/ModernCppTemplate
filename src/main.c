
#include "main.h"

void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_USART2_UART_Init(void);
static void MX_I2C2_Init(void);

void InitIS31(uint8_t devAddress, uint32_t delay);
void WriteToIS31(uint8_t devAddress, uint8_t value, uint32_t delay);
void UpdateIS31(uint8_t devAddress, uint32_t delay);

I2C_HandleTypeDef hi2c2;
UART_HandleTypeDef huart2;

int main(void)
{
  uint8_t deviceAddress[3] = {
    0x61 << 1,  // 0x61 << 1,
    0x62 << 1,  // 0x62 << 1,
    0x63 << 1   // 0x63 << 1,
  };

  HAL_Init();
  SystemClock_Config();
  MX_GPIO_Init();

  // test
  __HAL_RCC_GPIOB_CLK_ENABLE();

  GPIO_InitTypeDef gpio;
  gpio.Mode = GPIO_MODE_AF_OD;
  gpio.Pin = GPIO_PIN_3 | GPIO_PIN_10;  // SCL, SDA
  gpio.Pull = GPIO_PULLUP;
  gpio.Speed = GPIO_SPEED_FREQ_LOW;
  // gpio.Alternate = GPIO_AF4_I2C1;
  HAL_GPIO_Init(GPIOB, &gpio);
  MX_I2C2_Init();
  MX_USART2_UART_Init();

  InitIS31(deviceAddress[0], 100);
  InitIS31(deviceAddress[1], 100);
  InitIS31(deviceAddress[2], 100);

  while (1)
  {
    WriteToIS31(deviceAddress[0], 0xFF, 100);
    WriteToIS31(deviceAddress[1], 0xAA, 100);
    WriteToIS31(deviceAddress[2], 0xBB, 100);

    HAL_Delay(300);
  }
}

void InitIS31(uint8_t devAddress, uint32_t delay)
{
  // reset register, 0x00 do zresetowania rejestrów
  uint8_t data = 0x00;
  uint8_t reg = 0xFF;
  HAL_I2C_Mem_Write(&hi2c2, devAddress, reg, 1, &data, 1, delay);

  // config register, 0x18 podstawowa konfiguracja
  data = 0x18;
  reg = 0x00;
  HAL_I2C_Mem_Write(&hi2c2, devAddress, reg, 1, &data, 1, delay);

  // lighting register,
  data = 0x00;
  reg = 0x0D;
  HAL_I2C_Mem_Write(&hi2c2, devAddress, reg, 1, &data, 1, delay);

  // PWM register,
  data = 0x40;
  reg = 0x19;
  HAL_I2C_Mem_Write(&hi2c2, devAddress, reg, 1, &data, 1, delay);
}

void WriteToIS31(uint8_t devAddress, uint8_t value, uint32_t delay)
{
  // 01h - 0Bh, matrix 1
  // 0Eh - 18h, matrix 2

  uint8_t reg = 0x01;
  HAL_I2C_Mem_Write(&hi2c2, devAddress, reg, 1, &value, 1, delay);

  UpdateIS31(devAddress, delay);
}

void UpdateIS31(uint8_t devAddress, uint32_t delay)
{
  uint8_t data = 0xFF;
  uint8_t reg = 0x0C;
  HAL_I2C_Mem_Write(&hi2c2, devAddress, reg, 1, &data, 1, delay);
}

/**
 * @brief System Clock Configuration
 * @retval None
 */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = { 0 };
  RCC_ClkInitTypeDef RCC_ClkInitStruct = { 0 };

  /** Configure the main internal regulator output voltage
   */
  __HAL_RCC_PWR_CLK_ENABLE();
  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);
  /** Initializes the RCC Oscillators according to the specified parameters
   * in the RCC_OscInitTypeDef structure.
   */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_NONE;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB buses clocks
   */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_HSI;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_0) != HAL_OK)
  {
    Error_Handler();
  }
}

/**
 * @brief I2C2 Initialization Function
 * @param None
 * @retval None
 */
static void MX_I2C2_Init(void)
{
  hi2c2.Instance = I2C2;
  hi2c2.Init.ClockSpeed = 100000;
  hi2c2.Init.DutyCycle = I2C_DUTYCYCLE_2;
  hi2c2.Init.OwnAddress1 = 0;
  hi2c2.Init.AddressingMode = I2C_ADDRESSINGMODE_7BIT;
  hi2c2.Init.DualAddressMode = I2C_DUALADDRESS_DISABLE;
  hi2c2.Init.OwnAddress2 = 0;
  hi2c2.Init.GeneralCallMode = I2C_GENERALCALL_DISABLE;
  hi2c2.Init.NoStretchMode = I2C_NOSTRETCH_DISABLE;
  if (HAL_I2C_Init(&hi2c2) != HAL_OK)
  {
    Error_Handler();
  }
}

/**
 * @brief USART2 Initialization Function
 * @param None
 * @retval None
 */
static void MX_USART2_UART_Init(void)
{
  /* USER CODE BEGIN USART2_Init 0 */

  /* USER CODE END USART2_Init 0 */

  /* USER CODE BEGIN USART2_Init 1 */

  /* USER CODE END USART2_Init 1 */
  huart2.Instance = USART2;
  huart2.Init.BaudRate = 115200;
  huart2.Init.WordLength = UART_WORDLENGTH_8B;
  huart2.Init.StopBits = UART_STOPBITS_1;
  huart2.Init.Parity = UART_PARITY_NONE;
  huart2.Init.Mode = UART_MODE_TX_RX;
  huart2.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart2.Init.OverSampling = UART_OVERSAMPLING_16;
  if (HAL_UART_Init(&huart2) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN USART2_Init 2 */

  /* USER CODE END USART2_Init 2 */
}

/**
 * @brief GPIO Initialization Function
 * @param None
 * @retval None
 */
static void MX_GPIO_Init(void)
{
  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();
}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
 * @brief  This function is executed in case of error occurrence.
 * @retval None
 */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef USE_FULL_ASSERT
/**
 * @brief  Reports the name of the source file and the source line number
 *         where the assert_param error has occurred.
 * @param  file: pointer to the source file name
 * @param  line: assert_param error line source number
 * @retval None
 */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */
