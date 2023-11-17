%{
#include <stdio.h>
#include <stdlib.h>
#include "parser2.tab.h"
int yylex();
void yyerror(const char *s);

const char *meses[] = {"", "enero", "febrero", "marzo", "abril", "mayo", "junio",
                        "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"};
%}

%union {
    int num;
}

%token <num> MES
%token IDENTIFICADOR
%token PRAPERTURA
%token PRCIERRE
%token PRSALUDAR
%token PRDESPEDIRSE
%token PRCALCULAR
%token PUNTOYCOMA

%%

PROGRAMA: PRAPERTURA sentencias PRCIERRE ;



sentencias: sentencia | sentencia sentencias ;

sentencia: PRCALCULAR MES PUNTOYCOMA{
    if ($2 >= 1 && $2 <= 12) {
        printf("El numero %d corresponde al mes de %s.\n", $2, meses[$2]);
    } else {
        fprintf(stderr, "Valor ingresado '%d' no corresponde a un mes valido.\n", $2);
    }
    }
    |IDENTIFICADOR PUNTOYCOMA 
    |PRSALUDAR PUNTOYCOMA { printf("Hola, por favor, ingresa una fecha con el formato MM.\n"); }
    |PRDESPEDIRSE PUNTOYCOMA { printf("Chau.\n"); }
    ;
    

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}