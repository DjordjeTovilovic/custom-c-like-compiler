//OPIS: pogresan broj argumenata

int abs(int i) {
  int res;
  if(i < res)
    res = 0 - i;
  else 
    res = i; 
  return res;
}

int main() {
  return abs(-5, 5);
}
