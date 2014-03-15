#include <windows.h>
#include <stdio.h>

#include <windows.h>

int main(int ac, char *av[]) {
    STARTUPINFO si;
    PROCESS_INFORMATION pi;
    char cmd[512];
    memset(&si, 0, sizeof(si));
    si.cb = sizeof(si);
    sprintf(cmd, "bin\\jre\\bin\\java.exe -jar dist/WPA_VIEW.jar %s", ac > 1 ? av[1] : "");

    //create the proc with this cmd
    if (!CreateProcess(NULL, cmd, NULL, NULL, 0, 0, NULL, NULL, &si, &pi)) {
        return -1;
    }

    //wait till the proc ends
#ifdef WAIT_INFINITE
    WaitForSingleObject(pi.hProcess,INFINITE);
#endif

    //close all
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return 0;
}
