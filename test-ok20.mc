//OPIS: uslovni izraz
//RETURN: 4


int main() {
    int a, b;    
    a = 1;
    b = 0;
    // a = (a == b) ? a : 0;
    a = a + (a == b) ? a : b + 3; // a + b + 3 = 1 + 0 + 3 = 4
    return a;
}
