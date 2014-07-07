/*
 * Implementation of an unknown number of nested loops
 * Based on:
 *   http://stackoverflow.com/questions/9555864/variable-nested-for-loops
 */
#include <stdlib.h>
#include <iostream>

using namespace std;

#define MAX_N_LOOP 10
#define MAX_N_MAX 1000

bool _checkValues(int n, int nmax);
int main(int ac, char *av[]) {
    if (ac < 3) {
        cout << "Please specify a positive number of nested loop and a maximum value for each loop index..." << endl;
        return -1;
    }
    const int n = atoi(av[1]);
    const int nmax = atoi(av[2]);
    if (!_checkValues(n, nmax))
        return -1;

    int *i = new int[n + 1]; // if "n" is not known before hand, then this array will need to be created dynamically.
    //Note: there is an extra element at the end of the array, in order to keep track of whether to exit the array.

    for (int a = 0; a < n + 1; a++) {
        i[a] = 0;
    }

    int p = 0; //Used to increment all of the indicies correctly, at the end of each loop.
    while (i[n] == 0) {//Remember, you're only using indicies i[0], ..., i[n-1]. The (n+1)th index, i[n], is just to check whether to the nested loop stuff has finished.
        cout << "(" << i[0];
        for (int a = 1; a < n; a++) {
            cout << "," << i[a];
        }
        cout << ")" << endl;
        //DO STUFF HERE. Pretend you're inside your nested for loops. The more usual i,j,k,... have been replaced here with i[0], i[1], ..., i[n-1].

        //Now, after you've done your stuff, we need to incrememnt all of the indicies correctly.
        i[0]++;
        p = 0;//Commented out, because it's replaced by a more efficient alternative below.
        while ( i[p] == nmax) { //(or "MAX[p]" if each "for" loop is different. Note that from an English point of view, this is more like "if(i[p]==MAX". (Initially i[0]) If this is true, then i[p] is reset to 0, and i[p+1] is incremented.
            i[p] = 0;
            i[++p]++; //increase p by 1, and increase the next (p+1)th index
        }
    }
    delete [] i;
}

bool _checkValues(int n, int nmax) {
    if (n < 0 || n > MAX_N_LOOP) {
        if (n < 0)
            cout << "Please specify a positive number of nested loops..." << endl;
        else if (n > MAX_N_LOOP) {
            cout << "Please specify a number less than " << MAX_N_LOOP << "for the number of nested loops..." << endl;
        }
        return false;
    }
    if (nmax < 0 || nmax > MAX_N_MAX) {
        if (nmax < 0)
            cout << "Please specify a positive number for the loops max index..." << endl;
        else if (nmax > MAX_N_MAX) {
            cout << "Please specify a number less than " << MAX_N_MAX << "for the loops max index..." << endl;
        }
        return false;
    }
    return true;
}
