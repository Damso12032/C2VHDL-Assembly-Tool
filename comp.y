%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "ts.h"
%}

%code provides {
  int yylex (void);
  void yyerror (const char *);
}

%union{
  char *s;
  long n;
}

%token <n> tNB
%token <s> tID
%token <n> tIF
%token <n> tELSE
%token <n> tWHILE

%token tLT tGT tNE tEQ tGE tLE tPRINT tRETURN tINT tVOID tADD tSUB tMUL tDIV tASSIGN tAND tOR tNOT tLBRACE tRBRACE tLPAR tRPAR tSEMI tCOMMA 
%left tLT tGT tNE tEQ tGE tLE tASSIGN tADD tSUB tMUL tDIV

%%

S: 
    %empty
  | Funs { display_asm();}
  ;

Funs: 
    Fun 
  | Fun Funs
  ;

Fun: 
    Ret tID tLPAR {addDetailFonction($2); addVar("@ret", profondeurActuelle+1); addVar("@val", profondeurActuelle+1);} Params tRPAR Body {printf("fin de fonction \n");display_ts();}
  | Ret tID tLPAR {addDetailFonction($2); addVar("@ret", profondeurActuelle+1); addVar("@val", profondeurActuelle+1);} tVOID tRPAR Body {printf("fin de fonction \n");display_ts();}
  ;

Ret: 
    tINT 
  | tVOID
  ;

Params: 
    %empty
  | tINT tID {addVar($2,profondeurActuelle+1); update_params_detailFonction();} 
  | tINT tID {addVar($2,profondeurActuelle+1); update_params_detailFonction();} tCOMMA Params
  ;

Body: Tlbrace Ins Trbrace;

Ins: 
    %empty 
  | In Ins
  ;

In:
    Print 
  | Return
  | BoucleWhile
  | CondIf  
  | Declaration
  ;

Print: tPRINT tLPAR tID tRPAR tSEMI {add_instruction("PRI",ts_get_addr($3), -1, -1);printf("print effectué\n");};

Return: 
    tRETURN MembresDroite tSEMI {add_instruction("COP", 1, ts_get_last(), -1); add_instruction("RET", 0 ,-1, -1); printf("return effectué\n");}
  ;

Var: 
    tID {ts_new_tmp(); add_instruction("COP",ts_get_last(),ts_get_addr($1), -1); } 
  | tNB {ts_new_tmp(); add_instruction("AFC",ts_get_last(), $1, -1);}
  ;

BoucleWhile: tWHILE tLPAR Cond tRPAR {add_instruction("JMPF",ts_get_last(),-1,-1);$1=get_nbre_lignes_asm()-1;} Body {add_instruction("JMP",($1-1),-1,-1);updateAsm($1,get_nbre_lignes_asm());printf("fin boucle while\n");};

Cond: 
    Var tEQ Var{add_instruction("EQU",ts_get_next_last(),ts_get_next_last(),ts_get_last());ts_free_last();printf("free last\n");}
  | Var tNE Var{add_instruction("NEQU",ts_get_next_last(),ts_get_next_last(),ts_get_last());ts_free_last();printf("free last\n");}
  | Var tLT Var{add_instruction("INF",ts_get_next_last(),ts_get_next_last(),ts_get_last());ts_free_last();printf("free last\n");}
  | Var tGT Var{add_instruction("SUP",ts_get_next_last(),ts_get_next_last(),ts_get_last());ts_free_last();printf("free last\n");}
  | Var tLE Var{add_instruction("INFE",ts_get_next_last(),ts_get_next_last(),ts_get_last());ts_free_last();printf("free last\n");}
  | Var tGE Var{add_instruction("SUPE",ts_get_next_last(),ts_get_next_last(),ts_get_last());ts_free_last();printf("free last\n");}
  | Var
  ;



