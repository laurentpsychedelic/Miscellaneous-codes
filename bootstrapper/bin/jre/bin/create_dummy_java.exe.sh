#!/bin/bash

echo '#include <Stdio.h>
int main(int argc, char *argv[]) {
    printf("argc=%d\n", argc);
    for (int i = 1; i < argc; i++) {
        printf("    argv[%d]=%s\n", i, argv[i]);
    }
    getchar();
}
' > java.c
g++ -o java.exe java.c
rm -f *.o java.c
