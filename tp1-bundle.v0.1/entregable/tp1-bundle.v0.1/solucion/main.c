#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>

#include "lib.h"

void test_list(FILE *pfile){

}

void test_tree(FILE *pfile){

}

void test_document(FILE *pfile){

}

extern int32_t floatCmp(float* a, float* b);
void floatCmpTest();

extern uint32_t strLen(char* a);
void strLenTest();

extern char* strClone(char* a);
//void strCloneTest();

extern int32_t strCmp(char* a, char* b);
void strCmpTest();

extern void strDelete(char* a);
void strDeleteTest();




int main (void){

    // Team
     //floatCmpTest();
    //
    //strCloneTest(); // ver caso vacio
     //strLenTest();
     //strCmpTest();


    // catedra
    FILE *pfile = fopen("salida.caso.propios.txt","w");
    test_list(pfile);
    test_tree(pfile);
    test_document(pfile);
    fclose(pfile);
    return 0;
}


// NO SE PORQUE NO COMPILA BIEN ESTE
// void floatCmpTest(){
//
//   // TEST RAPIDO floatCmp
//     float* pfa = malloc(4);
//     *pfa = 12.3;
//     float* pfb = malloc(4);
//     *pfb = 12.3;
//
//     int32_t res = floatCmp(pfa,pfb);
//     printf("dio 0? %d\n",res);
//
//
//     float* pfa1 = malloc(4);
//     *pfa1 = 15.1;
//     float* pfb1 = malloc(4);
//     *pfb1 = 12.3;
//
//     int32_t res1 = floatCmp(pfa1,pfb1);
//     printf("dio -1? %d\n",res1);
//
//
//     float* pfa2 = malloc(4);
//     *pfa2 = 12.3;
//     float* pfb2 = malloc(4);
//     *pfb2 = 11.3;
//
//     int32_t res2 = floatCmp(pfa2,pfb2);
//     printf("dio 1? %d\n",res2);
//
//     free(pfa);
//     free(pfb);
//     free(pfa1);
//     free(pfb1);
//     free(pfa2);
//     free(pfb2);

  // FIN TEST RAPIDO floatCmp

//}


void strCloneTest(){

    char holaMundo[] = {"hola mundo"};
    // char buenDia[] = {"buen dia"};
    // char aprobamos[] = {"Dale que aprobamos el TP 0$&/|"};

    //uint32_t resHolaMundo = strClone2(holaMundo);
    char* resHolaMundo = strClone(holaMundo);
    // char* resBuenDia   = strClone(buenDia);
    // char* resAprobamos = strClone(aprobamos);

    printf("hola mundo == %s\n", resHolaMundo );
    // printf("buen dia == %s\n", resBuenDia );
    // printf("Dale que aprobamos el TP 0$&/| == %s\n", resAprobamos );

    free(resHolaMundo);
    // free(resBuenDia);
    // free(resAprobamos);

}


void strLenTest(){
    char hola[] = {"hola"};
    char vacio[] = {};
    char largo[] = {"hola mundo"};

    uint32_t resHola = strLen(hola);
    uint32_t resVacio = strLen(vacio);
    uint32_t resLargo = strLen(largo);


    printf("hola: %d\n",resHola);
    printf("vacio: %d\n",resVacio);
    printf("hola mundo: %d\n",resLargo);
}


void strCmpTest(){
    char hola[] = {"hola"};
    char chau[] = {"chau"};
    char vacio[] = {};
    char holax[] = {"holax"};
    char aola[] = {"aola"};

    uint32_t res = strCmp(hola,chau);
    uint32_t resIgual = strCmp(hola,hola);
    uint32_t resVacio = strCmp(vacio,hola);
    uint32_t resVaciox2 = strCmp(vacio,vacio);
    uint32_t resHolax = strCmp(hola,holax);
    uint32_t resAola = strCmp(hola,aola);

    printf("-1?: %d\n",res);
    printf("0?: %d\n",resIgual);
    printf("1?: %d\n",resVacio);
    printf("0?: %d\n",resVaciox2);
    printf("1?: %d\n",resHolax);
    printf("-1?: %d\n",resAola);
}


void strPrintTest(){
    char interesante[] = {"Buenas noches America anda todo, dale que se aprueba ORGA 2 :P"};
    char vacio[] = {};

    FILE* fp_interesante = fopen("PruebaORGA2.txt", "w");
    FILE* fp_vacio = fopen("vacio.txt", "w");

    strPrint(interesante, fp_interesante );
    strPrint(vacio, fp_vacio );

    fclose(fp_interesante);
    fclose(fp_vacio);
}










/*

nasm -f elf64 main.asm -o main.o
gcc -no-pie -c -m64 funcion.c -o funcion.o
gcc -no-pie -o ejec -m64 main.o funcion.o

*/
























//
