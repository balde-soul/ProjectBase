#ifndef PROJECT_BASE_CROSS_PLATFORM_UTIL_METHOD_H
#define PROJECT_BASE_CROSS_PLATFORM_UTIL_METHOD_H
#define PRINT_MACRO_HELPER(x) #x
#define MACRO_TO_STRING(x) #x "=" PRINT_MACRO_HELPER(x)
#else
#endif // ! PROJECT_BASE_CROSS_PLATFORM_UTIL_METHOD_H
