%{
#include <stdio.h>
#include <stdlib.h>
#include "parser2.tab.h"
void errorLexico();
%}
LETRA            [a-z]
PUNTO            ["."]
PUNTOYCOMA       [";"]


PRAPERTURA       "inicio"
PRCIERRE         "fin"
PRSALUDAR        "saludar"
PRDESPEDIRSE     "despedirse"
PRCALCULAR       "calcular"


%%

inicio        {printf("\nSe inicio la calculadora de meses\n");return PRAPERTURA;}
fin           { printf("\nSe cierra la calculadora de meses\n"); exit(0); return PRCIERRE; }
saludar       {printf("\nPRSALUDAR (%s) \n" ,yytext);return PRSALUDAR;}
despedirse    {printf("\nPRDESPEDIRSE (%s) \n" ,yytext);return PRDESPEDIRSE;}
calcular      {printf("\nPRCALCULAR (%s) \n" ,yytext);return PRCALCULAR;}
";"           {return PUNTOYCOMA;}

{LETRA}({LETRA}|[0-9])*{PUNTO} {printf("\nIDENTIFICADOR (%s) \n",yytext);return IDENTIFICADOR;}


[0-9][0-9] {
    int val = atoi(yytext);
    if (val >= 1 && val <= 12) {
        yylval.num = val;
        return MES;
    } else {
        fprintf(stderr, "Valor ingresado '%s' no corresponde a un mes valido.\n", yytext);
    }
}

[\t\n ]  ; // Ignorar espacios en blanco y saltos de línea

. {errorLexico();}

%%

void errorLexico(){
    printf("\nError lexico: Caracter invalido: %s\n" , yytext);
}