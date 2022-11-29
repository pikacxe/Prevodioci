%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
  int upitne = 0;
  int uzvicne = 0;
  int izjavne = 0;
  int pasusi = 0;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token  _EXCLAMATION_MARK
%token  _QUESTION_MARK
%token  _COMMA
%token  _NL
%token  _OSOBA
%token  _DVETACKE
%token  _BROJ
%token  _LPAREN
%token  _RPAREN

%%

text 
  : pasus 
  {
    pasusi++;
  }
  | text _NL pasus
  {
    pasusi++;
  }
  ;

pasus
  : sentence
  | drama
  | pasus sentence
  | pasus drama
  | list
  | pasus list
  ;

drama
  : _OSOBA _DVETACKE sentence
  ;

list
  : _BROJ _DOT sentence
  ;

zagrade
  : _LPAREN _RPAREN
  | _LPAREN words _RPAREN
  ;

sentence 
  : words _DOT
  {
    izjavne++;
  }
  | words _EXCLAMATION_MARK
  {
    uzvicne++;
  }
  | words _QUESTION_MARK
  {
    upitne++;
  }
  ;

words 
  : _WORD
  | _CAPITAL_WORD
  | words _WORD
  | words _CAPITAL_WORD
  | words delimiter
  | zagrade
  | words zagrade
  ;

delimiter
  : _COMMA _WORD
  | _COMMA _CAPITAL_WORD
  ;

%%

int main() {
  yyparse();
  printf("\nImamo ");
  if(uzvicne){
    printf("%d uzvicnih",uzvicne);

  }
  if(upitne){
    printf(" %d upitnih",upitne);
  }
  if(izjavne){
    printf(" %d izjavnih",izjavne);
  }
  printf("\n");
  printf("Broj pasusa %d\n", pasusi);
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

