//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace SumaElementosArreglo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar el tamaño del arreglo
//             Console.Write("Ingrese el tamaño del arreglo: ");
//             int tamaño = Convert.ToInt32(Console.ReadLine());

//             // Declarar el arreglo
//             int[] arreglo = new int[tamaño];

//             // Solicitar los elementos del arreglo
//             Console.WriteLine("Ingrese los elementos del arreglo:");
//             for (int i = 0; i < tamaño; i++)
//             {
//                 Console.Write($"Elemento {i + 1}: ");
//                 arreglo[i] = Convert.ToInt32(Console.ReadLine());
//             }

//             // Calcular la suma de los elementos
//             int suma = 0;
//             for (int i = 0; i < tamaño; i++)
//             {
//                 suma += arreglo[i];
//             }

//             // Mostrar el resultado
//             Console.WriteLine($"La suma de los elementos del arreglo es: {suma}");

//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
    size_prompt:    .asciz "Tamaño del arreglo: "
    elem_prompt:    .asciz "Elemento %d: "
    outfmt:         .asciz "Suma de los elementos del arreglo: %ld\n"
    scanfmt:        .asciz "%ld"
    array:          .skip 400       // Space for 50 long integers
    size:           .quad 0

.text
    .global main
    .align 2

main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Print size prompt
    adrp    x0, size_prompt
    add     x0, x0, :lo12:size_prompt
    bl      printf

    // Read size
    adrp    x0, scanfmt
    add     x0, x0, :lo12:scanfmt
    adrp    x1, size
    add     x1, x1, :lo12:size
    bl      scanf

    // Initialize array input
    mov     x19, #0               // Counter
    adrp    x20, array           // Array base address
    add     x20, x20, :lo12:array
    adrp    x21, size
    add     x21, x21, :lo12:size
    ldr     x21, [x21]           // Size value

input_loop:
    cmp     x19, x21
    b.ge    calculate_sum        // If counter >= size, start sum

    // Print element prompt
    adrp    x0, elem_prompt
    add     x0, x0, :lo12:elem_prompt
    add     x1, x19, #1          // Element number (1-based)
    bl      printf

    // Read element
    adrp    x0, scanfmt
    add     x0, x0, :lo12:scanfmt
    mov     x1, x20              // Current array position
    bl      scanf

    add     x20, x20, #8         // Move to next array position
    add     x19, x19, #1         // Increment counter
    b       input_loop

calculate_sum:
    mov     x19, #0              // Reset counter
    mov     x22, #0              // Sum
    adrp    x20, array          // Reset array pointer
    add     x20, x20, :lo12:array

sum_loop:
    cmp     x19, x21
    b.ge    print_result        // If counter >= size, print result
    
    ldr     x23, [x20], #8      // Load value and increment pointer
    add     x22, x22, x23       // Add to sum
    add     x19, x19, #1        // Increment counter
    b       sum_loop

print_result:
    // Print sum
    adrp    x0, outfmt
    add     x0, x0, :lo12:outfmt
    mov     x1, x22
    bl      printf

    mov     w0, #0
    ldp     x29, x30, [sp], #16
    ret

.size main, .-main

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o elem.o elem.s

// Vincular el archivo objeto
// ld -o elem elem.o

// Ejecutar el programa
//  ./elem

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q elem

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/VTCqzywyi378sr9EXeUvIYXJ7



//----------------------------------------------------------------------------------------------------------------------
