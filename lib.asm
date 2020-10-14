


section .data

string_format: db "%s", 0
string_NULL: db "NULL",0

tree_inicio_str: db "(", 0
tree_fin_str: db ")->", 0
string_format_inicio: db "%s", 0
string_NULL_T: db "NULL",0



section .text

global floatCmp
global floatClone
global floatDelete
global floatPrint

global strClone
global strLen
global strCmp
global strDelete
global strPrint

global docClone
global docDelete

global listAdd

global treeInsert
global treePrint

global treePrintAux


extern malloc
extern free
extern fprintf
extern getCloneFunction
extern getDeleteFunction
extern getCompareFunction
extern getPrintFunction
extern intClone
extern intDelete
extern listPrint
extern listNew

%define NULL 0


;*** Float ***

floatCmp:
  ;rdi a
  ;rsi b
  ;eax resultado
  push rbp
  mov rbp, rsp

  movss xmm1, [rdi]
  comiss xmm1, [rsi]
  je .iguales
  jb .menor
  mov  eax, -1
  jmp .fin
.iguales:
  mov eax, 0
  jmp .fin
.menor:
  mov  eax, 1
.fin:
  pop rbp
  ret


floatClone:
  push rbp
  mov rbp,rsp

  movss xmm0, [rdi]
  mov edi, 4
  call malloc
  movss [rax], xmm0

  pop rbp
  ret


floatDelete:
  call free
  ret


;*** String ***

strClone:
  ;char* a -> RDI
  push rbp
  mov rbp,rsp
  push r12
  push r13
  push r14
  push r15

  mov r13, rdi

  call strLen       ;en eax bytes a reservar
  mov edi, eax
  inc edi           ;uno mas para el 0 final
  call malloc
  mov r12, rax      ;r12 = puntero a memoria solicitada, para returnear

.ciclo:
  cmp byte [r13], 0
  je .fin
  mov byte r14b, [r13]    ;r13 puntero a string de entrada
  mov byte [rax], r14b
  inc r13
  inc rax
  jmp .ciclo

.fin:

  mov byte [rax], 0       ;le agregamos el 0 final
  mov rax, r12

  pop r15
  pop r14
  pop r13
  pop r12
  pop rbp
  ret





strLen:
; char* a -> RDI
  push rbp
  mov rbp, rsp

  xor rax, rax        ;rax = 0
.ciclo:
  cmp byte [rdi], 0   ;veo si termina el string
  je .fin
  inc rax
  inc rdi             ;avanzo la posicion en el string
  jne .ciclo
.fin:
  pop rbp
  ret




strCmp:
  ;char* a -> RDI
  ;char* b -> RSI

  push rbp
  mov rbp,rsp
  push r12
  push r13

.ciclo:
  xor r12, r12
  xor r13, r13
  mov r12b, [rdi]         ; copio el char al que apunte rdi de "a"
  mov r13b, [rsi]         ; copio el char al que apunte rsi de "b"
  cmp byte r12b, r13b
  jl .menor
  jg .mayor
  cmp byte r12b, 0        ; Si alguno es 0, entonces fin
  je .iguales
  inc rdi                 ; inc rdi para que apunte al siguiente char
  inc rsi                 ; inc rsi para que apunte al siguiente char
  jmp .ciclo
.menor:
  mov eax, 1
  jmp .fin
.mayor:
  mov eax, -1
  jmp .fin
.iguales:
  mov eax, 0
.fin:

  pop r13
  pop r12
  pop rbp
  ret





strDelete:
  call free
  ret




strPrint:
  ; char* a -> RDI
  ; FILE* pFile -> RSI

  push rbp
  mov rbp, rsp
  push r12
  push r13
  mov r12,rdi             ;R12 aux con el char* a
  mov rdi,rsi
  mov r13, rsi
  mov rsi, string_format
  cmp byte [r12], 0
  je .NULL
  mov rdx,r12
  jmp .fprintf
.NULL:
  mov rdx, string_NULL
.fprintf:
  ; fprintf(fp, "%s", r8);
  ; rdi: FILE, rsi: string_format, rdx: char* a (R8)
  call fprintf
  mov rdi,r13
.fin:
  pop r13
  pop r12
  pop rbp
  ret


;*** Document ***

%define off_type 0
%define off_count 0
%define off_data_ptr 8
%define off_doc_values 8
%define off_doc_node 16

