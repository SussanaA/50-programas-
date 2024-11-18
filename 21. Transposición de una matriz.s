// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#

// using System;
//
// namespace TransposicionMatriz
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar el tamaño de la matriz
//             Console.Write("Ingrese el número de filas: ");
//             int filas = int.Parse(Console.ReadLine());
//
//             Console.Write("Ingrese el número de columnas: ");
//             int columnas = int.Parse(Console.ReadLine());
//
//             // Declarar la matriz original
//             int[,] matriz = new int[filas, columnas];
//
//             // Leer los valores de la matriz
//             Console.WriteLine("Ingrese los valores de la matriz:");
//             for (int i = 0; i < filas; i++)
//             {
//                 for (int j = 0; j < columnas; j++)
//                 {
//                     Console.Write($"Elemento [{i},{j}]: ");
//                     matriz[i, j] = int.Parse(Console.ReadLine());
//                 }
//             }
//
//             // Mostrar la matriz original
//             Console.WriteLine("\nMatriz original:");
//             MostrarMatriz(matriz, filas, columnas);
//
//             // Transponer la matriz
//             int[,] transpuesta = new int[columnas, filas];
//             for (int i = 0; i < filas; i++)
//             {
//                 for (int j = 0; j < columnas; j++)
//                 {
//                     transpuesta[j, i] = matriz[i, j];
//                 }
//             }
//
//             // Mostrar la matriz transpuesta
//             Console.WriteLine("\nMatriz transpuesta:");
//             MostrarMatriz(transpuesta, columnas, filas);
//         }
//
//         // Método para mostrar una matriz
//         static void MostrarMatriz(int[,] matriz, int filas, int columnas)
//         {
//             for (int i = 0; i < filas; i++)
//             {
//                 for (int j = 0; j < columnas; j++)
//                 {
//                     Console.Write(matriz[i, j] + "\t");
//                 }
//                 Console.WriteLine();
//             }
//         }
//     }
// }


//-------------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
    prompt_filas:    .asciz "Ingrese el número de filas (1-10): "
    prompt_columnas: .asciz "Ingrese el número de columnas (1-10): "
    prompt_elemento: .asciz "Elemento ["
    prompt_coma:     .asciz ","
    prompt_cierre:   .asciz "]: "
    msg_original:    .asciz "\nMatriz original:\n"
    msg_transpuesta: .asciz "\nMatriz transpuesta:\n"
    msg_error:       .asciz "Error: El tamaño debe estar entre 1 y 10\n"
    tab:            .asciz "\t"
    newline:        .asciz "\n"
    buffer:         .skip 12
    espacio:        .asciz " "

.section .bss
    filas:          .skip 4
    columnas:       .skip 4
    matriz:         .skip 400    // Espacio para matriz 10x10 (máximo)
    transpuesta:    .skip 400    // Espacio para matriz transpuesta
    temp:           .skip 4

.section .text
_start:
    // Configurar el frame pointer
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Solicitar y validar número de filas
pedir_filas:
    mov x0, #1
    adr x1, prompt_filas
    bl print_string

    // Leer filas
    bl read_int
    
    // Validar que filas esté entre 1 y 10
    cmp w0, #1
    blt dimension_invalida
    cmp w0, #10
    bgt dimension_invalida
    
    // Guardar número de filas
    adr x1, filas
    str w0, [x1]
    b pedir_columnas

dimension_invalida:
    mov x0, #1
    adr x1, msg_error
    bl print_string
    b pedir_filas

pedir_columnas:
    mov x0, #1
    adr x1, prompt_columnas
    bl print_string

    bl read_int
    
    cmp w0, #1
    blt dimension_invalida_col
    cmp w0, #10
    bgt dimension_invalida_col
    
    adr x1, columnas
    str w0, [x1]
    b continuar_programa

dimension_invalida_col:
    mov x0, #1
    adr x1, msg_error
    bl print_string
    b pedir_columnas

continuar_programa:
    bl leer_matriz

    mov x0, #1
    adr x1, msg_original
    bl print_string
    bl mostrar_matriz

    bl transponer_matriz

    mov x0, #1
    adr x1, msg_transpuesta
    bl print_string
    bl mostrar_matriz_transpuesta

    // Restaurar y salir
    ldp x29, x30, [sp], #16
    mov x0, #0
    mov x8, #93
    svc #0

// Función para leer la matriz
leer_matriz:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    mov x29, sp

    mov x19, #0  // i = 0
loop_i:
    adr x0, filas
    ldr w0, [x0]
    sxtw x0, w0
    cmp x19, x0
    bge end_loop_i
    
    mov x20, #0  // j = 0
loop_j:
    adr x0, columnas
    ldr w0, [x0]
    sxtw x0, w0
    cmp x20, x0
    bge end_loop_j

    mov x0, #1
    adr x1, prompt_elemento
    bl print_string

    mov w0, w19
    bl print_int

    mov x0, #1
    adr x1, prompt_coma
    bl print_string

    mov w0, w20
    bl print_int

    mov x0, #1
    adr x1, prompt_cierre
    bl print_string

    bl read_int
    
    // Calcular posición y guardar
    mov x21, x19
    adr x22, columnas
    ldr w22, [x22]
    mul x21, x21, x22
    add x21, x21, x20
    lsl x21, x21, #2
    adr x22, matriz
    add x22, x22, x21
    str w0, [x22]

    add x20, x20, #1
    b loop_j
