// Based on Tsuda Kageyu's work: http://www.codeproject.com/Articles/124130/Simple-Look-Scope-Guard-for-Visual-C

#ifndef SCOPEGUARD_HPP
#define SCOPEGUARD_HPP

#include <functional>
#include <cstddef>

using namespace std;

class scope_exit_t
{
    typedef function<void()> func_t;

public:
    scope_exit_t(func_t &&f) : func(f) {}
    ~scope_exit_t() { func(); }

private:
    // Prohibit construction from lvalues.
    scope_exit_t(func_t &);

    // Prohibit copying.
    scope_exit_t(const scope_exit_t&);
    const scope_exit_t &operator=(const scope_exit_t &);

    // Prohibit new/delete.
    void *operator new(size_t);
    void *operator new[](size_t);
    void operator delete(void *);
    void operator delete[](void *);

    const func_t func;
};

#define SCOPE_EXIT_CAT2(x, y) x##y
#define SCOPE_EXIT_CAT1(x, y) SCOPE_EXIT_CAT2(x, y)
#define SCOPE_EXIT scope_exit_t SCOPE_EXIT_CAT1(scope_exit_, __COUNTER__) ( [&]
#define SCOPE_EXIT_END )

// Count variadic macro arguments [https://github.com/aeyakovenko/notes#counting-args-with-c-macros]
#define COUNT_ARGS(...) COUNT_ARGS_(,##__VA_ARGS__,6,5,4,3,2,1,0)
#define COUNT_ARGS_(z,a,b,c,d,e,f,cnt,...) cnt
// Macro "stringification" [http://stackoverflow.com/questions/6686675/gcc-macro-expansion-arguments-inside-String]
#define S(x) #x
#define SX(x) S(x)

// !!!! Code below is NOT VALID !!! because pointers are stored as "void*", so the behavior of "delete []" is undefined...
// if there was a good way to iterate through variadic macro arguments I would not have to use this "void**" array...
/* #define SCOPE_EXIT_ALL(op, ...) SCOPE_EXIT { do { void** ar_[] = { __VA_ARGS__ }; \
    for (int i = 0, len = COUNT_ARGS(__VA_ARGS__); i < len; ++i) { \
        printf("Deleting memory <" SX(op) "> (array) at [0x%08X]\n", (unsigned int) *ar_[i]); fflush(NULL); \
        op *ar_[i]; \
    } } while (false); } SCOPE_EXIT_END
#define SCOPE_EXIT_DELETE_ALL_ARRAYS(...) SCOPE_EXIT { do { void** ar_[] = { __VA_ARGS__ }; \
    for (int i = 0, len = COUNT_ARGS(__VA_ARGS__); i < len; ++i){ \
        const void* old_ptr = (void*) *ar_[i]; \
        *ar_[i] = NULL;                                                 \
        printf("Nullifying pointer <=NULL> from [0x%08X] to NULL: [0x%08X]\n", (unsigned int) old_ptr, (unsigned int) *ar_[i]); \
    } } while(false); } SCOPE_EXIT_END; \
    SCOPE_EXIT_ALL(delete[], __VA_ARGS__);*/

#endif
