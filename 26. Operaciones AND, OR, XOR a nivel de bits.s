//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;

// namespace OperacionesBitwise
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             Console.WriteLine("Operaciones a nivel de bits: AND, OR, XOR");

//             // Solicitar el primer número
//             Console.Write("Ingrese el primer número entero: ");
//             int numero1 = Convert.ToInt32(Console.ReadLine());

//             // Solicitar el segundo número
//             Console.Write("Ingrese el segundo número entero: ");
//             int numero2 = Convert.ToInt32(Console.ReadLine());

//             // Realizar operaciones bitwise
//             int resultadoAnd = numero1 & numero2; // AND bit a bit
//             int resultadoOr = numero1 | numero2; // OR bit a bit
//             int resultadoXor = numero1 ^ numero2; // XOR bit a bit

//             // Mostrar los resultados
//             Console.WriteLine("\nResultados de las operaciones bit a bit:");
//             Console.WriteLine($"AND: {numero1} & {numero2} = {resultadoAnd}");
//             Console.WriteLine($"OR: {numero1} | {numero2} = {resultadoOr}");
//             Console.WriteLine($"XOR: {numero1} ^ {numero2} = {resultadoXor}");

//             // Esperar una tecla para cerrar
//             Console.WriteLine("\nPresione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }

//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
    prompt1:     .asciz "Ingrese el primer número entero: "
    prompt2:     .asciz "Ingrese el segundo número entero: "
    result_and:  .asciz "AND: %d & %d = %d\n"
    result_or:   .asciz "OR: %d | %d = %d\n"
    result_xor:  .asciz "XOR: %d ^ %d = %d\n"
    format:      .asciz "%d"

.text
.global main
.extern printf
.extern scanf

main:
    // Prólogo estándar
    stp x29, x30, [sp, -48]!
    mov x29, sp

    // Solicitar primer número
    adr x0, prompt1
    bl printf

    // Leer primer número
    sub sp, sp, #16
    mov x0, sp
    adr x1, format
    bl scanf
    ldr w19, [sp]  // w19 = primer número

    // Solicitar segundo número
    adr x0, prompt2
    bl printf

    // Leer segundo número
    mov x0, sp
    adr x1, format
    bl scanf
    ldr w20, [sp]  // w20 = segundo número

    // Operación AND
    and w21, w19, w20  // w21 = resultado AND
    
    // Imprimir resultado AND
    adr x0, result_and
    mov w1, w19
    mov w2, w20
    mov w3, w21
    bl printf

    // Operación OR
    orr w22, w19, w20  // w22 = resultado OR
    
    // Imprimir resultado OR
    adr x0, result_or
    mov w1, w19
    mov w2, w20
    mov w3, w22
    bl printf

    // Operación XOR
    eor w23, w19, w20  // w23 = resultado XOR
    
    // Imprimir resultado XOR
    adr x0, result_xor
    mov w1, w19
    mov w2, w20
    mov w3, w23
    bl printf

    // Restaurar pila y registros
    ldp x29, x30, [sp], #48

    // Salir del programa
    mov x0, #0
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o aox.o aox.s

// Vincular el archivo objeto
// ld -o aox aox.o

// Ejecutar el programa
//  ./aox

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q aox

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/41M7c7gKW6rT65zNMTwCLlf8p




//----------------------------------------------------------------------------------------------------------------------
