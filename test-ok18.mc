//OPIS: uslovni izraz
//RETURN: 1


int main() {
    int a, b;    
    a = 1;
    b = 1;
    a = (a == b) ? a : 0;
    // a = a + (a == b) ? a : b + 3;
    return a;
}
