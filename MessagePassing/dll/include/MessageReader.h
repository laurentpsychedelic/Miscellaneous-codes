#ifndef MESSAGEREADER_H
#define MESSAGEREADER_H

#include <tchar.h>

/**
 * MESSAGEREADER.h
 *  Declares MessageReader API functions
 */

#ifdef _WIN32

#ifdef MESSAGEREADER_EXPORTS
#define MESSAGEREADER_API __declspec(dllexport)
#else
#define MESSAGEREADER_API __declspec(dllimport)
#endif

/* Define calling convention. */
#define MESSAGEREADER_CALL __cdecl

#else /* _WIN32 not defined. */

/* Define with no value on non-Windows OSes. */
#define MESSAGEREADER_API
#define MESSAGEREADER_CALL

#endif

/* Make sure functions are exported with C linkage under C++ compilers. */
#ifdef __cplusplus
extern "C"
{
#endif
    
    /* API funtions declarations */
    MESSAGEREADER_API   void  MESSAGEREADER_CALL SetHeader(const _TCHAR* Header);
    MESSAGEREADER_API _TCHAR* MESSAGEREADER_CALL ReadMeassage();

#ifdef __cplusplus
} // __cplusplus defined.
#endif

#endif
