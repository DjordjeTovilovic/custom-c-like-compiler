//OPIS: iterate iterator nije prethodno definisan

int abs(int i) {
  int res;

  iterate z 5 : 2
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
