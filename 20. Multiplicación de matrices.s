// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código de referencia en C#

// using System;
// 
// namespace MultiplicacionMatrices
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar dimensiones de las matrices
//             Console.WriteLine("Ingrese el número de filas de la primera matriz:");
//             int filas1 = int.Parse(Console.ReadLine());
//             Console.WriteLine("Ingrese el número de columnas de la primera matriz:");
//             int columnas1 = int.Parse(Console.ReadLine());
// 
//             Console.WriteLine("Ingrese el número de filas de la segunda matriz:");
//             int filas2 = int.Parse(Console.ReadLine());
//             Console.WriteLine("Ingrese el número de columnas de la segunda matriz:");
//             int columnas2 = int.Parse(Console.ReadLine());
// 
//             // Validar que las matrices se pueden multiplicar
//             if (columnas1 != filas2)
//             {
//                 Console.WriteLine("La multiplicación no es posible. El número de columnas de la primera matriz debe coincidir con el número de filas de la segunda matriz.");
//                 return;
//             }
// 
//             // Crear y llenar las matrices
//             int[,] matriz1 = new int[filas1, columnas1];
//             int[,] matriz2 = new int[filas2, columnas2];
// 
//             Console.WriteLine("Ingrese los elementos de la primera matriz:");
//             for (int i = 0; i < filas1; i++)
//             {
//                 for (int j = 0; j < columnas1; j++)
//                 {
//                     Console.Write($"Elemento [{i},{j}]: ");
//                     matriz1[i, j] = int.Parse(Console.ReadLine());
//                 }
//             }
// 
//             Console.WriteLine("Ingrese los elementos de la segunda matriz:");
//             for (int i = 0; i < filas2; i++)
//             {
//                 for (int j = 0; j < columnas2; j++)
//                 {
//                     Console.Write($"Elemento [{i},{j}]: ");
//                     matriz2[i, j] = int.Parse(Console.ReadLine());
//                 }
//             }
// 
//             // Realizar la multiplicación de matrices
//             int[,] resultado = new int[filas1, columnas2];
// 
//             for (int i = 0; i < filas1; i++)
//             {
//                 for (int j = 0; j < columnas2; j++)
//                 {
//                     resultado[i, j] = 0;
//                     for (int k = 0; k < columnas1; k++)
//                     {
//                         resultado[i, j] += matriz1[i, k] * matriz2[k, j];
//                     }
//                 }
//             }
// 
//             // Mostrar el resultado
//             Console.WriteLine("El resultado de la multiplicación es:");
//             for (int i = 0; i < filas1; i++)
//             {
//                 for (int j = 0; j < columnas2; j++)
//                 {
//                     Console.Write($"{resultado[i, j]} ");
//                 }
//                 Console.WriteLine();
//             }
// 
//             // Finalizar el programa
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }


//------------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
    // String messages
    msg_input_rows1:    .string "Ingrese el numero de filas de la primera matriz:\n"
    msg_input_cols1:    .string "Ingrese el numero de columnas de la primera matriz:\n"
    msg_input_rows2:    .string "Ingrese el numero de filas de la segunda matriz:\n"
    msg_input_cols2:    .string "Ingrese el numero de columnas de la segunda matriz:\n"
    msg_error:          .string "La multiplicacion no es posible. El numero de columnas de la primera matriz debe coincidir con el numero de filas de la segunda matriz.\n"
    msg_input_matrix1:  .string "Ingrese los elementos de la primera matriz:\n"
    msg_input_matrix2:  .string "Ingrese los elementos de la segunda matriz:\n"
    msg_element:        .string "Elemento [%d,%d]: "
    msg_result:         .string "El resultado de la multiplicacion es:\n"
    msg_newline:        .string "\n"
    msg_space:          .string " "
    format_input:       .string "%d"
    format_output:      .string "%d "
    
    // Matrix storage
    .align 4
    matrix1:     .skip 400    // Space for 10x10 matrix (400 bytes)
    matrix2:     .skip 400    // Space for 10x10 matrix
    result:      .skip 400    // Space for result matrix
    
    // Matrix dimensions
    filas1:      .word 0
    columnas1:   .word 0
    filas2:      .word 0
    columnas2:   .word 0

.text
.global main
.extern printf
.extern scanf
main:
    // Save link register
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Input dimensions for first matrix
    ldr x0, =msg_input_rows1
    bl printf
    
    ldr x0, =format_input
    ldr x1, =filas1
    bl scanf

    ldr x0, =msg_input_cols1
    bl printf
    
    ldr x0, =format_input
    ldr x1, =columnas1
    bl scanf

    // Input dimensions for second matrix
    ldr x0, =msg_input_rows2
    bl printf
    
    ldr x0, =format_input
    ldr x1, =filas2
    bl scanf
    
    ldr x0, =msg_input_cols2
    bl printf
    
    ldr x0, =format_input
    ldr x1, =columnas2
    bl scanf

    // Validate matrix dimensions
    ldr x0, =columnas1
    ldr w0, [x0]
    ldr x1, =filas2
    ldr w1, [x1]
    cmp w0, w1
    b.ne dimensions_error

    // Input matrix elements
    bl input_matrices
    
    // Multiply matrices
    bl multiply_matrices
    
    // Print result
    bl print_result
    
    // Exit program
    mov w0, #0
    ldp x29, x30, [sp], #16
    ret

dimensions_error:
    ldr x0, =msg_error
    bl printf
    mov w0, #1
    ldp x29, x30, [sp], #16
    ret

