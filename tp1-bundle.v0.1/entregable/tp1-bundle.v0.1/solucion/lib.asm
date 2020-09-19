
;dudas:
;como se usa la seccion . data, por el tema de que hay muchas funciones
;hay funciones que no las marca en la consigna, pero aca aparecen para hacerlas
;duda de las referencias
;preguntar que onda con las db y esas cosas
;en que tamaño se realizan las cuentas en assembler




section .data

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

extern malloc
extern free

;*** Float ***

floatCmp:
  ;rdi a
  ;rsi b
  ;eax resultado

  ;armo stracframe
  push rbp
  mov rbp, rsp

  movss xmm1, [rsi]
  comiss xmm1, [rdi]
  je .iguales            ; ver como carajo son los saltos
  jl .menor
  mov  eax, -1
  jmp fin
.iguales:
  mov eax, 0       ; VA DD?????????????? o algun otro, o no hace falta
  jmp .fin
.menor:
  mov  eax, 1
.fin:
  pop rbp
  ret


floatClone:
  ;armo stackframe
  push rbp
  mov rbp,rsp
  movss xmm0, [rdi]
  mov rdi, 4
  call malloc
  movss [rax], xmm0
  ;fin
  pop rbp
  ret


floatDelete:
  call free
  ret


floatPrint:
  ret

;*** String ***

strClone:
  ;char* a -> RDI
  ; armo stackframe
  push rbp
  mov rbp,rsp

  mov r13, rdi  ;guardo la posicion donde arranca mi parametro
  ; ya tengo en rdi donde arranca mi string para pasarselo a strLen
  call strLen  ; devuelve en rax el la cantidad de bytes que tengo que reservar
  mov rdi, rax ; lo paso a rdi para despues llamar a malloc
  call malloc ;tengo en rax el puntero que apunta al arranque de la memoria resevada
  mov r8, rax ; no quiero modificar rax asi ya lo tengo apuntando al arranque del string que deveuelvo
.ciclo:
  cmp byte [r13], 0 ; l ; NOOO FUNCA
  je .fin
  mov r9B, [r13] ;r13 apunta al arranque del string que recibo como parametro
  mov [rax], r9B
  inc r13
  inc rax;
  jmp .ciclo

.fin:
  mov rax, r8;
  pop  rbp
  ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





strLen:
; char* a -> RDI
; Stack frame (Armado)
  push rbp
  mov rbp, rsp

  xor rax, rax  ; limpio el eax
.ciclo:
  cmp byte [rdi], 0  ;veo si termina el string
  je .fin
  inc rax       ;
  inc rdi       ; avanzo la posicion en el string
  jne .ciclo
.fin:
  ; Stack Frame (Limpieza)
  pop rbp
  ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



strCmp:
  ;char* a -> RDI
  ;char* b -> RSI

  ;armo Stackframe
  push rbp
  mov rbp,rsp

.ciclo:
  mov r8b, [rdi]  ; copio el char al que apunte rdi de "a"
  mov r9b, [rsi]  ; copio el char al que apunte rsi de "b"
  cmp r8b, r9b    ; cmp los char
  jl .menor
  jg .mayor
  cmp r8b, 0      ; Si alguno es 0, entonces fin
  je .iguales
  inc rdi         ; inc rdi para que apunte al siguiente char
  inc rsi         ; inc rsi para que apunte al siguiente char
  jmp .ciclo
.menor:
  mov eax, 1
  jmp .fin
.mayor:
  mov eax, -1
  jmp .fin
.iguales:
  mov rax, 0
.fin:
  pop rbp
  ret




strDelete:
ret
strPrint:
ret

;*** Document ***

docClone:
ret
docDelete:
ret

;*** List ***

listAdd:
ret

;*** Tree ***

treeInsert:
ret
treePrint:
ret
