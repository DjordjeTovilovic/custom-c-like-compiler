//OPIS: branch grananje i ugnezdeno branch grananje

int abs(int i, int g, int s) {
  int z, res, a, b;
  unsigned w;
  a = 5 + b * z;
  a++;

  branch ( a ; 1 , 3 , 5 )
    first a = a + 1;
    second a = a + 3;
    third a = a + 5;
    otherwise a = a - 3;
  end_branch


  branch ( a ; 1 , 3 , 5 )
    first a = a + 1;
    second 
      branch ( b ; 1 , 3 , 5 )
        first b = b + 1;
        second b = b + 3;
        third b = b + 5;
        otherwise b = b - 3;
      end_branch
    third a = a + 5;
    otherwise a = a - 3;
  end_branch

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
  abs(-5, 5, 6);
  return 0;
}
