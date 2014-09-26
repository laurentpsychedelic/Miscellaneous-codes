#ifndef AUTOOUTOFSCOPE_HPP
#define AUTOOUTOFSCOPE_HPP

template <typename T>
class AutoOutOfScope
{
public:
    AutoOutOfScope(T& destructor) : m_destructor(destructor) { }
    ~AutoOutOfScope() { m_destructor(); }
private:
    T& m_destructor;
};

#define TOKEN_PASTEx(x, y) x##y
#define TOKEN_PASTE(x, y) TOKEN_PASTEx(x, y)

#define Auto_INTERNAL(Destructor, counter)\
    auto TOKEN_PASTE(auto_func_, counter) = [&]() { Destructor; };\
    AutoOutOfScope<decltype(TOKEN_PASTE(auto_func_, counter))> TOKEN_PASTE(auto_, counter)(TOKEN_PASTE(auto_func_, counter));

#define Auto(Destructor) Auto_INTERNAL(Destructor, __COUNTER__)

#endif
