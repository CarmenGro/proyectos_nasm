section .bss
    buffer resb 10       ; Espacio para leer hasta 10 caracteres
    len resb 1           ; Para guardar la longitud real leída

section .data
    mensaje db "Ingresa un numero: ", 0
    len_mensaje equ $ - mensaje
    mensaje_salida db "Numero ingresado: ", 0
    len_salida equ $ - mensaje_salida

section .text
    global _start

_start:
    ; Mostrar mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, len_mensaje
    int 0x80

    ; Leer entrada
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80
    mov [len], eax      ; Guardar longitud leída en len

    ; Reemplazar salto de línea (si lo hay) con cero
    mov ecx, buffer
    add ecx, [len]
    dec ecx
    mov al, [ecx]
    cmp al, 10
    jne mostrar

    mov byte [ecx], 0   ; reemplazar '\n' con null

mostrar:
    ; Mostrar mensaje de salida
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje_salida
    mov edx, len_salida
    int 0x80

    ; Mostrar número ingresado
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, [len]
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80

