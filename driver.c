#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char *argv[]) {
    int fd;

    if (argc != 2) {
        printf("usage: %s <device_file>\n", argv[0]);
        return 1;
    }

    fd = open(argv[1], O_RDWR | O_BLOCK);
    if (fd < 0) {
        perror("open");
        return 1;
    }

    printf("Device file open: %s\n", argv[1]);

    close(fd);
    return 0;
