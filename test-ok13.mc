//OPIS: iterate petlja i ugnezdena iterate petlja

int abs(int i, int g, int s) {
  int z, res, a, b;
  unsigned w;
  a = 5 + b * z;
  a++;

  iterate z 5 : 2
    res = b * 2;
    step 1;

  
  iterate a 5 : 2
      iterate g 5 : 2 
        s = a / 5;
        step 2;
    step 1;


  if(i < 0) {
    res = 0 - i;
  }
  else {

    res = i; 
  }
  res++;
  return res;
}


int main() {
  unsigned y;
  int t;
  return abs(-5, 5, t);
}