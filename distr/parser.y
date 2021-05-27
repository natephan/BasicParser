// Nathan Phan
// nphan23 - 661680107
// HW 2 Submission 1

%{
#include <stdio.h>
#include "util.h"
#include "errormsg.h"

int yylex(void); /* function prototype */

void yyerror(const char *s)
{
 EM_error(EM_tokPos, "%s", s);
}
%}


%union {
	int ival;
	string sval;
	}

%error-verbose

%token <sval> ID STRING
%token <ival> INT

%token 
  COMMA COLON SEMICOLON LPAREN RPAREN LBRACK RBRACK 
  LBRACE RBRACE
  PLUS MINUS TIMES DIVIDE EQ NEQ LT LE GT GE
  AND OR ASSIGN
  ARRAY IF THEN ELSE WHILE FOR DO 
  INTTY STRINGTY FUN RETURNS RETURN
%left OR
%left AND
%nonassoc EQ NEQ LT GT LE GE
%left PLUS MINUS
%left TIMES DIVIDE

%start program

%%

program:	stmts

stmts:
  | stmt stmts

stmt:
    lvalue ASSIGN exp SEMICOLON                   // assignment
  | ty ID SEMICOLON                               // variable declaration
  | ty ID ASSIGN exp SEMICOLON                    // variable definition
  | ty LBRACK INT RBRACK ID ASSIGN exp SEMICOLON  // array declaration
  | IF LPAREN exp RPAREN stmt ELSE stmt           // if-then-else
  | WHILE LPAREN exp RPAREN stmt                  // while loop
  | FOR LPAREN ID ASSIGN exp SEMICOLON exp SEMICOLON stmt RPAREN stmt   // for loop
  | LBRACE stmts RBRACE                           // code block
  | RETURN exp SEMICOLON                          // return statement
  | FUN ID RETURNS ty LPAREN params RPAREN LBRACE stmts RBRACE 

 /* Write two things that are statements in this language:
    1. x = 5 + 3;
    2. while (i < 4) i = i + 1;
 */

exp:   
    lvalue                  // variable or array access
  | INT                     // integer literal
  | STRING                  // string literal
  | exp PLUS exp
  | exp MINUS exp           
  | exp TIMES exp
  | exp DIVIDE exp
  | exp EQ exp
  | exp NEQ exp
  | exp LT exp
  | exp GT exp
  | exp LE exp
  | exp GE exp
  | exp AND exp
  | exp OR exp
  | ID LPAREN args RPAREN

 /* Write two things that are expressions in this language:
    1. 1 + 2
    2. 3 > 4
 */

ty:
    INTTY
  | STRINGTY
  | ty LBRACK RBRACK

lvalue:
    ID
  | lvalue LBRACK exp RBRACK

args:
  | exp
  | exp COMMA args

params:
  | ty ID
  | ty ID COMMA params
