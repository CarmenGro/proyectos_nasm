section .data
    num1    db 8      ; dividendo
    num2    db 2      ; divisor
    msg     db 'Resultado: ', 0
    len     equ $ - msg
    salto   db 10

section .bss
    resultado resb 2  ; espacio para un dígito y null

section .text
    global _start

_start:
    ; Mostrar mensaje "Resultado: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80

    ; Dividir num1 entre num2
    xor edx, edx        ; limpiar EDX (necesario para la división)
    mov al, [num1]      ; cargar dividendo
    mov bl, [num2]      ; cargar divisor
    div bl              ; AL / BL → cociente en AL, residuo en AH (pero no lo usamos)

    ; Convertir resultado a ASCII
    add al, '0'
    mov [resultado], al

    ; Imprimir resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 1
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80
