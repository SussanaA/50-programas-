// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#

// using System;

// namespace BusquedaNumeroMinimo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Definir un arreglo de ejemplo
//             int[] numeros = { 23, 5, 89, 15, 42, 3, 77, 12 };

//             // Inicializar el valor mínimo como el primer elemento del arreglo
//             int numeroMinimo = numeros[0];

//             // Recorrer el arreglo para encontrar el número mínimo
//             for (int i = 1; i < numeros.Length; i++)
//             {
//                 if (numeros[i] < numeroMinimo)
//                 {
//                     numeroMinimo = numeros[i];
//                 }
//             }

//             // Mostrar el número mínimo encontrado
//             Console.WriteLine("El número mínimo en el arreglo es: " + numeroMinimo);

//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("Presiona cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }


//-------------------------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
    // Mensajes para mostrar
    msg_result:  .asciz "El numero minimo en el arreglo es: "
    newline:     .asciz "\n"
    
    // Arreglo de números (equivalente al arreglo en C#)
    .align 4
    numeros:     .word 23, 5, 89, 15, 42, 3, 77, 12
    longitud:    .word 8          // Longitud del arreglo
    
    // Buffer para convertir números a texto
    .bss
    buffer:     .skip 12         // Buffer para convertir números a ASCII

.section .text
_start:
    // Cargar la dirección base del arreglo
    ldr x19, =numeros
    
    // Cargar el primer número como mínimo inicial
    ldr w20, [x19]              // w20 contendrá el número mínimo
    
    // Cargar la longitud del arreglo
    ldr x21, =longitud
    ldr w21, [x21]              // w21 contendrá la longitud
    
    // Inicializar el contador del loop
    mov w22, #1                 // i = 1
    
loop:
    // Comparar si hemos llegado al final del arreglo
    cmp w22, w21
    bge end_loop
    
    // Cargar el siguiente número del arreglo
    ldr w23, [x19, w22, SXTW #2]  // Cargar números[i]
    
    // Comparar con el mínimo actual
    cmp w23, w20
    bge continue                   // Si números[i] >= mínimo, continuar
    
    // Si llegamos aquí, encontramos un nuevo mínimo
    mov w20, w23                   // Actualizar el mínimo
    
continue:
    // Incrementar el contador y continuar el loop
    add w22, w22, #1
    b loop
    
end_loop:
    // Imprimir el mensaje de resultado
    mov x0, #1                    // stdout
    ldr x1, =msg_result          // Mensaje
    bl print_string
    
    // Convertir el número mínimo a string y mostrarlo
    mov w0, w20                   // Número a convertir
    ldr x1, =buffer              // Buffer donde guardar el resultado
    bl int_to_ascii              // Convertir a ASCII
    
    // Imprimir el número convertido
    mov x0, #1                    // stdout
    bl print_string
    
    // Imprimir nueva línea
    mov x0, #1                    // stdout
    ldr x1, =newline
    bl print_string
    
    // Terminar el programa
    mov x0, #0                    // Código de salida
    mov x8, #93                   // Syscall exit
    svc #0

// Función para convertir un entero en ASCII
int_to_ascii:
    mov x2, x1                    // Guardar la dirección del buffer
    add x1, x1, #11              // Apuntar al final del buffer
    mov w3, #10                   // Divisor
    
    // Si el número es negativo, convertirlo a positivo y añadir el signo
    cmp w0, #0
    bge convert_loop
    neg w0, w0                    // Hacer positivo el número
    mov w4, #'-'                  // Añadir signo negativo
    strb w4, [x2]                // Guardar el signo
    add x2, x2, #1               // Mover el puntero
    
convert_loop:
    udiv w4, w0, w3              // w4 = w0 / 10
    msub w5, w4, w3, w0          // w5 = w0 % 10
    add w5, w5, #'0'             // Convertir a ASCII
    strb w5, [x1], #-1           // Guardar dígito y retroceder
    mov w0, w4                   // Preparar para siguiente iteración
    cbnz w0, convert_loop        // Continuar si no es cero
    
    // Mover los dígitos al inicio del buffer si es necesario
    add x1, x1, #1               // Ajustar puntero
    mov x0, x2                   // Retornar puntero al inicio
    ret

// Función para imprimir una cadena
print_string:
    // Calcular la longitud de la cadena
    mov x2, #0                    // Contador de longitud
find_length:
    ldrb w3, [x1, x2]            // Cargar byte
    cbz w3, print_now            // Si es 0, terminar
    add x2, x2, #1               // Incrementar contador
    b find_length
    
print_now:
    mov x8, #64                   // Syscall write
    svc #0
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o min.o min.s

// Vincular el archivo objeto
// ld -o min min.o

// Ejecutar el programa
//  ./min

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q min

// start

// step

// q


//-------------------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/Rul6KS0TsIZF6IMdDwLmTN8bW




-
