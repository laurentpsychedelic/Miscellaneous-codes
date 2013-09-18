#include <iostream>
using namespace std;

class CMyClass {
private:
    char* data;
public:
    CMyClass();
    virtual ~CMyClass();
};

CMyClass::CMyClass() {
    const int N = 100;
    data = new char[N];
    cout << "Allocating " << N << " bytes of memory...\n";
}

CMyClass::~CMyClass() {
    delete [] data;
    cout << "Deleted unused 10 bytes before leaving scope!\n";
}

int main(int ac, char *av[]) {
    int N = 10;
    CMyClass* objects = new CMyClass[N];
    cout << "Size of \"objects\" array: " << N * sizeof(CMyClass) << " bytes\n";
    /* DO SOMETHING */
    delete /*[] Ooops!! */ objects;
    return 0;
}
