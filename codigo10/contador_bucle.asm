section .data
    salto_linea db 10     ; salto de línea

section .bss
    caracter resb 1       ; reserva 1 byte para el carácter

section .text
    global _start

_start:
    mov ecx, 1            ; contador inicia en 1

bucle:
    cmp ecx, 10           ; ¿ecx == 10?
    jge fin               ; si es 10 o más, terminar

    ; convertir número a carácter ASCII
    mov eax, ecx
    add eax, '0'
    mov [caracter], al

    ; imprimir carácter
    mov eax, 4            ; syscall: write
    mov ebx, 1            ; fd: stdout
    mov ecx, caracter     ; buffer
    mov edx, 1            ; longitud
    int 0x80

    ; imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto_linea
    mov edx, 1
    int 0x80

    inc ecx               ; ecx++
    jmp bucle

fin:
    ; salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
