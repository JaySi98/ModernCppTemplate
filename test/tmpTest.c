#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <setjmp.h>
#include <stdint.h>
#include <cmocka.h>
#include "tmpTest.h"

int tmp_tests_init(void **state)
{
    return 0;
}

int tmp_tests(void)
{
	const struct CMUnitTest tests[] = 
	{
		// cmocka_unit_test(tmp_test_add),
	};

	return cmocka_run_group_tests(tests, NULL, NULL);
}
