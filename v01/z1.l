%option noyywrap
%%

[+-]?([0]?|[1-9]+)                  { printf("Ceo broj: %s\n", yytext); }
[0][xX][0-9a-fA-F]{1,4}             { printf("Hex broj: %s\n", yytext); }
[0-9]+\.[0-9]*                      { printf("Realni broj: %s\n", yytext); }
[0-9]+\.[0-9]*[eE]?[+-][0-9]{1,3}   { printf("Realni broj: %s\n", yytext); }
[bB][rR][eE][aA][kK]                { printf("Kljucna rec: %s\n", yytext); }
\/\/.*                              { yytext = ""; }
"/*"([^*]|("*"+[^*/]))*"*/"         { yytext = ""; }


[0-9]+[fF]                          { char broj[strlen(yytext)-1];
                                      strncpy(broj,yytext,strlen(yytext)-1);
                                      int stepeni = atoi(broj);
                                      stepeni = (stepeni - 32) * 5/9;
                                      printf("%dC",(char)stepeni); }

%%

int main() {
  yylex();
}
