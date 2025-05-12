section .data
    num1    db 7
    num2    db 5

    mayor_msg       db 'El numero mayor es: ', 0
    iguales_msg     db 'Los numeros son iguales', 10, 0
    salto           db 10

section .bss
    resultado resb 2

section .text
    global _start

_start:
    mov al, [num1]
    mov bl, [num2]

    ; Comparar los dos números
    cmp al, bl
    je numeros_iguales
    ja num1_mayor
    jb num2_mayor

num1_mayor:
    ; Mostrar mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, mayor_msg
    mov edx, 21
    int 0x80

    ; Mostrar valor de num1
    mov al, [num1]
    add al, '0'
    mov [resultado], al

    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 1
    int 0x80

    jmp fin

num2_mayor:
    ; Mostrar mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, mayor_msg
    mov edx, 21
    int 0x80

    ; Mostrar valor de num2
    mov al, [num2]
    add al, '0'
    mov [resultado], al

    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 1
    int 0x80

    jmp fin

numeros_iguales:
    mov eax, 4
    mov ebx, 1
    mov ecx, iguales_msg
    mov edx, 25
    int 0x80

fin:
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
