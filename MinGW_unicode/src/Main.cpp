#include <stdio.h>
#include <tchar.h>

int _tmain(int argc, _TCHAR *argv[]) {
    _TCHAR str[1024];
    _stprintf(str, __T("%s"), __T("Hello World!"));
    _tprintf(__T("%s\n"), str);
    return 0;
}
