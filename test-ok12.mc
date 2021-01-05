//OPIS: mnozenje i deljenje

void abs(int i) {
  int res, a, b;
  a = i * b;
  b = res + b++ * i / a;
  res = res / 2;
  if(i < 0)
    res = 0 - i;
  else 
    res = i; 
}

int main() {
  abs(-5);
  return 0;
}
