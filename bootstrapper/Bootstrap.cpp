#include <windows.h>
#include <stdio.h>

#define BUFFER_SIZE 1024
int main(int argc, char *argv[]) {
    STARTUPINFO si;
    PROCESS_INFORMATION pi;
    char cmd[BUFFER_SIZE], buff[BUFFER_SIZE];
    memset(&si, 0, sizeof(si));
    si.cb = sizeof(si);
    snprintf(cmd, 511, "bin\\jre\\bin\\java.exe -jar dist/WPA_VIEW.jar ");
    for (int i = 1; i < argc; i++) {
        snprintf(buff, BUFFER_SIZE, "%s \"%s\"", cmd, argv[i]);
        snprintf(cmd, BUFFER_SIZE, buff);
    }

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
