#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>
#include <setjmp.h>
#include <stdint.h>
#include <cmocka.h>

#include <tmp/tmp.h>
#include "tmpTest.h"

int tmp_tests_init(void **state)
{
    return 0;
}

static void tmp_test_add(void **state)
{
	assert_int_equal(add(1,1), 2);
}

int tmp_tests(void)
{
	const struct CMUnitTest tests[] = 
	{
		cmocka_unit_test(tmp_test_add), //tmp_test_add
	};

	return cmocka_run_group_tests(tests, NULL, NULL);
}
