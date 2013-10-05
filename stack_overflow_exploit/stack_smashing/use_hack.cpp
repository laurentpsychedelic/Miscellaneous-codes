#include <stdio.h>
#include <unistd.h>

void hacked();

int main(int argc, char* argv[]) {
    sleep(10000);
    hacked();
    return 0;
}
