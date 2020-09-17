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
extern uint32_t strLen(char* a)

void floatCmpTest();
void strLen();

int main (void){

    // Team
    floatCmpTest();

    strLen();


    // catedra
    FILE *pfile = fopen("salida.caso.propios.txt","w");
    test_list(pfile);
    test_tree(pfile);
    test_document(pfile);
    fclose(pfile);
    return 0;
}

void floatCmpTest(){

  // TEST RAPIDO floatCmp
    float* pfa = malloc(4);
    *pfa = 12.3;
    float* pfb = malloc(4);
    *pfb = 12.3;

    int32_t res = floatCmp(pfa,pfb);
    printf("dio 0? %d\n",res);


    float* pfa1 = malloc(4);
    *pfa1 = 15.1;
    float* pfb1 = malloc(4);
    *pfb1 = 12.3;

    int32_t res1 = floatCmp(pfa1,pfb1);
    printf("dio -1? %d\n",res1);


    float* pfa2 = malloc(4);
    *pfa2 = 12.3;
    float* pfb2 = malloc(4);
    *pfb2 = 11.3;

    int32_t res2 = floatCmp(pfa2,pfb2);
    printf("dio 1? %d\n",res2);

    free(pfa);
    free(pfb);
    free(pfa1);
    free(pfb1);
    free(pfa2);
    free(pfb2);

  // FIN TEST RAPIDO floatCmp

}

void strLen(){
    char hola[4] = {'h','o','l','a'};
    char vacio[0] = {};
    char largo[10] = {'h','o','l','a',' ','m','u','n','d','o' }

    uint32_t resHola = strLen(hola);
    uint32_t resVacio = strLen(vacio);
    uint32_t resLargo = strLen(largo);

    printf("hola: %d\n",resHola);
    printf("vacio: %d\n",resVacio);
    printf("hola mundo: %d\n",resLargo);

}


/*

nasm -f elf64 main.asm -o main.o
gcc -no-pie -c -m64 funcion.c -o funcion.o
gcc -no-pie -o ejec -m64 main.o funcion.o

*/
























//
