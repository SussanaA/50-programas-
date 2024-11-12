// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código de referencia en C#

// using System;

// class Program
// {
//     static void Main(string[] args)
//     {
//         // Solicitar al usuario que ingrese una cadena
//         Console.Write("Ingrese una cadena de texto: ");
//         string input = Console.ReadLine();

//         // Llamar a la función para verificar si es un palíndromo
//         if (EsPalindromo(input))
//         {
//             Console.WriteLine("La cadena es un palíndromo.");
//         }
//         else
//         {
//             Console.WriteLine("La cadena no es un palíndromo.");
//         }
//     }

//     // Función que verifica si una cadena es un palíndromo
//     static bool EsPalindromo(string str)
//     {
//         // Eliminar espacios y convertir todo a minúsculas para la comparación
//         str = str.Replace(" ", "").ToLower();

//         // Revertir la cadena
//         char[] array = str.ToCharArray();
//         Array.Reverse(array);
//         string reversedStr = new string(array);

//         // Comparar la cadena original con la cadena revertida
//         return str == reversedStr;
//     }
// }

//-----------------------------------------------------------------------------------------------------------------

// Código en ARM64 Assembly

.global _start

.section .data
    prompt:     .asciz "Ingrese una cadena de texto: "
    es_pal:     .asciz "La cadena es un palindromo.\n"
    no_pal:     .asciz "La cadena no es un palindromo.\n"

.section .bss
    buffer:         .skip 100    // Buffer para almacenar la entrada
    buffer_rev:     .skip 100    // Buffer para almacenar la cadena invertida
    length:         .skip 8      // Para almacenar la longitud de la cadena

.section .text
_start:
    // Imprimir prompt
    mov x0, 1              // stdout
    ldr x1, =prompt       // mensaje
    mov x2, 26            // longitud del mensaje
    mov x8, 64            // syscall write
    svc 0

    // Leer entrada del usuario
    mov x0, 0              // stdin
    ldr x1, =buffer       // buffer donde guardar
    mov x2, 100           // máximo de caracteres a leer
    mov x8, 63            // syscall read
    svc 0
    
    // Guardar longitud de la cadena (sin contar newline)
    sub x0, x0, #1        // Restar 1 para quitar el newline
    ldr x1, =length
    str x0, [x1]          // Guardar longitud

    // Convertir a minúsculas y copiar a buffer_rev
    ldr x0, =buffer       // Dirección de la cadena original
    ldr x1, =buffer_rev   // Dirección donde guardar la copia
    ldr x2, =length       // Dirección de la longitud
    ldr x2, [x2]          // Valor de la longitud
    bl to_lower           // Llamar función para convertir a minúsculas

    // Invertir la cadena en buffer_rev
    ldr x0, =buffer_rev   // Dirección de la cadena a invertir
    ldr x1, =length       // Dirección de la longitud
    ldr x1, [x1]          // Valor de la longitud
    bl reverse_string     // Llamar función para invertir

    // Comparar las cadenas
    ldr x0, =buffer       // Primera cadena
    ldr x1, =buffer_rev   // Segunda cadena (invertida)
    ldr x2, =length       // Longitud
    ldr x2, [x2]          // Valor de la longitud
    bl compare_strings    // Llamar función de comparación

    // x0 contiene el resultado (0 si son iguales, 1 si son diferentes)
    cmp x0, #0
    beq es_palindromo

no_es_palindromo:
    // Imprimir mensaje "no es palíndromo"
    mov x0, 1
    ldr x1, =no_pal
    mov x2, 29
    mov x8, 64
    svc 0
    b exit

es_palindromo:
    // Imprimir mensaje "es palíndromo"
    mov x0, 1
    ldr x1, =es_pal
    mov x2, 26
    mov x8, 64
    svc 0

exit:
    // Terminar programa
    mov x0, 0
    mov x8, 93
    svc 0

// Función para convertir a minúsculas
to_lower:
    // x0 = dirección origen
    // x1 = dirección destino
    // x2 = longitud
    mov x4, #0          // índice
to_lower_loop:
    cmp x4, x2
    beq to_lower_done
    ldrb w3, [x0, x4]   // Cargar carácter
    
    // Verificar si es mayúscula (A-Z)
    cmp w3, #'A'
    blt store_char
    cmp w3, #'Z'
    bgt store_char
    
    // Convertir a minúscula
    add w3, w3, #32
    
store_char:
    strb w3, [x1, x4]   // Guardar carácter
    add x4, x4, #1      // Incrementar índice
    b to_lower_loop
    
to_lower_done:
    ret

// Función para invertir cadena
reverse_string:
    // x0 = dirección de la cadena
    // x1 = longitud
    sub x1, x1, #1      // Ajustar longitud para índice basado en 0
    mov x2, #0          // índice inicio
reverse_loop:
    cmp x2, x1
    bge reverse_done
    
    // Intercambiar caracteres
    ldrb w3, [x0, x2]   // Cargar carácter del inicio
    ldrb w4, [x0, x1]   // Cargar carácter del final
    
    strb w4, [x0, x2]   // Guardar carácter del final al inicio
    strb w3, [x0, x1]   // Guardar carácter del inicio al final
    
    add x2, x2, #1      // Incrementar índice inicio
    sub x1, x1, #1      // Decrementar índice final
    b reverse_loop
    
reverse_done:
    ret

// Función para comparar cadenas
compare_strings:
    // x0 = primera cadena
    // x1 = segunda cadena
    // x2 = longitud
    mov x4, #0          // índice
compare_loop:
    cmp x4, x2
    beq strings_equal
    
    ldrb w3, [x0, x4]   // Cargar carácter de primera cadena
    ldrb w5, [x1, x4]   // Cargar carácter de segunda cadena
    
    cmp w3, w5
    bne strings_different
    
    add x4, x4, #1
    b compare_loop
    
strings_equal:
    mov x0, #0          // Retornar 0 si son iguales
    ret
    
strings_different:
    mov x0, #1          // Retornar 1 si son diferentes
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o palind.o palind.s

// Vincular el archivo objeto
// ld -o palind palind.o

// Ejecutar el programa
//  ./palind

//---------------------------------------------------------------------------------------------------------------------------------------

// Enlace de asciinema
https://asciinema.org/a/0PUUZU5caX5n0aoMJQQyIQNJO




-
