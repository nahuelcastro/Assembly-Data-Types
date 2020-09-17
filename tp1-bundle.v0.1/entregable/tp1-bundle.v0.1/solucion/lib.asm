
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
ret

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


strCmp:
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
