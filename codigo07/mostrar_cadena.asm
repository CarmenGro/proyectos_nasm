section .data
    cadena      db "Hola", 0    ; Cadena terminada en 0 (null)
    salto       db 10           ; Salto de línea

section .text
    global _start

_start:
    mov esi, cadena            ; Apuntamos al inicio de la cadena

siguiente_caracter:
    mov al, [esi]              ; Cargar carácter
    cmp al, 0                  ; ¿Fin de cadena?
    je fin

    ; Mostrar carácter
    mov eax, 4                 ; sys_write
    mov ebx, 1                 ; stdout
    mov ecx, esi               ; dirección del carácter
    mov edx, 1                 ; longitud: 1 byte
    int 0x80

    inc esi                    ; Siguiente carácter
    jmp siguiente_caracter

fin:
    ; Salto de línea al final
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
