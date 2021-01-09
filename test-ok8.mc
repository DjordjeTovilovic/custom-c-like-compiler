//OPIS: postinkrement
//RETURN 6
int abs(int i) {
  int res, a, b;
  a = i++;
  res = 0;
  b = res++;
  b = res + b++ - i;
  return b;
}

int main() {
  return abs(-5);
}