end_loop_j:
    add x19, x19, #1
    b loop_i
end_loop_i:
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función para transponer la matriz
transponer_matriz:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    mov x29, sp

    mov x19, #0
trans_loop_i:
    adr x0, filas
    ldr w0, [x0]
    sxtw x0, w0
    cmp x19, x0
    bge end_trans_loop_i
    
    mov x20, #0
trans_loop_j:
    adr x0, columnas
    ldr w0, [x0]
    sxtw x0, w0
    cmp x20, x0
    bge end_trans_loop_j

    // Obtener elemento original
    mov x0, x19
    adr x1, columnas
    ldr w1, [x1]
    mul x0, x0, x1
    add x0, x0, x20
    lsl x0, x0, #2
    adr x1, matriz
    add x1, x1, x0
    ldr w2, [x1]

    // Guardar en transpuesta
    mov x0, x20
    adr x1, filas
    ldr w1, [x1]
    mul x0, x0, x1
    add x0, x0, x19
    lsl x0, x0, #2
    adr x1, transpuesta
    add x1, x1, x0
    str w2, [x1]

    add x20, x20, #1
    b trans_loop_j
end_trans_loop_j:
    add x19, x19, #1
    b trans_loop_i
end_trans_loop_i:
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función para mostrar la matriz original
mostrar_matriz:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    mov x29, sp

    mov x19, #0
show_loop_i:
    adr x0, filas
    ldr w0, [x0]
    sxtw x0, w0
    cmp x19, x0
    bge end_show_loop_i
    
    mov x20, #0
show_loop_j:
    adr x0, columnas
    ldr w0, [x0]
    sxtw x0, w0
    cmp x20, x0
    bge end_show_loop_j

    mov x0, x19
    adr x1, columnas
    ldr w1, [x1]
    mul x0, x0, x1
    add x0, x0, x20
    lsl x0, x0, #2
    adr x1, matriz
    add x1, x1, x0
    ldr w0, [x1]

    bl print_int

    mov x0, #1
    adr x1, tab
    bl print_string

    add x20, x20, #1
    b show_loop_j
end_show_loop_j:
    mov x0, #1
    adr x1, newline
    bl print_string

    add x19, x19, #1
    b show_loop_i
end_show_loop_i:
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función para mostrar la matriz transpuesta
mostrar_matriz_transpuesta:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    mov x29, sp

    mov x19, #0
show_trans_loop_i:
    adr x0, columnas
    ldr w0, [x0]
    sxtw x0, w0
    cmp x19, x0
    bge end_show_trans_loop_i
    
    mov x20, #0
show_trans_loop_j:
    adr x0, filas
    ldr w0, [x0]
    sxtw x0, w0
    cmp x20, x0
    bge end_show_trans_loop_j

    mov x0, x19
    adr x1, filas
    ldr w1, [x1]
    mul x0, x0, x1
    add x0, x0, x20
    lsl x0, x0, #2
    adr x1, transpuesta
    add x1, x1, x0
    ldr w0, [x1]

    bl print_int

    mov x0, #1
    adr x1, tab
    bl print_string

    add x20, x20, #1
    b show_trans_loop_j
end_show_trans_loop_j:
    mov x0, #1
    adr x1, newline
    bl print_string

    add x19, x19, #1
    b show_trans_loop_i
end_show_trans_loop_i:
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función para leer un entero
read_int:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x0, #0
    adr x1, buffer
    mov x2, #12
    mov x8, #63
    svc #0
    
    adr x1, buffer
    bl ascii_to_int
    
    ldp x29, x30, [sp], #16
    ret

// Función para imprimir un entero
print_int:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Preservar w0 ya que será modificado
    str w0, [sp, #-16]!
    
    adr x1, buffer
    bl int_to_ascii
    
    mov x0, #1
    mov x8, #64
    svc #0
    
    // Restaurar w0
    ldr w0, [sp], #16
    
    ldp x29, x30, [sp], #16
    ret

// Función para convertir ASCII a entero
ascii_to_int:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    mov w2, #0          // resultado
    mov w3, #10         // multiplicador
parse_loop:
    ldrb w4, [x1], #1
    cmp w4, #0x0A
    beq parse_done
    sub w4, w4, #0x30
    mul w2, w2, w3
    add w2, w2, w4
    b parse_loop
parse_done:
    mov w0, w2
    ldp x29, x30, [sp], #16
    ret

// Función para convertir entero a ASCII
int_to_ascii:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    mov x2, x1
    add x1, x1, #11
    mov w3, #0
    strb w3, [x1], #-1
    mov w3, #10
convert_loop:
    udiv w4, w0, w3
    msub w5, w4, w3, w0
    add w5, w5, #0x30
    strb w5, [x1], #-1
    mov w0, w4
    cbnz w0, convert_loop
    add x1, x1, #1
    sub x2, x1, x2
    
    ldp x29, x30, [sp], #16
    ret

// Función para imprimir cadena
print_string:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    mov x2, #0
str_len_loop:
    ldrb w3, [x1, x2]
    cbz w3, str_len_done
    add x2, x2, #1
    b str_len_loop
str_len_done:
    mov x8, #64
    svc #0
    
    ldp x29, x30, [sp], #16
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o tranm.o tranm.s

// Vincular el archivo objeto
// ld -o tranm tranm.o

// Ejecutar el programa
//  ./tranm

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q tranm

// start

// step

// q


//-------------------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/lAaMBbQK4DEjvNfDmtpla6t0F



-
