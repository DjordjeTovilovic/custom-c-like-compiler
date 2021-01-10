//OPIS: dodjela vrjednosti drugog tipa u listu

int main() {
    int b;
    int a[3];
    int c;
    
    a[1] = 5u;
    a[0] = 8;

    b = 2 * a[2] + 3 + a[1] * 2; // 2*3 + 3 + 5*2 = 19 
    return b;
}
