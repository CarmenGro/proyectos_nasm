section .bss
    buffer resb 10       ; Reservamos espacio para la entrada (hasta 10 caracteres)

section .data
    mensaje db "Ingresa un numero: ", 0
    len_mensaje equ $ - mensaje

section .text
    global _start

_start:
    ; Mostrar mensaje
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, mensaje
    mov edx, len_mensaje
    int 0x80

    ; Leer entrada del usuario
    mov eax, 3          ; syscall read
    mov ebx, 0          ; stdin
    mov ecx, buffer
    mov edx, 10         ; leer hasta 10 caracteres
    int 0x80

    ; Mostrar lo que escribió el usuario
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, buffer
    mov edx, 10         ; mostrar 10 bytes (puede mostrar caracteres extras si no se limpia)
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80
