//OPIS: deklaracija postojece promenjive

int abs(int i) {
  int res;
  int a, b, res;
  if(i < 0)
    res = 0 - i;
  else 
    res = i; 
  return res;
}

int main() {
  return abs(-5);
}
