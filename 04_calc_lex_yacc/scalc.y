%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
void prompt(void);
void anser(int);
%}
%token OPLPA
%token OPRPA
%left  UMINUS
%left  OPMUL OPDIV OPMOD
%left  OPADD OPSUB
%token TKCR
%token TKNUM
%start line

%%
line : /* empty */
     | line expr TKCR { anser($2);
                        prompt();
                      }
     | line      TKCR { return 0; }
     ;
expr : term             { $$ = $1; }
     | expr OPADD term  { $$ = $1 + $3; }
     | expr OPSUB term  { $$ = $1 - $3; }
     ;
term : fact             { $$ = $1; }
     | term OPMUL fact  { $$ = $1 * $3; }
     | term OPDIV fact  { $$ = $1 / $3; }
     | term OPMOD fact  { $$ = $1 % $3; }
     ;
fact : prim     
     | OPSUB prim %prec UMINUS { $$ = -$2; }
     ;
prim : TKNUM            { $$ = $1; }
     | OPLPA expr OPRPA { $$ = $2; }
     ;
%%
#include "lex.yy.c"
int main(void)
{
  printf("Formula calculator start!\n");
  prompt();
  yyparse();
  printf("Goodbye\n");
}
void anser(int val)
{
  printf("\t\tANSER=%d \t[%04X]\n" ,val,val);
}
void prompt()
{
  printf("? ");
}
