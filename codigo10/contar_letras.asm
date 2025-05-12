section .data
cadena db 'Hola Mundo', 0
mensaje1 db 'La cadena tiene ', 0
mensaje2 db ' letras.', 10, 0 ; salto de línea al final

section .bss
contador resb 3 ; para el número en ASCII

section .text
global _start

_start:
; contar letras
mov esi, cadena
xor ecx, ecx

contar:
mov al, [esi]
cmp al, 0
je convertir
inc ecx
inc esi
jmp contar

convertir:
; convierte ECX a ASCII decimal (máx 3 dígitos)
mov eax, ecx
mov edi, contador + 2
mov byte [edi], 0
dec edi

convertir_bucle:
xor edx, edx
mov ebx, 10
div ebx
add dl, '0'
mov [edi], dl
dec edi
cmp eax, 0
jne convertir_bucle
inc edi

imprimir:
; imprimir mensaje1
mov eax, 4
mov ebx, 1
mov ecx, mensaje1
mov edx, 17 ; longitud de 'La cadena tiene '
int 0x80
; imprimir número
mov eax, 4
mov ebx, 1
mov ecx, edi
mov edx, contador + 3
sub edx, edi
int 0x80

; imprimir mensaje2
mov eax, 4
mov ebx, 1
mov ecx, mensaje2
mov edx, 9               ; longitud de ' letras.' y salto
int 0x80
salir:
mov eax, 1
xor ebx, ebx
int 0x80
