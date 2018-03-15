#ifndef __PRINT_PROGRESS_H__
#define __PRINT_PROGRESS_H__

int get_terminal_cols(void);
void print_progress(const char *msg, int percent);

#endif /* __PRINT_PROGRESS_H__ */