docClone:
  ;document_t* a -> RDI

  push rbp
  mov rbp,rsp
  sub rsp, 8
  push rbx
  push r12
  push r13
  push r14
  push r15

  mov r13, rdi
  mov r13, [r13 + off_doc_values]   ;PUNTERO AL VALUE ORIGINAL

  mov ecx, [rdi + off_count]
  mov [rbp - 8], ecx

  ;armar el document_t nuevo

  mov edi, 16                   ;tamaño del bloque
  call malloc
  mov r12, rax                  ;PUNTERO A NUEVO DOCUMENTO -> R12

  ;salvamos caso vacio

  cmp dword [r13 + off_count], 0
  je .casoVacio

  ; creamos arreglo

  mov  eax , [rbp - 8]
  mov r8d, 16               ;el tamaño de cada elemento del vector
  mul r8d                   ;rax = r8 * rax
  mov edi, eax              ;paso el document_size * 16 a rdi para el malloc
  call malloc
  mov r14,rax               ;PUNTERO AL NUEVO VECTOR DE DOCUMENTOS -> R14


  ;volcado de data a document

  mov ecx, [rbp - 8]
  mov [r12 + off_count], ecx
  mov [r12 + off_doc_values], r14

  ; volcado de data a los document elem:

  xor r15, r15
  xor rbx, rbx
.ciclo:
  cmp r15d , [rbp - 8]
  je .fin
  mov r9d, [r13 + rbx + off_type]
  mov [r14  + rbx + off_type], r9d
  mov edi, r9d
  call getCloneFunction
  mov rdi, [r13 + rbx + off_data_ptr]
  call rax
  mov [r14 + rbx + off_data_ptr], rax
  add rbx, 16
  inc r15d
  jmp .ciclo


.casoVacio:

mov edi, 16
call malloc
mov r14,rax
mov dword [r12 + off_count], 0
mov [r12 + off_doc_values], r14
mov dword [r14 + off_type], 0
mov qword [r14 + off_doc_values], NULL

.fin:

  mov rax, r12
  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
  add rsp, 8
  pop rbp
  ret


docDelete:
; document_t* a -> RDI

  push rbp
  mov rbp,rsp
  push rbx
  push r12
  push r13
  push r15

  mov r12, rdi                      ;me guardo el puntero al document en r12
  mov r13, [rdi + off_doc_values]   ;puntero a values
  mov ebx, [rdi + off_count]

  xor r15, r15

.ciclo:

  cmp r15d, ebx
  je .doc_t_delete

  ; borro el contenido (value)
  mov edi, [r13 + off_type]
  call getDeleteFunction
  mov rdi, [r13 + off_data_ptr]
  call rax  ; call al delete correspondiente

  ; avanzo
  inc r15d ;
  add r13, off_doc_node  ;r13 = r13 + 16
  jmp .ciclo

.doc_t_delete:

  ;delete doc values
  mov rdi, [r12 + off_doc_values]
  call free

  ;delete de la estructura principal
  mov rdi, r12
  call free

.fin:

  pop r15
  pop r13
  pop r12
  pop rbx
  pop rbp
  ret




;*** List ***


%define off_list_type 0
%define off_list_size 4
%define off_list_first_ptr 8
%define off_list_last_ptr 16
%define off_nodeList_data 0
%define off_nodeList_next 8
%define off_nodeList_prev 16


 listAdd:

;list_t* l -> rdi
;void * data -> rsi


  push rbp
  mov rbp,rsp
  sub rsp, 8
  push rbx
  push r12
  push r13
  push r14
  push r15

;filtramos caso vacio

; preparamos todo:
  mov r12, rdi ; guardamos el puntero a centinela en otro lugar para no perderlo
  mov r14, rsi ; sacamos la data de rsi

; new Node:
  mov edi, 24
  call malloc
  mov rbx, rax ; guardamos en rbx la memoria solicitada


; filtramos caso vacio

  cmp dword [r12 + off_list_size], NULL
  je .casoVacio

  mov r15, [r12 + off_list_first_ptr] ;r15 -> puntero a first de la lista

