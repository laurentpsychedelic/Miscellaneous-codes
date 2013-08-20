#include "callback.h"

#include <iostream>
using namespace std;

Callback::Callback() {
    callback = NULL;
}

void callThis(void* self) {
    ((Callback*) self)->defaultCallback();
}

void Callback::setCallback(void (*callback) (void*)) {
    this-> callback = callback;
    if (!callback) {
        this->callback = callThis;
    }
}

void Callback::defaultCallback() {
    cout << "Internal function called as callback!" << endl;
}

void Callback::call() {
    if (callback) {
        callback(this);
    } else {
        cout << "Callback function is NULL!" << endl;
    }
}

void externalFunction (void*) {
    cout << "External function called as callback!" << endl;
}

int main(int argc, char *argv[])
{
    Callback callback;
    callback.call();
    callback.setCallback(externalFunction);
    callback.call();
    callback.setCallback(NULL);
    callback.call();
    return 0;
}
