#include <stdio.h>

int generate_number() {
    int a = 1;
    static int b = -1;
    b += 1;
    return b;
}

int main() {
    printf("%d\n", generate_number());
    printf("%d\n", generate_number());
    printf("%d\n", generate_number());
    printf("%d\n", generate_number());
    return 0;
}
