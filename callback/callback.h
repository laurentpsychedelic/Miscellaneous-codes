#ifndef CALLBACK_H
#define CALLBACK_H

class Callback {
 public:
    Callback();
    void setCallback(void (*callback) (void*));
    void defaultCallback();
    void call();
 private:
    void (*callback) (void*);
};

#endif
