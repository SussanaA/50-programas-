//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace LecturaEntrada
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese un texto
//             Console.Write("Ingresa un texto: ");
            
//             // Leer la entrada del usuario desde el teclado
//             string entrada = Console.ReadLine();
            
//             // Mostrar la entrada ingresada
//             Console.WriteLine("Has ingresado: " + entrada);
            
//             // Esperar a que el usuario presione una tecla para cerrar el programa
//             Console.WriteLine("Presiona cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
prompt:     .string "Ingresar un valor : "
format_in:  .string "%255s"             // Límite de 255 caracteres
format_out: .string "Se ha introducido: %s\n"
buffer:     .space 256                  // Buffer para la entrada

        .text
        .global main
        .type main, %function

main:
        stp     x29, x30, [sp, -16]!    // Guardar frame pointer y link register
        mov     x29, sp                  // Set up frame pointer

        // Imprimir prompt
        adr     x0, prompt
        bl      printf

        // Leer entrada
        adr     x1, buffer              // Dirección del buffer
        adr     x0, format_in
        bl      scanf

        // Imprimir resultado
        adr     x0, format_out
        adr     x1, buffer              // Cargar dirección de la cadena
        bl      printf

        mov     w0, #0                  // Return 0
        ldp     x29, x30, [sp], #16     // Restaurar frame pointer y link register
        ret

        .size main, (. - main)

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o lee.o lee.s

// Vincular el archivo objeto
// ld -o lee lee.o

// Ejecutar el programa
//  ./lee

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q lee

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/Yf2X6POGUx2wnOzTZA9nAGBkQ



//----------------------------------------------------------------------------------------------------------------------//
