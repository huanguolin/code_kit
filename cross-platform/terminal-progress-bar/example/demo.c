#include "print_progress.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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
	
	srand(time(NULL));
    for (int i = 0; i < 100; i++) {
        int p = i + 1;
		int r = rand() % 10;
        if (r > 50) sprintf(msg, "progress %d%% now", p);
		else sprintf(msg, "this is very very long progress message, now is %d%%", p);
        print_progress(msg, p);
        sleep_ms(r * 100);
    }

    return 0;
}
