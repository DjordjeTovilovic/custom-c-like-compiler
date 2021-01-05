//OPIS: iterate vrjednost min-a je veca od max-a

int abs(int i) {
  int res;

  iterate i 5 : 7
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
