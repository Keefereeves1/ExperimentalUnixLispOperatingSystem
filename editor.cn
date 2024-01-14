#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <ncurses.h>
#include <string.h>

#define MAXLINE 80

int erase_char_at_pos(char *s, size_t pos) {
    if (pos < strlen(s)) {
        memmove(s + pos, s + pos + 1, strlen(s) - pos);
        return 1;
    } else {
        return 0;
    }
}

int is_new_line(const char *s) {
    int len = strlen(s);
    return (len > 0) && (s[len - 1] == '\n');
}

#define KEY_CTRL(c) ((c) & 0x1F)

int main(int argc, char *argv[]) {
    char line[MAXLINE];
    FILE *infile;
    FILE *outfile;
    int c;

    if (argc != 3) {
        printf("usage: %s <input_file> <output_file>\n", argv[0]);
        return 1;
    }

    infile = fopen(argv[1], "r");
    if (!infile) {
        perror("open input file");
        return 1;
    }

    outfile = fopen(argv[2], "w");
    if (!outfile) {
        perror("open output file");
        fclose(infile);
        return 1;
    }

    initscr();
    cbreak();
    noecho();

    while ((c = getchar()) != EOF) {
        if (c == KEY_BACKSPACE) {
            if (erase_char_at_pos(line, strlen(line) - 1) > 0) {
                if (strlen(line) > 0) {
                    fputs(line, outfile);
                }
            }
        } else if (c == KEY_DC) {
            if (erase_char_at_pos(line, strlen(line) - 1) > 0) {
                if (strlen(line) > 0) {
                    fputs(line, outfile);
                }
            } else {
                ungetc(c, stdin);
            }
        } else if (c != KEY_CTRL('H')) {
            if (strlen(line) < MAXLINE) {
                line[strlen(line)] = c;
            } else {
                fputs(line, outfile);
                line[0] = '\0';
            }
        } else {
            ungetc(c, stdin);
        }

        if (is_new_line(line)) {
            fputs(line, outfile);
            line[0] = '\0';
        }

        refresh();
    }

    endwin();
    fclose(infile);
    fclose(outfile);
    return 0;
}

