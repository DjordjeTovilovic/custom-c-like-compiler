//OPIS: iterate literali razlicitog tipa

int abs(int i) {
  int res;

  iterate i 5 : 2u
    res = i * 2;
    step 1;

  if(i < res)
    res = 0 - i;
  else 
    res = i; 
  return res;
}

int main() {
  return abs(-5);
}
