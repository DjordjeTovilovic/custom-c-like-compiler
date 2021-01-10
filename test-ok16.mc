//OPIS: inicializacija liste, dodjeljivanje vrednosti, i koristenje vrednosti elemenata liste u dodjeli sa unsigned brojevima
//RETURN: 6


unsigned main() {
    unsigned b,d;
    unsigned a[3];
    d = 8u;
    
    a[2] = 3u;
    a[1] = 5u;
    a[0] = d;

    b = a[2] - 5u + a[0]; // 3u - 5u + 8u = 6
    return b;
}
