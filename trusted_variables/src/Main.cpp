#include "ITrustedVar.hpp"
#include <iostream>

using namespace std;

int main(int ac, char *av[]) {
    try {
        ITrustedVariableTraitRange<float> trait(0.0f, 100.0f);
        ITrustedVariable<float> var("var", 1.0f, &trait);
        cout << ">>> " << var << endl;

        ITrustedVariableTraitRange<float> trait2(-10.0f, 0.0f);
        ITrustedVariable<float> var2("var2", -1.0f, &trait2);
        cout << ">>> " << var2 << endl;

        var2 = var;
        cout << ">>> " << var2 << endl;
    } catch (string &error) {
        cout << "Error! { " << error << " }";
    }
}
