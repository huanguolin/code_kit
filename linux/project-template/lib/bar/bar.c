#include "bar.h"
#include <stdio.h>

int bar(char * out, const char * in) {
    if (!out || !in) return 1;

    sprintf(out, "you want bar say: %s\n", in);
    return 0;    
}