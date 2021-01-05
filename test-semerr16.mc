//OPIS: branch literali nisu istog tipa kao promjenjiva

int abs(int i) {
  int res, a;

  branch ( res ; 1 , 3 , 5u )
    first a = a + 1;
    second a = a + 3;
    third a = a + 5;
    otherwise a = a - 3;
  end_branch


  if(i < res)
    res = 0 - i;
  else 
    res = i; 
  return res;
}

int main() {
  return abs(-5);
}
