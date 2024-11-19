//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;
//
// namespace ContarVocalesConsonantes
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario una cadena de texto
//             Console.WriteLine("Ingrese una cadena de texto:");
//             string texto = Console.ReadLine();
//
//             // Inicializar contadores para vocales y consonantes
//             int contadorVocales = 0;
//             int contadorConsonantes = 0;
//
//             // Convertir el texto a minúsculas para simplificar la comparación
//             texto = texto.ToLower();
//
//             // Iterar sobre cada carácter de la cadena
//             foreach (char c in texto)
//             {
//                 // Verificar si el carácter es una letra
//                 if (char.IsLetter(c))
//                 {
//                     // Verificar si es una vocal
//                     if ("aeiou".Contains(c))
//                     {
//                         contadorVocales++;
//                     }
//                     else
//                     {
//                         // Si no es vocal, es consonante
//                         contadorConsonantes++;
//                     }
//                 }
//             }
//
//             // Mostrar los resultados
//             Console.WriteLine($"Número de vocales: {contadorVocales}");
//             Console.WriteLine($"Número de consonantes: {contadorConsonantes}");
//
//             // Pausar la consola
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }

//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
    input_prompt:   .asciz "Ingrese una cadena de texto: "
    vowel_msg:      .asciz "Número de vocales: "
    consonant_msg:  .asciz "Número de consonantes: "
    newline_str:    .asciz "\n"
    buffer:         .fill 256, 1, 0
    vowels:         .asciz "aeiouAEIOU"

.text
.global _start
_start:
    // Configuración estándar para entrada de programa
    mov x29, sp

    // Mostrar mensaje de entrada
    adr x0, input_prompt
    bl print_string

    // Leer cadena ingresada
    adr x0, buffer
    mov x1, #256
    bl read_input

    // Contar vocales y consonantes
    mov x19, #0          // Contador de vocales
    mov x20, #0          // Contador de consonantes
    adr x21, buffer      // Puntero al inicio del buffer

count_loop:
    ldrb w22, [x21]
    cbz w22, print_results
    
    mov w0, w22
    bl is_letter
    cbz x0, next_char

    // Convertir a minúscula
    mov w0, w22
    bl to_lowercase

    // Verificar si es vocal
    mov w0, w22
    adr x1, vowels
    bl is_vowel
    cbnz x0, increment_vowel
    
    add x20, x20, #1
    b next_char

increment_vowel:
    add x19, x19, #1

next_char:
    add x21, x21, #1
    b count_loop

print_results:
    // Imprimir número de vocales
    adr x0, vowel_msg
    bl print_string
    mov x0, x19
    bl print_number

    // Imprimir número de consonantes
    adr x0, consonant_msg
    bl print_string
    mov x0, x20
    bl print_number

    // Salir del programa
    mov x8, #93          // syscall exit
    mov x0, #0           // Código de salida 0
    svc #0

// Imprimir cadena
print_string:
    mov x8, #64
    mov x1, x0
    mov x2, #256
    mov x0, #1
    svc #0
    ret

// Leer entrada
read_input:
    mov x8, #63
    mov x1, x0
    mov x0, #0
    svc #0
    ret

// Verificar si es letra
is_letter:
    cmp w0, #'a'
    bge check_lowercase_range
    cmp w0, #'A'
    bge check_uppercase_range
    mov x0, #0
    ret

check_lowercase_range:
    cmp w0, #'z'
    bgt not_letter
    mov x0, #1
    ret

check_uppercase_range:
    cmp w0, #'Z'
    bgt not_letter
    mov x0, #1
    ret

not_letter:
    mov x0, #0
    ret

// Convertir a minúscula
to_lowercase:
    cmp w0, #'A'
    blt return_char
    cmp w0, #'Z'
    bgt return_char
    add w0, w0, #32
return_char:
    ret

// Verificar si es vocal
is_vowel:
    ldrb w2, [x1]
    cbz w2, not_found_vowel
    cmp w0, w2
    beq found_vowel
    add x1, x1, #1
    b is_vowel

found_vowel:
    mov x0, #1
    ret

not_found_vowel:
    mov x0, #0
    ret

// Imprimir número
print_number:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    sub sp, sp, #16

    mov x2, #0
    mov x3, #10
    cbz x0, zero_case

convert_loop:
    udiv x4, x0, x3
    msub x5, x4, x3, x0
    add x5, x5, #'0'
    strb w5, [x29, x2]
    add x2, x2, #1
    mov x0, x4
    cbnz x0, convert_loop

    mov x6, #0
    sub x7, x2, #1

reverse_loop:
    cmp x6, x7
    bge print_result
    ldrb w8, [x29, x6]
    ldrb w9, [x29, x7]
    strb w9, [x29, x6]
    strb w8, [x29, x7]
    add x6, x6, #1
    sub x7, x7, #1
    b reverse_loop

zero_case:
    mov x5, #'0'
    strb w5, [x29]
    mov x2, #1

print_result:
    mov x8, #64
    mov x0, #1
    mov x1, x29
    mov x2, x2
    svc #0

    mov x8, #64
    adr x1, newline_str
    mov x0, #1
    mov x2, #1
    svc #0

    add sp, sp, #16
    ldp x29, x30, [sp], #16
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o vc.o vc.s

// Vincular el archivo objeto
// ld -o vc vc.o

// Ejecutar el programa
//  ./vc

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q vc

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/i4wZXzb47TZksvkTGa9mhg7kY




//----------------------------------------------------------------------------------------------------------------------
