%{
  #include <stdio.h>
  #include "defs.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  extern int yylineno;
%}

%token _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token _ID
%token _INT_NUMBER
%token _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token _AROP
%token _RELOP
%token _COMMA
%token _SELECT
%token _WHERE
%token _FROM
%token _DO
%token _WHILE
%token _INC
%token _FOR
%token _DIRECTION
%token _STEP
%token _LBPAREN
%token _RBPAREN
%token _NEXT

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : function_list
  ;

function_list
  : function
  | function_list function
  ;

function
  : type _ID _LPAREN parameter_list _RPAREN body
  ;

type
  : _TYPE
  ;

parameter
  : type _ID
  ;

parameter_list
  : /* empty */
  | parameter
  | parameter_list _COMMA parameter
  ;

body
  : _LBRACKET variable_list statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
  : type vars _SEMICOLON
  ;

vars
  : _ID
  | vars _COMMA _ID
  ;

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | assignment_statement
  | if_statement
  | return_statement
  | select_statement
  | do_while
  | basic_for
  | inc_exp _SEMICOLON
  ;

select_statement
  : _SELECT vars _FROM _ID _WHERE _LPAREN rel_exp _RPAREN _SEMICOLON
  ;

do_while
  : _DO statement_list _WHILE _LPAREN rel_exp _RPAREN _SEMICOLON
  ;

basic_for
  : _FOR _ID _ASSIGN literal _DIRECTION literal step_count statement_list _NEXT _ID
  ;

step_count
  : /* empty */
  | _STEP literal
  ;

compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
  ;

inc_exp
  : _ID _INC
  ;

num_exp
  : exp
  | num_exp _AROP exp
  ;

exp
  : literal
  | _ID
  | function_call
  | inc_exp
  | _LPAREN num_exp _RPAREN
  ;

literal
  : _INT_NUMBER
  | _UINT_NUMBER
  ;

function_call
  : _ID _LPAREN argument_list _RPAREN
  ;

argument
  : num_exp
  ;

argument_list
  : /* empty */
  | argument
  | argument_list _COMMA argument
  ;


if_statement
  : if_part %prec ONLY_IF
  | if_part _ELSE statement
  ;

if_part
  : _IF _LPAREN rel_exp _RPAREN statement
  ;

rel_exp
  : num_exp _RELOP num_exp
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s\n", yylineno, s);
  return 0;
}

int main() {
  return yyparse();
}
