#include "foo.h"
#include <stdio.h>

int foo(char * out, const char * in) {
    if (!out || !in) return 1;

    sprintf(out, "you want foo say: %s\n", in);
    return 0;    
}