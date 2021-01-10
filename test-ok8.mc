//OPIS: postinkrement
//RETURN: 1

int increment(int i) {
  int res, a, b;
  a = i++;
  res = 0;
  b = res++;
  b = res + b++;
  return b;
}

int main() {
  return increment(-5);
}
