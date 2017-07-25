#include <vector>
#include <iostream>
#include <algorithm>

using namespace std;

int main(int argc, char *argv[]) {
    vector<int>::iterator iterator;
    vector<int> vect;
    const int limit = 10;
    for ( int i = 0; i < limit; i++ )
        vect.push_back( i + 1 );

    /** C++11 method -requires -std=c++11- **/
    cout << "C++11\n" << endl;

    for ( iterator = vect.begin(); iterator != vect.end(); ++iterator )
        cout << "<" << *iterator << ">";
    cout << endl;
    // Remove all odd numbers and 6
    vect.erase(remove_if(vect.begin(), vect.end(), [] (int val) { return val % 2 == 1 || val == 6; }), vect.end());
    for ( iterator = vect.begin(); iterator != vect.end(); ++iterator )
        cout << "<" << *iterator << ">";
    cout << endl;

    vect.clear();
    for ( int i = 0; i < limit; i++ )
        vect.push_back( i + 1 );

    /** Older method **/
    cout << "\nOlder method\n" << endl;

    for ( iterator = vect.begin(); iterator != vect.end(); ++iterator )
        cout << "<" << *iterator << ">";
    cout << endl;
    // Count odd numbers and 6
    int count = 0;
    for ( iterator = vect.begin(); iterator != vect.end(); ++iterator )
        if (*iterator % 2 == 1 || *iterator == 6)
            count++;
    // Remove all odd numbers and 6
    for (int i = 0; i < count; ++i) {
        for ( iterator = vect.begin(); iterator != vect.end(); ++iterator )
            if (*iterator % 2 == 1 || *iterator == 6) {
                vect.erase(iterator);
                break;
            }
    }
    for ( iterator = vect.begin(); iterator != vect.end(); ++iterator )
        cout << "<" << *iterator << ">";
    cout << endl;
}
