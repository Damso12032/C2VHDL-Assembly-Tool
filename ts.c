#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "ts.h"

int tailleActuelle=0;
int profondeurActuelle=-1;
char assignedVar[8];
int nbre_lignes_asm=1;
int nbre_fonctions=0;
int addr_main=1;


char existIn(char nom[8]){
    for(int i=0;i<tailleActuelle;i++){
        if(strcmp(tableau[i].nom,nom)==0 && tableau[i].profondeur==profondeurActuelle){
            return '1';
        }
    }
    return '0';
}


char addVar(char nom[8],int profondeur){
    if(existIn(nom)=='0'){
        ligne_tableau ligne_tableau1;
        strcpy(ligne_tableau1.nom,nom);
        ligne_tableau1.init=0;
        ligne_tableau1.profondeur=profondeur;
        tableau[tailleActuelle++]=ligne_tableau1;
        printf("variable %s ajouté avec profondeur %d\n",tableau[tailleActuelle-1].nom,tableau[tailleActuelle-1].profondeur);
        return '1';
   }
    return '0';
}
//ajoute une variable temporelle à notre table 
void ts_new_tmp(){
    tailleActuelle++;
}
//supprime la derniére variable dans notre table 
void ts_free_last(){
    tailleActuelle--;
}
//retourne l'indice du dernier element
int ts_get_last(){
    return tailleActuelle-1;
}
//retourne l'indice de l'avant dernier element
int ts_get_next_last(){
    return tailleActuelle-2;
}

//retourne l'indice de l'element qui a pour nom "nom" 
int ts_get_addr(char nom[8]){
    for(int i=0;i<tailleActuelle;i++){
        if(strcmp(tableau[i].nom,nom)==0){
            return i;
        }
    }
    return -1;
}

void display_ts() {
    for (int i=0; i<tailleActuelle; i++) {
        printf("nom : %s init : %d profondeur : %d\n", tableau[i].nom, tableau[i].init, tableau[i].profondeur);
    }
}

void suppVarErrone(){
    while(tailleActuelle!=0 && tableau[tailleActuelle-1].profondeur>profondeurActuelle){
        printf("variable %s supprimé\n",tableau[tailleActuelle-1].nom);
        tailleActuelle--;
    }
}
void updateVar(char nom[8]){
   if(strlen(nom)==0){
        tableau[tailleActuelle-1].init=1;
    }
    else{
        for(int i=0;i<tailleActuelle;i++){
                if(strcmp(tableau[i].nom,nom)==0){
                    tableau[i].init=1;
                    break;
                }
            }
    }
}

void update_assignedVar(char nom[8]) {
    strcpy(assignedVar, nom);
}

char* get_assignedVar() {
    return assignedVar;
}

int get_nbre_lignes_asm(){
    return nbre_lignes_asm;
}
//fonction qui modifie l'op2 de l'intruction numéro "indice"(utilisé pour les if et while)
void updateAsm(int indice, long op){
    if(assembleur[indice].op1==-1){
        assembleur[indice].op1=op;
    } else if (assembleur[indice].op2==-1){
        assembleur[indice].op2=op;
        printf("update op2\n");
    }
    else{
        int i=nbre_lignes_asm-1;
        while(strcmp(assembleur[i].nom,"JMPF")||assembleur[i].op2!=nbre_lignes_asm+1){
            i--;
        }
       assembleur[i].op2=op; 
    }
}


void add_instruction (char nom[8], long op1, long op2, long op3) {
    instruction inst;
    strcpy(inst.nom,nom);
    inst.op1 = op1; 
    inst.op2 = op2; 
    inst.op3 = op3;
    assembleur[nbre_lignes_asm] = inst;
    nbre_lignes_asm++;
}

void display_asm() {
    FILE * fichier=NULL;
    fichier=fopen("asm.txt","w");

    printf("L0: JMP %d\n", addr_main);
    fprintf(fichier,"JMP %d 0 0\n",addr_main);

    for (int i=1; i<nbre_lignes_asm; i++) {
        if (assembleur[i].op1 == -1) {
            printf("L%d: %s\n", i, assembleur[i].nom);
            fprintf(fichier,"%s 0 0 0\n",assembleur[i].nom);
        } else if (assembleur[i].op2 == -1) {
                printf("L%d: %s %ld\n", i, assembleur[i].nom, assembleur[i].op1);
                fprintf(fichier,"%s %ld 0 0\n",assembleur[i].nom,assembleur[i].op1);
        } else{ 
            if(assembleur[i].op3 == -1){
                    printf("L%d: %s %ld %ld\n", i, assembleur[i].nom, assembleur[i].op1, assembleur[i].op2);
                    fprintf(fichier,"%s %ld %ld 0\n",assembleur[i].nom,assembleur[i].op1,assembleur[i].op2);
            } else { 
                printf("L%d: %s %ld %ld %ld\n", i, assembleur[i].nom, assembleur[i].op1, assembleur[i].op2, assembleur[i].op3); 
                fprintf(fichier,"%s %ld %ld %ld\n",assembleur[i].nom,assembleur[i].op1,assembleur[i].op2,assembleur[i].op3);
            }
        }
        
    }
}


void addDetailFonction(char nom[8]){
    detail_fonction detail;
    strcpy(detail.nom,nom);
    detail.addrFonction=get_nbre_lignes_asm();
    detail.nbre_params=0;
    details_fonctions[nbre_fonctions]=detail;
    nbre_fonctions++;

    if (strcmp(nom,"main")==0) {
        addr_main = nbre_lignes_asm;
    }
}

void update_params_detailFonction() {
    details_fonctions[nbre_fonctions-1].nbre_params++;
}

int get_nbre_params(char nom[8]) {
    for(int i=0; i<nbre_fonctions; i++) {
        if(!strcmp(details_fonctions[i].nom, nom)) {
            return details_fonctions[i].nbre_params;
        }
    }
    return -1;
}

int getAddrFonction(char nom[8]){
    int i=0;
    while(i<TAILLE_ASM && strcmp(details_fonctions[i].nom,nom)!=0){
        i++;
    }
    return details_fonctions[i].addrFonction;
}

void update_tailleActuelle(int offset){
    tailleActuelle += offset;
}

#if 0
int main(){
    addVar("a",'1');
    addVar("b",'0');
    printf("nom:%s,init:%c,profondeur:%d,taille:%d\n",tableau[1].nom,tableau[1].init,tableau[1].profondeur,tailleActuelle);
    suppVarErrone(0);
    printf("nom:%s,init:%c,profondeur:%d,taille:%d\n",tableau[0].nom,tableau[0].init,tableau[0].profondeur,tailleActuelle);
    return 0;
}
#endif