input_matrices:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!  // Save callee-saved registers
    // Print message for first matrix
    ldr x0, =msg_input_matrix1
    bl printf
    
    // Initialize loop counters
    mov x19, #0  // i counter
input_matrix1_outer:
    ldr x0, =filas1
    ldr w0, [x0]
    cmp w19, w0
    b.ge input_matrix2_start
    
    mov x20, #0  // j counter
input_matrix1_inner:
    ldr x0, =columnas1
    ldr w0, [x0]
    cmp w20, w0
    b.ge input_matrix1_next_row
    // Print element prompt
    ldr x0, =msg_element
    mov w1, w19
    mov w2, w20
    bl printf
    
    // Read element
    ldr x0, =format_input
    ldr x1, =matrix1
    mov x2, x19
    ldr x3, =columnas1
    ldr w3, [x3]
    mul x2, x2, x3
    add x2, x2, x20
    lsl x2, x2, #2
    add x1, x1, x2
    bl scanf
    add x20, x20, #1
    b input_matrix1_inner
    
input_matrix1_next_row:
    add x19, x19, #1
    b input_matrix1_outer

input_matrix2_start:
    // Input for second matrix
    ldr x0, =msg_input_matrix2
    bl printf
    
    mov x19, #0  // i counter
input_matrix2_outer:
    ldr x0, =filas2
    ldr w0, [x0]
    cmp w19, w0
    b.ge input_matrices_end
    
    mov x20, #0  // j counter
input_matrix2_inner:
    ldr x0, =columnas2
    ldr w0, [x0]
    cmp w20, w0
    b.ge input_matrix2_next_row
    // Print element prompt
    ldr x0, =msg_element
    mov w1, w19
    mov w2, w20
    bl printf
    
    // Read element
    ldr x0, =format_input
    ldr x1, =matrix2
    mov x2, x19
    ldr x3, =columnas2
    ldr w3, [x3]
    mul x2, x2, x3
    add x2, x2, x20
    lsl x2, x2, #2
    add x1, x1, x2
    bl scanf
    add x20, x20, #1
    b input_matrix2_inner
    
input_matrix2_next_row:
    add x19, x19, #1
    b input_matrix2_outer

input_matrices_end:
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

multiply_matrices:
    stp x29, x30, [sp, #-16]!
    stp x19, x21, [sp, #-16]!  // Save callee-saved registers
    // Initialize outer loop counter (i)
    mov x19, #0
multiply_outer:
    ldr x0, =filas1
    ldr w0, [x0]
    cmp w19, w0
    b.ge multiply_end
    
    // Initialize middle loop counter (j)
    mov x20, #0
multiply_middle:
    ldr x0, =columnas2
    ldr w0, [x0]
    cmp w20, w0
    b.ge multiply_outer_next
    
    // Initialize accumulator for result[i][j]
    mov w22, #0
    // Initialize inner loop counter (k)
    mov x21, #0
multiply_inner:
    ldr x0, =columnas1
    ldr w0, [x0]
    cmp w21, w0
    b.ge multiply_store_result
    
    // Calculate matrix1[i][k] * matrix2[k][j]
    // Load matrix1[i][k]
    ldr x0, =matrix1
    mov x1, x19
    ldr x2, =columnas1
    ldr w2, [x2]
    mul x1, x1, x2
    add x1, x1, x21
    lsl x1, x1, #2
    add x0, x0, x1
    ldr w23, [x0]
    // Load matrix2[k][j]
    ldr x0, =matrix2
    mov x1, x21
    ldr x2, =columnas2
    ldr w2, [x2]
    mul x1, x1, x2
    add x1, x1, x20
    lsl x1, x1, #2
    add x0, x0, x1
    ldr w24, [x0]
    
    // Multiply and accumulate
    mul w23, w23, w24
    add w22, w22, w23
    
    add x21, x21, #1
    b multiply_inner
    multiply_store_result:
    // Store result[i][j]
    ldr x0, =result
    mov x1, x19
    ldr x2, =columnas2
    ldr w2, [x2]
    mul x1, x1, x2
    add x1, x1, x20
    lsl x1, x1, #2
    add x0, x0, x1
    str w22, [x0]
    
    add x20, x20, #1
    b multiply_middle

multiply_outer_next:
    add x19, x19, #1
    b multiply_outer
    multiply_end:
    ldp x19, x21, [sp], #16
    ldp x29, x30, [sp], #16
    ret

print_result:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    ldr x0, =msg_result
    bl printf
    
    mov x19, #0  // i counter
print_outer:
    ldr x0, =filas1
    ldr w0, [x0]
    cmp w19, w0
    b.ge print_end
    mov x20, #0  // j counter
print_inner:
    ldr x0, =columnas2
    ldr w0, [x0]
    cmp w20, w0
    b.ge print_newline
    
    // Print result[i][j]
    ldr x0, =format_output
    ldr x1, =result
    mov x2, x19
    ldr x3, =columnas2
    ldr w3, [x3]
    mul x2, x2, x3
    add x2, x2, x20
    lsl x2, x2, #2
    add x1, x1, x2
    ldr w1, [x1]
    bl printf
    add x20, x20, #1
    b print_inner
    
print_newline:
    ldr x0, =msg_newline
    bl printf
    add x19, x19, #1
    b print_outer
    
print_end:
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

//--------------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o multmt.o multmt.s

// Vincular el archivo objeto
// ld -o multmt multmt.o

// Ejecutar el programa
//  ./multmt

//---------------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q multmt

// start

// step

// q


//----------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/9UL1nnkPwdaBlv9JJQe2YGfJY



-
