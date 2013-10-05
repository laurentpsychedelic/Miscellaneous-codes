#include <stdio.h>

// g++ --no-stack-protector //hacked libhack.so @ 0xb76e545c

int hack() { // @ 0x08048474 
    printf("\n\n*************************************************\nHACKED!! STRCPY AND SPRINTF ARE NOT YOUR FRIEND!!\n*************************************************\n\n");
    return 0;
}

char input[100] = { 0x74, 0x84, 0x04, 0x08 , 0x74, 0x84, 0x04, 0x08 , 
                    0x74, 0x84, 0x04, 0x08 , 0x74, 0x84, 0x04, 0x08 ,
                    0x74, 0x84, 0x04, 0x08 , 0x74, 0x84, 0x04, 0x08 ,
                    0x74, 0x84, 0x04, 0x08 , 0x74, 0x84, 0x04, 0x08 ,
                    /*EBP-0x8*/ 0x74, 0x84, 0x04, 0x08 , 
                    /*EBP-0x4*/ 0x74, 0x84, 0x04, 0x08 , 0x74, 0x84, 0x04, 0x08 , 
                    /*EBP    */ 0x74, 0x84, 0x04, 0x08 ,
                    /*EBP+0x4*/ 0x5c, 0x54, 0x6e, 0xb7 , // <= return address @ hacked
                    '\0'
                    };
int getAndPrintMessage() {
    char buffer[32]; // @ $ebp - 0x30
    sprintf(buffer, /*32, */"%s", input);
    printf("\n\nThe message is : \"%s\"\n\n", buffer);
    fflush(0);
}

int main(int argc, char* argv[]) {
    getAndPrintMessage();
}
