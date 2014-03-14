#include <windows.h>
#include <stdio.h>

#include <windows.h>
#include <stdio.h>

int main(int ac, char **av) {
    STARTUPINFO si;
    PROCESS_INFORMATION pi;
    char args[512];
    memset(&si, 0, sizeof(si));
    si.cb = sizeof(si);
    sprintf(args, "-jar dist/WPA_VIEW.jar %s", ac > 1 ? av[1] : "");

    //create the proc with those args
    if (!CreateProcess(".\\bin\\jre\\bin\\java.exe", args, NULL, NULL, 0, 0, NULL, NULL, &si, &pi)) {
        return -1;
    }

    //wait till the proc ends
    WaitForSingleObject(pi.hProcess,INFINITE);

    //close all
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    getchar();
    return 0;
}
