%option noyywrap yylineno
%{
  #include "text.tab.h"
%}

%%

[ \t]+      { /* skip */ }
[\n]+       { return _NL; }

"."         { return _DOT; }
[A-Z][a-z]* { return _CAPITAL_WORD; }
[a-z]+      { return _WORD; }
"?"         { return _QUESTION_MARK; }
"!"         { return _EXCLAMATION_MARK; }
","         { return _COMMA; }
":"         { return _DVETACKE; }
[1-9][0-9]*      { return _BROJ; }
"HAMLET"|"KLAUDIJE"|"OFELIJA" { return _OSOBA; }
"("         { return _LPAREN; }
")"         { return _RPAREN; }
                     
.           { printf("\nline %d: LEXICAL ERROR on char %c", 
                      yylineno, *yytext); }    

