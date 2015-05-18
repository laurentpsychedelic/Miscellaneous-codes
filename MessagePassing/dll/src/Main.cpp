#include "MessageReader.h"

#include <windows.h>
#include <process.h>
#include <tchar.h>
#include <stdio.h>
#include <locale.h>

#define BUFFER_SIZE 1024 
_TCHAR header[BUFFER_SIZE];

HRESULT CALLBACK MyWindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
WNDCLASS wc;
HWND hWndMain;
MSG msg;
BOOL bRet;
DWORD WINAPI MessageLoop(LPVOID pParam) {
    hWndMain = CreateWindow(wc.lpszClassName, _T("MessageReader"), WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, wc.hInstance, NULL);
    _ftprintf(stdout, _T("hWnd:%d\n"), hWndMain);fflush(NULL);

    while ( (bRet = GetMessage( &msg, NULL, 0, 0 )) != 0) {
        if (bRet == -1) {
            // handle the error and possibly exit
        } else {
            TranslateMessage(&msg); 
            DispatchMessage(&msg); 
        }
    }
    return 0;
}
extern "C" BOOL APIENTRY DllMain(HINSTANCE hInstance, DWORD ul_reason_for_call, LPVOID pParam) {
    _tsetlocale( LC_ALL, _T("Japanese"));

    int res;
    HANDLE hThread;
    DWORD dwThreadID;
    switch (ul_reason_for_call) {
    case DLL_PROCESS_ATTACH:
        printf("Attach!\n");fflush(NULL);

        ::ZeroMemory(&wc, sizeof(wc));
        wc.lpfnWndProc = (WNDPROC) MyWindowProc;
        wc.hInstance = hInstance;
        wc.lpszClassName = _T("MessageReader.dll");
        res = RegisterClass(&wc);
        if (res != 0) {
            hThread = (HANDLE) _beginthreadex(NULL, 0,
                                              (unsigned int (__stdcall *)(void *)) MessageLoop,
                                              NULL,
                                              0,
                                              (unsigned int *) &dwThreadID);
            if (hThread != NULL)
                return TRUE;
        } else return FALSE;
    case DLL_PROCESS_DETACH:
        return ::UnregisterClass(wc.lpszClassName, wc.hInstance);
    default:
        break;
    }
    return TRUE;
}

BOOL CheckHeader(const _TCHAR* message) {
    if (message == NULL || _tcslen(message) < 1)
        return FALSE;
    if (_tcslen(message) < _tcslen(header))
        return FALSE;
    BOOL OK = TRUE;
    for (int i = 0, len = _tcslen(header); i < len; ++i) {
        if (header[i] != message[i])
            OK = FALSE;
    }
    return OK;
}

_TCHAR   message[BUFFER_SIZE] = _T("");
_TCHAR* pmessage = NULL;
HRESULT CALLBACK MyWindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
    _TCHAR* _pmessage = NULL;
    switch (uMsg) {
    case WM_CLOSE:
        ::DestroyWindow(hWnd);
        break;
    case WM_DESTROY:
        ::PostQuitMessage(0);
        break;
    case WM_COPYDATA:
        _pmessage = (TCHAR*) (((PCOPYDATASTRUCT) lParam)->lpData);
        if (!CheckHeader(_pmessage)) {
            return FALSE;
        }
        pmessage = _pmessage;
        _sntprintf(message, BUFFER_SIZE, _T("%s"), pmessage);
        // _ftprintf(stdout, _T("RECEIVED: [%s]\n"), message); fflush(NULL);
        return TRUE;
        break;
    default:
        return (HRESULT) ::DefWindowProc(hWnd, uMsg, wParam, lParam);
        break;
    }
    return 0;
}

void SetHeader(const _TCHAR* Header) {
    _sntprintf(header, BUFFER_SIZE, _T("%s"), Header);
    return;
}
_TCHAR* ReadMeassage() {
    _TCHAR* _pmessage = pmessage;
    pmessage = NULL;
    return _pmessage;
    return NULL;
}
