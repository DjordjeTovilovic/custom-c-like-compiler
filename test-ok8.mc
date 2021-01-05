//OPIS: postinkrement

int abs(int i) {
  int res, a, b;
  a = i++;
  b = res + b++ - i;
  if(i < 0)
    res = 0 - i;
  else 
    res = i; 
  return res;
}

int main() {
  return abs(-5);
}
