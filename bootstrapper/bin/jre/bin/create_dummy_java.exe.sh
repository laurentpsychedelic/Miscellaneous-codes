#!/bin/bash

echo '#include <Stdio.h>
int main(int ac, char *av[]) {
    printf("ac=%d\n", ac);
    for (int i = 1; i < ac; i++) {
        printf("    argv[%d]=%s\n", i, av[i]);
    }
    getchar();
}
' > java.c
g++ -o java.exe java.c
rm -f *.o java.c
