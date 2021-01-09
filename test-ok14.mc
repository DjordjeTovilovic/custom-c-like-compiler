//OPIS: branch grananje i ugnezdeno branch grananje
//RETURN 12
int grananje(){
  int res, a;
  res = 0;
  branch ( a ; 1 , 3 , 5 )
    first a = a + 1;
    second a = a + 3;
    third a = a + 5;
    otherwise a = a - 3;
  end_branch

  return a;
}

int ugnjezdeno() {
  int res, a, b;
  res = 0;
  a = 3;
  b = 1;
  branch ( a ; 1 , 3 , 5 )
    first a = a + 1;
    second 
      branch ( b ; 1 , 3 , 5 )
        first b = b + 11;
        second b = b + 3;
        third b = b + 5;
        otherwise b = b - 3;
      end_branch
    third a = a + 5;
    otherwise a = a - 3;
  end_branch

  return b;

}

int main() {
  int a;
  a = grananje();
  return ugnjezdeno();
}
