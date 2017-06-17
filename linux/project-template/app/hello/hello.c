#include "foo.h"
#include "bar.h"
#include <stdio.h>

int main(int argc, const char *argv[]) {
    const char * hello = "hello world!";
    char fooSay[128] = {0};
    char barSay[128] = {0};

    foo(fooSay, hello);
    bar(barSay, hello);

    printf("hello world!\n");
    printf("%s\n", fooSay);
    printf("%s\n", barSay);

    return 0;
}