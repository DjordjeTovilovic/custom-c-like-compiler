//OPIS: argument pogresnog tipa

int abs(int i, int s) {
  int res;
  if(i < res)
    res = 0 - i;
  else 
    res = i; 
  return res;
}

int main() {
  return abs(-5, 5u);
}
