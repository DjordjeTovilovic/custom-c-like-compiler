//OPIS: uslovni izraz
//RETURN: 5


int main() {
    int a, b;    
    a = 1;
    b = 1;
    // a = (a == b) ? a : 0;
    a = a + (a == b) ? a : b + 3; // a + a + 3 = 1 + 1 + 3 = 5
    return a;
}
