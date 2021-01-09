//OPIS: mnozenje i deljenje
//RETURN -3
int test(int i) {
  int res, a, b;
  b = 3;
  res = 5;
  a = i * b / 5;
  b = res + b++ * i / a;
  res = res / 2;
  return a;
}

int main() {
  return test(-5);
}
