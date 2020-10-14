#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include <stdbool.h>

#include "lib.h"

void test_document(FILE *dfile);

void test_list(FILE *dfile);

void test_tree(FILE *dfile);

int main (void){
    FILE *dfile = fopen("salida.caso.propios.txt","w");
    test_document(dfile); fprintf(dfile,"\n");
    test_list(dfile); fprintf(dfile,"\n");
    test_tree(dfile);
    fclose(dfile);
    return 0;
}


void test_document(FILE *dfile){
    fprintf(dfile,"===== Document\n");
    int varInt0 = 76;
    int varInt1 = 33;
    float varFloat0 = 6.63f;
    float varFloat1 = 2.17f;
    document_t* d = docNew(6,TypeInt,&(varInt0),TypeInt,&(varInt1),TypeString,"dale",TypeString,"que aprobamos",TypeFloat,&(varFloat0),TypeFloat,&(varFloat1));
    document_t* d_clone = docClone(d);
    docPrint(d, dfile); fprintf(dfile,"\n");
    docPrint(d_clone, dfile); fprintf(dfile,"\n");
    docDelete(d);
    docDelete(d_clone);
}



char* data[10] = {"-adivin","a la frase:","pablito","clavo","un","clavito","que", "clavito","clavo","pablito"};

void test_list(FILE *dfile){
  fprintf(dfile,"===== List\n");
  list_t* listString = listNew(TypeString);
  float varFloat0 = 0.53f; float varFloat1 = 2.82f;
  float varFloat2 = 10.33f; float varFloat3 = 6.80f;
  float varFloat4 = 9.99f;
  list_t* listFloat = listNew(TypeFloat);
  float flt[5]  = {varFloat0,varFloat1,varFloat2,varFloat3,varFloat4};
  for(int i=0; i<10;i++){
      listAdd(listString,strClone(data[i]));
  }
  for(int i=0; i<5;i++){
      listAdd(listFloat,floatClone(&flt[i]));
  }
  list_t* listString_clone = listClone(listString);
  list_t* listFloat_clone = listClone(listFloat);

  listPrint(listString_clone, dfile);fprintf(dfile,"\n" );
  listPrint(listFloat_clone, dfile);

  listDelete(listString);
  listDelete(listFloat);
  listDelete(listString_clone);
  listDelete(listFloat_clone);
}


void test_tree(FILE *dfile){
  fprintf(dfile,"\n");
  fprintf(dfile,"===== Tree\n");
  tree_t* tree;
  tree = treeNew(TypeInt, TypeString, 1);

  int key0 = 24;
  char* data0 = "papanatas";
  int key1 = 34;
  char* data1 = "rima";
  int key2 = 24;
  char* data2 = "buscabullas";
  int key3 = 11;
  char* data3 = "musica";
  int key4 = 31;
  char* data4 = "pikachu";
  int key5 = 11;
  char* data5 = "Bulbasaur";
  int key6 = -2;
  char* data6 = "Charmander";

  treeInsert(tree, &key0, data0);
  treeInsert(tree, &key1, data1);
  treeInsert(tree, &key2, data2);
  treeInsert(tree, &key3, data3);
  treeInsert(tree, &key4, data4);
  treeInsert(tree, &key5, data5);
  treeInsert(tree, &key6, data6);

  tree_t* tree2;
  tree2 = treeNew(TypeInt, TypeString, 1);

  treeInsert(tree2, &key6, data6);
  treeInsert(tree2, &key5, data5);
  treeInsert(tree2, &key4, data4);
  treeInsert(tree2, &key3, data3);
  treeInsert(tree2, &key2, data2);
  treeInsert(tree2, &key1, data1);
  treeInsert(tree2, &key0, data0);

  treePrint(tree, dfile); fprintf(dfile,"\n");
  treePrint(tree2, dfile); fprintf(dfile,"\n");
  treeDelete(tree);
  treeDelete(tree2);
}




























//
