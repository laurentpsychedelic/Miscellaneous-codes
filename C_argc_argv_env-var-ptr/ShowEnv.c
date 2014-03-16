#include <stdio.h>

int main(int ac, char *av[], char** env_var_ptr) {
    while (NULL != *env_var_ptr) {
        printf("%s\n", *(env_var_ptr++));
    }
    fflush(0);
    return 0;
}