.ciclo:

  ;comparar
  mov edi, [r12 + off_list_type]
  call getCompareFunction

  mov rdi, [r15 + off_nodeList_data]

  mov rsi, r14    ; el valor que recibimos por paramtro
  call rax        ; en eax nos quedo 1, 0 o -1

  cmp eax, 0
  jle .agregarIzq

  cmp qword [r15 + off_nodeList_next], NULL ; si es el ultimo elemento va a un caso especial
  je .casoUltimo

  mov r15, [r15 + off_nodeList_next]; avanzar
  jmp .ciclo

.agregarIzq:
  cmp qword [r15 + off_nodeList_prev], NULL
  je .esPrimero

  mov r13, [r15 + off_nodeList_prev]  ; que r13 sea el nodo anterior
  mov [r15 + off_nodeList_prev], rbx  ; que el r15->prev apunte al nuevo(rbx)
  mov [r13 + off_nodeList_next], rbx  ; que el r13->next apunte al nuevo(rbx)
  mov [rbx + off_nodeList_prev], r13  ; que el rbx->prev apunte a r13
  mov [rbx + off_nodeList_next], r15  ; que el rbx->next apunte a r15

  jmp .fin

.esPrimero:
  ;r12 -> centinela
  mov qword [rbx + off_nodeList_prev], NULL
  mov [rbx + off_nodeList_next], r15
  mov [r12 + off_list_first_ptr], rbx
  mov [r15 + off_nodeList_prev], rbx

  jmp .fin


.casoUltimo:
  mov [r15 + off_nodeList_next], rbx
  mov [rbx + off_nodeList_prev], r15
  mov qword [rbx + off_nodeList_next], NULL
  mov [r12 + off_list_last_ptr], rbx

  jmp .fin

.casoVacio:

  mov [r12 + off_list_last_ptr] , rbx
  mov [r12 + off_list_first_ptr], rbx
  mov qword [rbx + off_nodeList_next] , NULL
  mov qword[rbx + off_nodeList_prev] , NULL




.fin:


  mov [rbx + off_nodeList_data] , r14
  inc dword [r12 + off_list_size]       ;incrementamos el size de la lista

  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
  add rsp, 8
  pop rbp
  ret


;*** Tree ***


%define off_tree_first_ptr 0
%define off_tree_size 8
%define off_tree_type_key 12
%define off_tree_duplicates 16
%define off_tree_type_data 20

%define off_nodeTree_key 0
%define off_nodeTree_values 8
%define off_nodeTree_left 16
%define off_nodeTree_right 24



treeInsert:
;tree_t* -> RDI
;void* key -> RSI
;void* data -> RDX

  push rbp
  mov rbp,rsp
  sub rsp,24
  push rbx
  push r12
  push r13
  push r14
  push r15

  mov r12, rdi            ; R12        -> PUNTERO A CENTINELA TREE
  mov [rbp - 8] , rsi     ; [rbp - 8]  -> PUNTERO A KEY
  mov [rbp - 16], rdx     ; [rbp - 16] -> PUNTERO A DATA (significado)

  ;ver si es primer elemento

  mov dword [rbp - 24], 0               ;flag Agregar Primero
  cmp dword [r12 + off_tree_size], 0
  je .preAgregado

  mov r13, [r12 + off_tree_first_ptr]   ;R13 -> PUNTERO A PRIMER NODO

.ciclo:

;compara
  mov edi, [r12 + off_tree_type_key]
  call getCompareFunction

  mov rdi, [r13 + off_nodeTree_key] ; el elemento del tree
  mov rsi, [rbp - 8]                ; el valor que recibimos por parametro

  call rax                          ; 1 si el parametro (rsi) es mas grande

  cmp eax, 0
  je .igual
  jl .masChico


.masGrande:

  cmp qword [r13 + off_nodeTree_right], NULL
  mov dword [rbp - 24], 1                         ;flag Agregar Derecha
  je .preAgregado

  mov r13, [r13 + off_nodeTree_right]
  jmp .ciclo

.masChico:

  cmp qword [r13 + off_nodeTree_left], NULL
  mov dword [rbp - 24], -1                        ;flag Agregar Izquierda
  je .preAgregado

  mov r13, [r13 + off_nodeTree_left]
  jmp .ciclo


.igual: ;en este caso hay que ver si esta permitido repetidos.


  cmp dword [r12 + off_tree_duplicates], 0
  je .set0
  mov edi,[r12 + off_tree_type_data]
  call getCloneFunction
  mov rdi, [rbp - 16]                             ;puntero a data
  call rax

  ; setear parametro de listAdd

  mov rdi, [r13 + off_nodeTree_values]
  mov rsi, rax
  call listAdd
  jmp .fin

