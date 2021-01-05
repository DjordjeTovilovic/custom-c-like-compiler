//OPIS: int/unsigned funkcija bez return-a / sa return; ,treba da izbaci warning

int abs(int i) {
  int res, a, b;
  a = i++;
  b = res + b++ - i;
  if(i < 0)
    res = 0 - i;
  else 
    res = i; 
  
}

int ab(int i) {
  int res, a, b;
  a = i++;
  b = res + b++ - i;
  if(i < 0)
    res = 0 - i;
  else 
    res = i; 
  return ;
}


unsigned ufa(int i) {
  int res, a, b;
  a = i++;
  b = res + b++ - i;
  if(i < 0)
    res = 0 - i;
  else 
    res = i; 
  
}

unsigned ufb(int i) {
  int res, a, b;
  a = i++;
  b = res + b++ - i;
  if(i < 0)
    res = 0 - i;
  else 
    res = i; 
  return ;
}




int main() {
  ufa(2);
  ufb(3);
  ab(2);
  return abs(-5);

}
