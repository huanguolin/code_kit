#include "print_progress.h"

#include <stdio.h>
#include <string.h>

int get_terminal_cols(void) {
#ifdef WIN32

#include <windows.h>

	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi);
	return csbi.srWindow.Right - csbi.srWindow.Left + 1;

#else 

#include <sys/ioctl.h>
#include <unistd.h>

	struct winsize size;
	ioctl(STDOUT_FILENO,TIOCGWINSZ,&size);
	return size.ws_col;

#endif /* WIN32 */
}


void print_progress(const char *msg, int percent) {
/*
 *  if cols < ONLY_PROGRESS_BAR_NEED, 
 *  print like: 85%
 *
 *  if cols >= ONLY_PROGRESS_BAR_NEED && half <= ONLY_PROGRESS_BAR_NEED,
 *  print like: 85% [================>   ]
 *
 *  if half > ONLY_PROGRESS_BAR_NEED && msg_len < half,
 *  print like: 85% [================>   ] compress file abc.txt

 *  if half > ONLY_PROGRESS_BAR_NEED && msg_len >= half,
 *  print like: 85% [================>   ] compress ... abc.txt
 */

/* Fixed length from: '100% [', '>]' */
#define PROGRESS_BAR_FIXED_LEN	    (8)
#define PROGRESS_BAR_MIN_LEN	    ( 10 + PROGRESS_BAR_FIXED_LEN )
#define ONLY_PROGRESS_NEED          PROGRESS_BAR_MIN_LEN
#define ONLY_PROGRESS_BAR_NEED      (30)

	int cols = get_terminal_cols();
	int half = cols / 2;
	int msg_len = strlen(msg);
	int	progress_len = 0;
	int percent_need_len = 0;

	/* Clear */
	printf("\r");
	
	/* Only progress number no bar */
	if (cols < ONLY_PROGRESS_NEED) {
		printf("%d%%", percent); 
		goto FLUSH;
	} 
	
    /* Here means can print progress bar */
	if (half > ONLY_PROGRESS_BAR_NEED) progress_len = half - PROGRESS_BAR_FIXED_LEN;
	else progress_len = cols - PROGRESS_BAR_FIXED_LEN;
	percent_need_len = progress_len * percent / 100;
		
	/* Print progress bar */
	printf("%3d%% [", percent);
	for (int i = 0; i < percent_need_len; i++) printf("=");
	(percent >= 100) ? printf("=") :  printf(">");
	for (int i = 0; i < progress_len - percent_need_len; i++) printf(" ");
	printf("]");

	/* Print message, if cols enough */
	if (half > ONLY_PROGRESS_BAR_NEED) {
		printf(" ");
		if (msg_len < half) {
			printf("%s", msg);
		} else {
            /* message too long, so make the middle part to ... */
			int part = (half - 6) / 2; // minus 6 for: left space and mid ' ... '
			for (int i = 0; i < part; i++) printf("%c", (int)*(msg + i));
			printf(" ... ");
			printf("%s", msg + msg_len - part);
		}
	}

FLUSH:
	if (percent >= 100) puts("");
	else fflush(stdout);
}
