#include <time.h>
#include <stdio.h>

int main(int argc, char *argv[]) {

#define N 100

#define W 1024
#define H 1024

    float data[W][H];

    clock_t time = clock();
    
    for (int k = 0; k < N; k++) {
        
        for (int i = 0; i < H; i++) {
            for (int j = 0; j < W; j++) {
                data[i][j] = i + j;
            }
        }

    }

    time = clock() - time;
    printf("Time: %fms\n", (double) (time) / (CLOCKS_PER_SEC) / N);


    time = clock();
    
    for (int k = 0; k < N; k++) {
        
        for (int j = 0; j < W; j++) {
            for (int i = 0; i < H; i++) {
                data[i][j] = i + j;
            }
        }

    }    
    
    time = clock() - time;
    printf("Time: %fms\n", (double) (time) / (CLOCKS_PER_SEC) / N);

    return 0;
}

