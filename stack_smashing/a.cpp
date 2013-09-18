#include <stdio.h>
#include <stdlib.h>
// g++ --no-stack-protector -O0

int hack() { // @ 0x08048474 
    system("echo I would have execute any command if I wanted! Watch out! && echo I will just list the current folder contents this time... && ls -al");
    return 0;
}
/* スタックをめちゃくちゃにする入力の例 */
char input[100] = { /*EBP-0x28*/'I' , ' ' , 'A' , 'M' , ' ' , 'A' , ' ' , 'H' , //自動変数"buffer"
                                'A' , 'R' , 'M' , 'L' , 'E' , 'S' , 'S' , ' ' , // | 
                                'N' , 'I' , 'C' , 'E' , ' ' , 'M' , 'E' , 'S' , // |
                                'S' , 'A' , 'G' , 'E' , '!' , ' ' , '.' , '.' , //自動変数"buffer"終わり（32バイト）
                    /*EBP-0x8*/ '.' , '.' , '.' , '.' , '.' , '.' , '.' , '.' , 
                    /*EBP    */ '.' , '.' , '.' , '.' , //上位ポインタ 
                    /*EBP+0x4*/ 0xa4, 0x84, 0x04, 0x08, //戻り番地 @ hacked
                    '\0'
};

int getAndPrintMessage() {
    char buffer[32]; // @ $ebp - 0x30
    printf("Please enter a small message!:\n");fflush(0);
    gets(buffer);
    printf("\n\nThe message is : \"%s\"\n\n", buffer);
}

int main(int argc, char* argv[]) {
    getAndPrintMessage();
}
