//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace BinarioADecimal
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese un número binario
//             Console.Write("Ingrese un número binario: ");
//             string binario = Console.ReadLine();

//             // Convertir el número binario a decimal
//             int decimalResult = Convert.ToInt32(binario, 2);

//             // Mostrar el resultado
//             Console.WriteLine($"El número binario {binario} en decimal es: {decimalResult}");

//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
    prompt:     .asciz "Ingresa un número en binario: "
    outfmt:     .asciz "Decimal: %ld\n"
    scanfmt:    .asciz "%s"
    error_msg:  .asciz "Invalid binary number\n"
    buffer:     .skip 65            // Buffer for binary input (64 bits + null)

.text
    .global main
    .align 2

main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Print prompt
    adrp    x0, prompt
    add     x0, x0, :lo12:prompt
    bl      printf

    // Read input
    adrp    x0, scanfmt
    add     x0, x0, :lo12:scanfmt
    adrp    x1, buffer
    add     x1, x1, :lo12:buffer
    bl      scanf

    // Initialize result
    mov     x19, #0               // Result
    adrp    x20, buffer
    add     x20, x20, :lo12:buffer

convert_loop:
    ldrb    w21, [x20], #1        // Load next character
    cbz     w21, done             // If null terminator, we're done

    // Check if valid binary digit
    cmp     w21, #'0'
    b.lt    invalid
    cmp     w21, #'1'
    b.gt    invalid

    // Shift result left and add new bit
    lsl     x19, x19, #1
    sub     w21, w21, #'0'
    add     x19, x19, x21
    b       convert_loop

invalid:
    adrp    x0, error_msg
    add     x0, x0, :lo12:error_msg
    bl      printf
    mov     w0, #1
    b       exit

done:
    // Print result
    adrp    x0, outfmt
    add     x0, x0, :lo12:outfmt
    mov     x1, x19
    bl      printf

    mov     w0, #0

exit:
    ldp     x29, x30, [sp], #16
    ret

.size main, .-main

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o bindec.o bindec.s

// Vincular el archivo objeto
// ld -o bindec bindec.o

// Ejecutar el programa
//  ./bindec

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q bindec

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/QlonVbboEk31VlPNxkqb8C82B


//----------------------------------------------------------------------------------------------------------------------//
