#define TAILLE 200
#define TAILLE_ASM 256

typedef struct {
    char nom[8];
    char init;
    int profondeur;
} ligne_tableau;

typedef struct {
    char nom[8];
    long op1;
    long op2;
    long op3;
} instruction;
typedef struct{
    char nom[8];
    int addrFonction;
    int nbre_params;
} detail_fonction;

extern int tailleActuelle;
extern int profondeurActuelle;
extern char assignedVar[8];         // stocker le nom de la dernière variable à assigner
extern int nbre_lignes_asm;
extern int nbre_fonctions;
ligne_tableau tableau[TAILLE];
instruction assembleur[TAILLE_ASM];           // tableau du code assembleur
detail_fonction details_fonctions[TAILLE_ASM];

void suppVarErrone();
char addVar(char nom[8],int);
void updateVar(char nom[8]);

int ts_get_addr(char nom[8]);
int ts_get_next_last();
int ts_get_last();
void ts_free_last();
void ts_new_tmp();
void display_ts();
void update_assignedVar(char[8]);
char* get_assignedVar();

int get_nbre_lignes_asm();
void add_instruction (char[8], long, long, long);
void display_asm();
void updateAsm(int indice, long op2);

void addDetailFonction(char[8]);
int getAddrFonction(char[8]);
void update_params_detailFonction();
int get_nbre_params(char[8]);
void update_tailleActuelle(int);