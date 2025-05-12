section .data
    msg db "Resultado: ", 0
    newline db 10, 0

section .bss
    buffer resb 10

section .text
    global _start

_start:
    ; suma = 5 + 3
    mov eax, 5
    add eax, 3        ; eax = 8

    ; convertir eax a cadena decimal en buffer
    mov ecx, buffer + 10 ; fin del buffer
    mov ebx, 10

conv_loop:
    xor edx, edx
    div ebx
    dec ecx
    add dl, '0'
    mov [ecx], dl
    test eax, eax
    jnz conv_loop

    ; imprimir
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 10
    int 0x80

    ; imprimir el número (cadena convertida)
    mov eax, 4
    mov ebx, 1
    mov edx, buffer + 10
    sub edx, ecx       ; longitud = fin - inicio
    mov esi, ecx       ; guardar inicio de número
    mov ecx, esi
    int 0x80

    ; imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; salir
    mov eax, 1
    xor ebx, ebx
    int 0x80

