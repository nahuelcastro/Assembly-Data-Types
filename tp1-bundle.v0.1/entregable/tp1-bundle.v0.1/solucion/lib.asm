
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

;*** Float ***

floatCmp:
  ;stracframe
  push rbp
  mov rbp, rsp

  mov xmm3, [xmm2]
  cmppd [xmm1], xmm3
  je iguales            ; ver como carajo son los saltos
  jl menor
  mov db xmm0, -1
iguales:
  mov db xmm0, 0
menor:
  mov db xmm0, 1

  ;fin
  pop rbp
  ret


floatClone:
ret
floatDelete:
ret
floatPrint:
ret

;*** String ***

strClone:
ret
strLen:
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
