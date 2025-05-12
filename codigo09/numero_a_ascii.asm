section .data
    mensaje db "Caracter ASCII correspondiente: ", 0
    len_mensaje equ $ - mensaje

section .bss
    ascii_char resb 1    ; Aquí guardaremos el carácter ASCII

section .text
    global _start

_start:
    ; Supongamos que el número 65 (A) está en AL
    mov al, 65
    mov [ascii_char], al     ; Guardamos el valor como carácter

    ; Mostrar el mensaje
    mov eax, 4               ; syscall write
    mov ebx, 1               ; stdout
    mov ecx, mensaje
    mov edx, len_mensaje
    int 0x80

    ; Mostrar el carácter
    mov eax, 4
    mov ebx, 1
    mov ecx, ascii_char
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80
