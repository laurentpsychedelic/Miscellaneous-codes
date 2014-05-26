#ifndef ITRUSTEDVAR_HPP
#define ITRUSTEDVAR_HPP

#include <sstream>
#include <iostream>
#include <string>

using namespace std;

template <class T>
class ITrustedVariableTrait {
 public:
    virtual bool AcceptValue(T value) {
        //cout << "   ...   value: " << value << "[]" << endl;
        return true;
    }
    virtual string GetError(T value) {
        return "OK";
    }
    virtual void print(ostream& stream) {
        stream << "[]";
    }
    friend ostream& operator<< (ostream &stream, ITrustedVariableTrait<T> &trait) {
        trait.print(stream);
        return stream;
    }
};

template <class T>
class ITrustedVariableTraitRange : public ITrustedVariableTrait<T> {
 private:
    T min;
    T max;
 public:
    explicit ITrustedVariableTraitRange(T _min, T _max) : min{_min}, max{_max}
    {}
 public:
    virtual bool AcceptValue(T value) {
        //cout << "   ...   value: " << value << "[" << min << "," << max << "]" << endl;
        return value >= min && value <= max;
    }
    virtual string GetError(T value) {
        ostringstream oss;
        if (!AcceptValue(value))
            if (value < min)
                oss << value << "[value] < " << min << "[min]";
            else
                oss << value << "[value] > " << max << "[max]";
        else oss << "OK";
        return oss.str();
    }
    virtual void print(ostream& stream) {
        stream << "[" << min << "<>" << max << "]";
    }
};

template <class T>
class ITrustedVariable {
private:
    const string name;
    T value;
    ITrustedVariableTrait<T> *trait;
    void ReportError(string error) {
        throw error;
    }
public:
    friend ostream& operator<< (ostream &stream, const ITrustedVariable<T> &var) {
        stream << "{ " << var.name << ": " << var.value << " " << *(var.trait) << " " <<" }";
        return stream;
    }
    ITrustedVariable& operator= (const ITrustedVariable<T>& _var) {
        operator= (_var.value);
    }
    ITrustedVariable& operator= (const T& _value) {
        cout << "Set \"" << name << "\" to \"" << _value << "\"..." << endl;
        if ( trait->AcceptValue(_value) )
            value = _value;
        else ReportError(trait->GetError(_value));
    }
    explicit ITrustedVariable(string _name, T _value, ITrustedVariableTrait<T> *_trait) : name{_name}, value{_value}, trait{_trait}
    {
        cout << "Initialize \"" << name << "\" to \"" << _value << "\"..." << endl;
        if (!_trait->AcceptValue(_value))
            ReportError(_trait->GetError(_value));
    }
};

#endif
