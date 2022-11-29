int abs(int i) {
  int res, a, b;
  if(i < 0)
    res = 0 - i;
  else 
    res = i;
  return res;
}

int main() {
  select a,b,c from tabla where ( a == 5); 
  do 
    a = 5;
    b = 6;
    b = a;
    a = a + b;
    do
      c =1;
    while(a == 1);
  while(a > 0);
  a = a++ + b;
  a = b +  c++ - 5;
  a = a++;
  a++;

  for a = 5 to 10 step 4
    b = 20;
    c++;
  next d 
  for i = 1 to 9
    a = a + 1;
  next i
  for j = 10 downto 0 step 2
    a = a - 1;
  next j

  a = foo(2, 3u, a+b);
  return abs(-5);
}

int foo(int p, int b, unsigned c){
  return p;
}