.set0:
  mov eax, 0        ;return 0
  jmp .fin


.preAgregado:

  inc dword [r12 + off_tree_size];


  mov edi, 32
  call malloc
  mov rbx, rax                        ;RBX -> PUNTERO A MEMORIA SOLICITADA

  ;clonamos la key

  mov edi,[r12 + off_tree_type_key]
  call getCloneFunction
  mov rdi, [rbp - 8]                      ;puntero a data
  call rax                                ;clonamos key
  mov r14, rax                            ;R14 -> KEY CLONADA

  ;clonamos la data

  mov edi,[r12 + off_tree_type_data]
  call getCloneFunction
  mov rdi, [rbp - 16]                     ;puntero a data
  call rax                                ;clonamos data
  mov r15, rax                            ;R15 -> DATA CLONADA

  ;insertamos datos clonados

  mov [rbx + off_nodeTree_key], r14       ;insertamos key
  mov edi , [r12 + off_tree_type_data]    ;pasamos tipo de list
  call listNew

  ; setear parametro de listAdd

  mov [rbx + off_nodeTree_values], rax    ;guardamos puntero a lista en nodo
  mov rdi, [rbx + off_nodeTree_values]
  mov rsi, r15
  call listAdd

  ;seteamos ptr izq y der en 0

  mov qword [rbx + off_nodeTree_left], NULL
  mov qword [rbx + off_nodeTree_right], NULL

  ;vemos a donde seguimos

  cmp dword [rbp - 24], 0
  mov eax, 1                                ;return 1;
  je .agregarPrimero
  jl .agregarIzq


.agregarDer:

  mov [r13 + off_nodeTree_right], rbx
  jmp .fin

.agregarIzq:

  mov [r13 + off_nodeTree_left], rbx
  jmp .fin

.agregarPrimero:

  mov [r12 + off_tree_first_ptr], rbx


.fin:


  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
  add rsp, 24
  pop rbp
  ret



treePrint:
;tree_t* -> RDI
;FILE *  -> RSI

  push rbp
  mov rbp,rsp
  sub rsp, 8
  push r12
  push r13
  push r14

  mov r12, rdi              ;R12 -> PUNTERO A CENTINELA
  mov r13, rsi              ;R13 -> *FILE

  cmp dword [r12 + off_tree_size], 0    ;caso vacio
  je .fin

  mov r14, [r12 + off_tree_first_ptr]   ;*actual

  mov rdi, r14
  mov rsi, r13
  mov edx, [r12 + off_tree_type_key]
  call treePrintAux

.fin:

  pop r14
  pop r13
  pop r12
  add rsp, 8
  pop rbp
  ret


treePrintAux:
;treeNode_t* ->RDI
;FILE -> RSI
;type_t -> RDX

  push rbp
  mov rbp,rsp
  push r12
  push r13
  push r14
  push r15

  mov r12, rdi          ;R12 -> *actual
  mov r13, rsi          ;R13 -> *FILE
  mov r14d, edx         ;R15 -> type_t

  cmp qword [r12 + off_nodeTree_left], NULL
  jne .recuIzq
  jmp .printNodoActual


.recuIzq:
    mov rdi, [r12 + off_nodeTree_left]
    mov rsi, r13
    mov edx, r14d
    call treePrintAux

.printNodoActual:

  mov rdi, r13
  mov rsi, tree_inicio_str
  call fprintf                      ;imprime primer parentesis

  mov edi, r14d
  call getPrintFunction             ;ve que tipo hay que imprimir
  mov rdi, [r12 + off_nodeTree_key]
  mov rsi, r13
  call rax                          ;imprime valor key

  mov rdi, r13
  mov rsi, tree_fin_str
  call fprintf                      ;imprime segundo parentesis

  mov rdi, [r12 + off_nodeTree_values]
  mov rsi, r13
  call listPrint                    ;imprime lista

  cmp qword [r12 + off_nodeTree_right], NULL
  je .fin

.recuDer:

    mov rdi, [r12 + off_nodeTree_right]
    mov rsi, r13
    mov edx, r14d
    call treePrintAux


.fin:

  pop r15
  pop r14
  pop r13
  pop r12
  pop rbp
  ret
