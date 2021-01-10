//OPIS: delaracija vise promjenjivih 
//RETURN: 5

int abs(int i) {
  int res, a, b;
  unsigned c, d, e, g;
  a = i;
  e = 5u;
  if(i < 0)
    res = 0 - i;
  else 
    res = i; 
  return res;
}

int main() {
  return abs(-5);
}
