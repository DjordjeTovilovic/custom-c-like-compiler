//OPIS: iterate petlja i ugnezdena iterate petlja
//RETURN 30
int ugnjezdena(){
  int a, g, s;
  s = 0;
  iterate a 5 : 2
      iterate g 5 : 2 
        s = s + 5;
        step 2;
    step 1;

  return s;
}

int petlja() {
  int res, b, z;
  res = 1;
  iterate z 5 : 2
      res = res * 2;
      step 1;
  return res;
}


int main() {
  unsigned y;
  int t;
  return ugnjezdena();
}