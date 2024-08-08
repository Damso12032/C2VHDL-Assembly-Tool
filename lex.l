%{
    #include "comp.tab.h"
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
%}

%option noyywrap
%option noinput
%option nounput

%%
"if"                                        { return tIF; }
"else"                                      { return tELSE; }
"while"                                     { return tWHILE; }
"print"                                     { return tPRINT; }
"return"                                    { return tRETURN; }
"int"                                       { return tINT; }
"void"                                      { return tVOID; }

[a-zA-Z][a-zA-Z0-9]*                        { yylval.s=strdup(yytext); return tID; }
[0-9]+                                      { yylval.n=atoi(yytext);return tNB; }
0[xX][0-9a-fA-F]+                           { yylval.n=strtol(yytext,NULL,16);return tNB; }

"//"(.*)                                    { /* ignore comments */ }
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]         { /* ignore multiline comment */ } 

"+"                                         { return tADD; }
"-"                                         { return tSUB; }
"*"                                         { return tMUL; }
"/"                                         { return tDIV; }
"<"                                         { return tLT; }
">"                                         { return tGT; }
"!="                                        { return tNE; }
"=="                                        { return tEQ; }
">="                                        { return tGE; }
"<="                                        { return tLE; }
"="                                         { return tASSIGN; }
"&&"                                        { return tAND; }
"||"                                        { return tOR; }
"!"                                         { return tNOT; }
"{"                                         { return tLBRACE; }
"}"                                         { return tRBRACE; }
"("                                         { return tLPAR; }
")"                                         { return tRPAR; }
";"                                         { return tSEMI; }
","                                         { return tCOMMA; }

[ \t\r\n]+                                  { /* ignore whitespace */ }


%%
