#include <stdio.h>
#include "AutoOutOfScope.hpp"

void PotentiallyLeakyFunction();

int main(int ac, char *av[]) {
    PotentiallyLeakyFunction();
    printf("Bye bye...");
}

void PotentiallyLeakyFunction() {
    float *array = new float[100];
    printf("array@[0x%08X]\n", (unsigned int) array);
    Auto(printf("Next freeing array@[0x%08X]\n", (unsigned int) array); delete [] array;);
    const char *function = __FUNCTION__;
    Auto(printf("Bye bye from [%s]\n", function););
}
