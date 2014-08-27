#include <stdio.h>
#include <time.h>

void soft_ROI(const short* frame_in, int Win, int Hin, short* frame_out, int X, int Y, int Wout, int Hout);

int main(int argc, char *argv[]) {
    const int Win  = 3000;
    const int Hin  = 2000;
    const int Wout = 1000;
    const int Hout =  800;
    const int X    = 1000;
    const int Y    =  600;

    const int N = 1000;

    short* frame_in  = new short[Win  * Hin];
    short* frame_out = new short[Wout * Hout];

    clock_t start = clock();

    for (int i = 0; i < N; ++i) {
        soft_ROI(frame_in, Win, Hin, frame_out, X, Y, Wout, Hout);
    }

    clock_t end = clock();
    float seconds = (float) (1000.0 * (end - start) / N / CLOCKS_PER_SEC);

    printf("Time: %fms\n", seconds);

    delete [] frame_in;
    delete [] frame_out;

}

void soft_ROI(const short* frame_in, int Win, int Hin, short* frame_out, int X, int Y, int Wout, int Hout) {
    for (int i = 0; i < Hout; ++i) {
        for (int j = 0; j < Wout; ++j) {
            frame_out[i * Wout + j] = frame_in[(i + Y) * Win + (j + Y)];
        }
    }
}