CondIf: 
    CondIfWithoutElse {updateAsm(-1,get_nbre_lignes_asm());printf("fin condIf sans else\n");} 
  | CondIfWithoutElse tELSE {add_instruction("JMP",-1,-1,-1);$2=get_nbre_lignes_asm()-1;} Body {updateAsm($2,get_nbre_lignes_asm()); printf("fin condIf avec else\n");}
  ;

CondIfWithoutElse: tIF tLPAR Cond tRPAR {add_instruction("JMPF",ts_get_last(),-1,-1);$1=get_nbre_lignes_asm()-1;} Body{updateAsm($1,get_nbre_lignes_asm()+1);};

Declaration: 
    MembreGauche1 tSEMI {printf("Declaration sans affectation\n");}
  | MembreGauche1 tASSIGN MembresDroite tSEMI {printf("Declaration avec  affectation\n"); updateVar(""); add_instruction("COP",ts_get_addr(get_assignedVar()),ts_get_last(), -1); ts_free_last();}
  | tID tASSIGN MembresDroite tSEMI {printf("Declaration avec  affectation\n"); updateVar($1); add_instruction("COP",ts_get_addr($1),ts_get_last(), -1); ts_free_last();}
  ;

MembreGauche1:tINT Ids;


Ids: 
    tID { if(addVar($1,profondeurActuelle)=='0'){ printf("Variable déja déclaré\n");} update_assignedVar($1);};
  | tID tCOMMA Ids { if(addVar($1,profondeurActuelle)=='0'){ printf("Variable déja déclaré\n"); }}
  ;

MembreDroite:
    Var
  | tID tLPAR {update_tailleActuelle(1+get_nbre_params($1));} Calculs {add_instruction("PUSH", 2+get_nbre_params($1),-1, -1); add_instruction("CALL", getAddrFonction($1),-1, -1); } tRPAR {add_instruction("POP", 2+get_nbre_params($1),-1, -1); update_tailleActuelle(-1-get_nbre_params($1)); add_instruction("COP", ts_get_last(), ts_get_last()+1, -1);  }
  | tID tLPAR {update_tailleActuelle(1+get_nbre_params($1)); add_instruction("PUSH", 2+get_nbre_params($1),-1, -1); add_instruction("CALL", getAddrFonction($1),-1, -1);} tRPAR {add_instruction("POP", 2+get_nbre_params($1),-1, -1); update_tailleActuelle(-1-get_nbre_params($1)); add_instruction("COP", ts_get_last(), ts_get_last()+1, -1); }
  ;

Calculs:  
    MembresDroite 
  | MembresDroite tCOMMA Calculs
  ;

MembresDroite:
    MembresDroite tADD term {add_instruction("ADD",ts_get_next_last(),ts_get_next_last(),ts_get_last()); ts_free_last();printf("free last\n");}
  | MembresDroite tSUB term {add_instruction("SUB",ts_get_next_last(),ts_get_next_last(),ts_get_last()); ts_free_last();printf("free last\n");}
  | term 
  ;

term: 
    term tMUL MembreDroite  {add_instruction("MUL",ts_get_next_last(),ts_get_next_last(),ts_get_last()); ts_free_last();printf("free last\n");}
    | term tDIV MembreDroite {add_instruction("DIV",ts_get_next_last(),ts_get_next_last(),ts_get_last()); ts_free_last();printf("free last\n");}
    | MembreDroite 
    ;

Tlbrace: tLBRACE {profondeurActuelle++;};

Trbrace: tRBRACE {profondeurActuelle--;suppVarErrone();};


%%

void yyerror(const char *msg) {
  fprintf(stderr, "error: %s\n", msg);
  exit(1);
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("Usage: %s input_file\n", argv[0]);
    return 1;
  }
  
  FILE *fp = fopen(argv[1], "r");
  if (!fp) {
    printf("Unable to open file %s\n", argv[1]);
    return 1;
  }

  // Rediriger l'entrée standard vers le fichier
  freopen(argv[1], "r", stdin);

  yyparse();

  fclose(fp);
  return 0;
}

