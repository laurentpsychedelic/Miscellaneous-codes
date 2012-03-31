#include <stdio.h>
#include <setjmp.h>

jmp_buf buf;

#define TRY(a) switch (setjmp(buf)) { case 0: while (1) { a break;
#define CATCH(b,c) case b: c break;
#define FINALLY(d) } default: d }
#define THROW(e) longjump(e)

#define WRONG_ARGUMENT_EXCEPTION 1
#define DIVISION_BY_ZERO_EXCEPTION 2

void longjump(int exception_type) {
    printf("long jump! to: %d\n", exception_type);
    longjmp(buf, exception_type);
}

float divide(float a, float b) {
    printf("Try dividing %f by %f...\n", a, b);
    if (b == 0) {
        printf("throw DIVISION_BY_ZERO_EXCEPTION exception [b = 0]\n");
        THROW(DIVISION_BY_ZERO_EXCEPTION);
    }
    printf("Return %f\n", a / b);
    return a / b;
}

float print_n_times_hello(int number) {
    if (number < 0) {
        printf("throw WRONG_ARGUMENT_EXCEPTION exception! (argument = %d)\n", number);
        THROW(WRONG_ARGUMENT_EXCEPTION);
    }
    for (int n = 0; n < number; n++) {
        printf("Hello!!");
    }
    printf("\n");
}

void main() {

  TRY (
      divide(2, 0.34);
      divide(2, 0);
  ) CATCH ( DIVISION_BY_ZERO_EXCEPTION,
       printf("exception caught! >> DIVISION_BY_ZERO_EXCEPTION [%d]\n", DIVISION_BY_ZERO_EXCEPTION);
  ) CATCH ( WRONG_ARGUMENT_EXCEPTION,
       printf("exception caught! >> WRONG_ARGUMENT_EXCEPTION [%d]\n", WRONG_ARGUMENT_EXCEPTION);
  ) FINALLY (
       printf("finally...\n\n\n");
  )

  TRY (
       print_n_times_hello(3);
       print_n_times_hello(-1);
  ) CATCH ( DIVISION_BY_ZERO_EXCEPTION,
       printf("exception caught! >> DIVISION_BY_ZERO_EXCEPTION [%d]\n", DIVISION_BY_ZERO_EXCEPTION);
  ) CATCH ( WRONG_ARGUMENT_EXCEPTION,
       printf("exception caught! >> WRONG_ARGUMENT_EXCEPTION [%d]\n", WRONG_ARGUMENT_EXCEPTION);
  ) FINALLY (
       printf("finally...\n\n\n");
  )

  /*switch (setjmp(buf)) {
    case 0: while(1) {
      printf("try (mine)\n");
      divide(1,0);
      break;
    case 1:
      printf("exception 1\n");
      break;
    case 2:
      printf("exception 2\n");
      break;
    }
    default:
    printf("finally\n");
  }*/

}
