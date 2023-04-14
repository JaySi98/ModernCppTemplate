#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <setjmp.h>
#include <stdint.h>
#include <cmocka.h>

#include "tmpTest.h"

// due to cmocka bug, always add #include <stdint.h> 
// whenever you use #include <cmocka.h>

int main()
{
	int result;
	int (*testFunctions[])(void) = 
	{
		tmp_tests,
	};

	for (size_t i = 0; i < sizeof(testFunctions) / sizeof(testFunctions[0]); i++) 
	{
		if ((result = testFunctions[i]()) != 0)
		{
			break;
		}
	}
	return result;
}
