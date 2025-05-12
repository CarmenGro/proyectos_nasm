section .data
    num1    db  '9'
    num2    db  '4'
    msg     db  'Resultado: ', 0
    len     equ $ - msg
    salto   db  10     ; Salto de línea

section .bss
    resultado resb 1

section .text
    global _start

_start:
    ; Mostrar "Resultado: "
    mov eax, 4          ; syscall write
    mov ebx, 1          ; fd stdout
    mov ecx, msg
    mov edx, len
    int 0x80

    ; Convertir ASCII a entero y restar (num1 - num2)
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    sub al, bl          ; AL = num1 - num2
    add al, '0'         ; Convertir a ASCII
    mov [resultado], al

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 1
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    mov ebx, 0
    int 0x80

