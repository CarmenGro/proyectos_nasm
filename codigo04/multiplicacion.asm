section .data
    num1    db  '3'         ; primer número en ASCII
    num2    db  '4'         ; segundo número en ASCII
    msg     db  'Resultado: ', 0
    len     equ $ - msg
    salto   db  10          ; salto de línea

section .bss
    resultado resb 3        ; espacio para hasta 3 caracteres (por si es 2 dígitos + nulo)

section .text
    global _start

_start:
    ; Mostrar mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80

    ; Convertir num1 y num2 de ASCII a número
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'

    ; Multiplicación: AL = AL * BL
    mul bl              ; AX = AL * BL

    ; Convertir resultado a decimal y ASCII
    ; AX puede tener hasta 2 dígitos (0-81)
    mov bx, 0
    mov bl, 10
    xor cx, cx

    ; AX = resultado, dividir entre 10
    mov dx, 0
    div bl              ; AL = AX / 10, AH = AX % 10
    add al, '0'         ; decena a ASCII
    mov [resultado], al
    add ah, '0'         ; unidad a ASCII
    mov [resultado+1], ah

    ; Agregar salto de línea opcional (puede omitirse)
    ; mov byte [resultado+2], 10

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 2
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80
