//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;

// class Program
// {
//     static void Main(string[] args)
//     {
//         // Solicitar al usuario que ingrese un número
//         Console.Write("Ingrese un número: ");
//         int numero = int.Parse(Console.ReadLine());

//         // Contar los bits activados
//         int bitsActivados = ContarBitsActivados(numero);

//         // Mostrar el resultado
//         Console.WriteLine($"El número de bits activados (1's) en {numero} es: {bitsActivados}");
//     }

//     // Método para contar los bits activados de un número
//     static int ContarBitsActivados(int numero)
//     {
//         int cuenta = 0;

//         // Usar un loop para revisar cada bit
//         while (numero != 0)
//         {
//             // Incrementar el contador si el bit más bajo está activado (1)
//             cuenta += numero & 1;

//             // Desplazar los bits a la derecha
//             numero >>= 1;
//         }

//         return cuenta;
//     }
// }

//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start
.align 4

.section .data
    .align 8
    numero:     .quad 123      // Número a analizar (1111011 en binario)
    msg:        .asciz "Número de bits activados: "
    buffer:     .skip 32       // Buffer para convertir números
    newline:    .asciz "\n"

.section .text
_start:
    // Guardar frame pointer y link register
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Imprimir mensaje inicial
    mov x0, #1              // stdout
    adr x1, msg            // dirección del mensaje
    mov x2, #26            // longitud del mensaje
    mov x8, #64            // syscall write
    svc #0

    // Cargar el número y contar bits
    adr x0, numero
    ldr x0, [x0]           // x0 contiene el número
    mov x1, #0             // x1 será nuestro contador de bits

count_loop:
    cbz x0, print_result   // Si el número es 0, terminar
    and x2, x0, #1         // Obtener el bit menos significativo
    add x1, x1, x2         // Incrementar contador si el bit es 1
    lsr x0, x0, #1         // Desplazar a la derecha
    b count_loop

print_result:
    // x1 contiene el número de bits
    mov x0, x1             // Mover el resultado a x0
    bl numero_a_ascii      // Convertir a ASCII y imprimir

    // Imprimir nueva línea
    mov x0, #1             // stdout
    adr x1, newline
    mov x2, #1
    mov x8, #64            // syscall write
    svc #0

    // Restaurar frame pointer y link register
    ldp x29, x30, [sp], #16

    // Salir del programa
    mov x0, #0             // código de retorno
    mov x8, #93            // syscall exit
    svc #0

// Función para convertir número a ASCII e imprimir
numero_a_ascii:
    stp x29, x30, [sp, #-16]!  // Guardar registros
    mov x29, sp
    
    mov x19, x0                // Guardar número original
    adr x20, buffer           // Usar buffer predefinido
    mov x21, x20              // Guardar inicio del buffer
    
    // Si el número es 0, manejarlo especialmente
    cbnz x19, conversion_loop
    mov w22, #'0'
    strb w22, [x20]
    add x20, x20, #1
    b print_num

conversion_loop:
    mov x1, #10               // Divisor
    udiv x2, x19, x1         // División
    msub x3, x2, x1, x19     // Módulo
    add w3, w3, #'0'         // Convertir a ASCII
    strb w3, [x20], #1       // Almacenar y avanzar puntero
    mov x19, x2              // Actualizar número
    cbnz x19, conversion_loop

print_num:
    // Calcular longitud
    sub x2, x20, x21         // Longitud = fin - inicio
    
    // Imprimir número
    mov x0, #1               // stdout
    mov x1, x21              // dirección del buffer
    mov x8, #64              // syscall write
    svc #0
    
    ldp x29, x30, [sp], #16  // Restaurar registros
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o cbi.o cbi.s

// Vincular el archivo objeto
// ld -o cbi cbi.o

// Ejecutar el programa
//  ./cbi

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q cbi

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/DG9RGb7TNiMDPiJYdWWX50ELh



//----------------------------------------------------------------------------------------------------------------------
