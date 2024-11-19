//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;

// namespace Desplazamiento
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar un número entero al usuario
//             Console.Write("Ingrese un número entero: ");
//             int numero = Convert.ToInt32(Console.ReadLine());

//             // Solicitar el número de posiciones para el desplazamiento
//             Console.Write("Ingrese el número de posiciones para desplazar: ");
//             int posiciones = Convert.ToInt32(Console.ReadLine());

//             // Realizar desplazamiento a la izquierda (<<)
//             int resultadoIzquierda = numero << posiciones;
//             Console.WriteLine($"Resultado del desplazamiento a la izquierda: {resultadoIzquierda}");

//             // Realizar desplazamiento a la derecha (>>)
//             int resultadoDerecha = numero >> posiciones;
//             Console.WriteLine($"Resultado del desplazamiento a la derecha: {resultadoDerecha}");

//             // Esperar una tecla para cerrar el programa
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }

//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.section .data
    .align 4
    prompt_numero:     .asciz "Ingrese un número entero: "
    prompt_posiciones: .asciz "Ingrese el número de posiciones para desplazar: "
    msg_izquierda:     .asciz "Resultado del desplazamiento a la izquierda: %d\n"
    msg_derecha:       .asciz "Resultado del desplazamiento a la derecha: %d\n"
    formato_scanf:     .asciz "%d"

.section .bss
    .align 4
    numero:     .space 4
    posiciones: .space 4

.section .text
.global main
.extern printf
.extern scanf

main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    adr x0, prompt_numero
    bl printf

    adr x0, formato_scanf
    adr x1, numero
    bl scanf

    adr x0, prompt_posiciones
    bl printf

    adr x0, formato_scanf
    adr x1, posiciones
    bl scanf

    ldr w2, [x1, #0]
    ldr w1, [x1, #4]

    lsl w3, w2, w1
    adr x0, msg_izquierda
    mov w1, w3
    bl printf

    lsr w4, w2, w1
    adr x0, msg_derecha
    mov w1, w4
    bl printf

    mov w0, #0
    ldp x29, x30, [sp], #16
    ret

.section .note.GNU-stack,"",%progbits

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o id.o id.s

// Vincular el archivo objeto
// ld -o id id.o

// Ejecutar el programa
//  ./id

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q id

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/LCMtA3jbGWvwEP48N1wFbq6NZ



//----------------------------------------------------------------------------------------------------------------------
