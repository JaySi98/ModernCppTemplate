#include "main.h"

int main(void)
{
	while (1)
	{

	}
}

/**
 * @brief  This function is executed in case of error occurrence.
 */
void Error_Handler(void)
{
  __disable_irq();
  while (1)
  {
	
  }
}

#ifdef USE_FULL_ASSERT
/**
 * @brief  Reports the name of the source file and the source line number
 *         where the assert_param error has occurred.
 * @param  file: pointer to the source file name
 * @param  line: assert_param error line source number
 */
void assert_failed(uint8_t *file, uint32_t line)
{

}
#endif /* USE_FULL_ASSERT */
