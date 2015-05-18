#include <windows.h>
#include <tchar.h>
#include <stdio.h>
#include <locale.h>

#define BUFFER_SIZE 1024

WNDCLASS wc;
HWND hWndMain = NULL;
HRESULT CALLBACK MyWindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) { return (HRESULT) ::DefWindowProc(hWnd, uMsg, wParam, lParam); }
int WINAPI _tWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow) {
    _tsetlocale( LC_ALL, _T("Japanese"));
    LPWSTR *szArgList;
    int argCount;
 
    szArgList = CommandLineToArgvW(GetCommandLine(), &argCount);
    if (szArgList == NULL) {
        _ftprintf(stderr, _T("Unable to parse command line!"));
         return 10;
    }
    if (argCount <= 1) {
        _ftprintf(stderr, _T("Not enough arguments..."));
        return -1;
    }

    ::ZeroMemory(&wc, sizeof(wc));
    wc.lpfnWndProc = (WNDPROC) MyWindowProc;
    wc.hInstance = hInstance;
    wc.lpszClassName = _T("MessageSender.exe");
    if (RegisterClass(&wc))
        hWndMain = CreateWindow(wc.lpszClassName, _T("MessageSender"), WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);
    _ftprintf(stdout, _T("hWnd:%d\n"), hWndMain);fflush(NULL);

    TCHAR szData[BUFFER_SIZE];
    _sntprintf(szData, BUFFER_SIZE, _T("%s"), szArgList[1]);
    COPYDATASTRUCT data;

    data.dwData = 1;
    data.cbData = sizeof(szData);
    data.lpData = szData;

    HWND hWnd = FindWindow(_T("MessageReader.dll"), _T("MessageReader"));
    _ftprintf(stdout, _T("hWnd=%d\n"), hWnd);fflush(NULL);

    _ftprintf(stdout, _T("SENDING: [%s]...\n"), data.lpData);
    SendMessage(hWnd, WM_COPYDATA, (WPARAM) hWndMain, (LPARAM) &data);

    LocalFree(szArgList);
    return 0;
}
