#include "ScopeGuard.hpp"
#include "stdio.h"

unsigned char *z;

void func() {
    float *a = new float[3], *b = new float[5000], *c = new float[45];
    z = new unsigned char[2048];
    printf("\"a\" at [0x%08X]\n", (unsigned int) a);
    printf("\"b\" at [0x%08X]\n", (unsigned int) b);
    printf("\"c\" at [0x%08X]\n", (unsigned int) c);
    printf("\"z\" at [0x%08X]\n", (unsigned int) z);
    SCOPE_EXIT { printf("Delete and nullify \"z\" @ 0x%08X\n", (unsigned int) z); delete [] z; z = NULL; } SCOPE_EXIT_END;
    // SCOPE_EXIT_ALL(delete [], a, b, c, z);
    // SCOPE_EXIT_DELETE_ALL_ARRAYS(&a, &b, &c, &z);

    /* Do something... */
    z[0] = 'a';
    a[0] = b[0] = c[0] = (float) z[0];
    printf(">> \"z@0x%08X[0]\" = '%c'\n", (unsigned int) z, z[0]); fflush(NULL);
    //  delete [] z; z = 0; // Classic manual deallocation
    return; // LEAK! ("a", "b" and "c" are leaked, not "z" thanks to "SCOPE_EXIT")
}

int main(int argc, char *argv[]) {
    func();
    printf("<< \"z@0x%08X[0]\"", (unsigned int) z); fflush(NULL);
    // printf("= '%c'\n", z[0]); fflush(NULL); // Segfault!
    printf("\nOver\n");
}
