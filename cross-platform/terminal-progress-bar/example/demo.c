#include "print_progress.h"

#include <stdio.h>

void sleep_ms(int ms) {
#ifdef WIN32

#include <windows.h>
    Sleep(ms);

#else 

    #include <unistd.h>
    usleep(ms * 1000);

#endif /* WIN32 */
}

int main(int argc, const char **argv) {
    char msg[256] = {0};

    for (int i = 0; i < 100; i++) {
        int p = i + 1;
        sprintf(msg, "progress %d%% now", p);
        print_progress(msg, p);
        sleep_ms(100);
    }

    return 0;
}
