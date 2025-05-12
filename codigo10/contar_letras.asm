section .data
    cadena db 'Hola Mundo', 0
    salto_linea db 10

section .bss
    contador resb 3  ; espacio para hasta 3 dígitos

section .text
    global _start

_start:
    mov esi, cadena
    xor ecx, ecx      ; contador

contar:
    mov al, [esi]
    cmp al, 0
    je convertir

    inc ecx
    inc esi
    jmp contar

convertir:
    ; convertir ecx (número de letras) a ASCII decimal
    ; soporta hasta 3 dígitos (máx 255)
    mov eax, ecx
    mov edi, contador + 2  ; apuntar al final

    mov byte [edi], 0      ; terminador null para seguridad
    dec edi

convertir_bucle:
    xor edx, edx
    mov ebx, 10
    div ebx               ; divide eax entre 10
    add dl, '0'           ; convierte el residuo en dígito ASCII
    mov [edi], dl
    dec edi
    cmp eax, 0
    jne convertir_bucle

    inc edi               ; apunta al primer dígito

imprimir:
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, contador + 3
    sub edx, edi
    int 0x80

    ; salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto_linea
    mov edx, 1
    int 0x80

salir:
    mov eax, 1
    xor ebx, ebx
    int 0x80
