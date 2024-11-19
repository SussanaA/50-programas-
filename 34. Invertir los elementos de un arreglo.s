//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace InvertirArreglo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Crear un arreglo de ejemplo
//             int[] arreglo = { 1, 2, 3, 4, 5 };

//             // Mostrar el arreglo original
//             Console.WriteLine("Arreglo original:");
//             MostrarArreglo(arreglo);

//             // Invertir el arreglo
//             InvertirArreglo(arreglo);

//             // Mostrar el arreglo invertido
//             Console.WriteLine("Arreglo invertido:");
//             MostrarArreglo(arreglo);

//             // Esperar una tecla para salir
//             Console.ReadKey();
//         }

//         // Método para invertir el arreglo
//         static void InvertirArreglo(int[] arreglo)
//         {
//             int inicio = 0;
//             int fin = arreglo.Length - 1;

//             while (inicio < fin)
//             {
//                 // Intercambiar los elementos
//                 int temp = arreglo[inicio];
//                 arreglo[inicio] = arreglo[fin];
//                 arreglo[fin] = temp;

//                 // Mover los índices
//                 inicio++;
//                 fin--;
//             }
//         }

//         // Método para mostrar el arreglo en consola
//         static void MostrarArreglo(int[] arreglo)
//         {
//             foreach (int numero in arreglo)
//             {
//                 Console.Write(numero + " ");
//             }
//             Console.WriteLine(); // Nueva línea después de mostrar el arreglo
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
msg1:    .ascii "Arreglo original: "
len1 = . - msg1
msg2:    .ascii "\nArreglo invertido: "
len2 = . - msg2
array:   .quad 1, 2, 3, 4, 5    // Arreglo a invertir
size = (. - array) / 8          // Tamaño del arreglo
buffer:  .skip 32               // Buffer para conversión
space:   .ascii " "
newline: .ascii "\n"

.section .text
_start:
    // Imprimir mensaje inicial
    mov x0, #1
    ldr x1, =msg1
    mov x2, len1
    mov x8, #64
    svc #0

    // Mostrar arreglo original
    bl mostrar_arreglo

    // Invertir arreglo
    bl invertir_arreglo

    // Imprimir mensaje de arreglo invertido
    mov x0, #1
    ldr x1, =msg2
    mov x2, len2
    mov x8, #64
    svc #0

    // Mostrar arreglo invertido
    bl mostrar_arreglo

    // Imprimir nueva línea
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0

    // Salir
    mov x0, #0
    mov x8, #93
    svc #0

invertir_arreglo:
    // Guardar enlace de retorno
    str x30, [sp, #-16]!

    // Preparar índices
    mov x9, #0                  // Índice inicial
    mov x10, size              // Tamaño total
    sub x10, x10, #1           // Índice final (tamaño - 1)
    ldr x11, =array           // Dirección base del arreglo

loop_invertir:
    // Verificar si terminamos
    cmp x9, x10
    bge fin_invertir

    // Cargar valores
    ldr x12, [x11, x9, lsl #3]  // Valor inicio
    ldr x13, [x11, x10, lsl #3] // Valor final

    // Intercambiar valores
    str x13, [x11, x9, lsl #3]
    str x12, [x11, x10, lsl #3]

    // Actualizar índices
    add x9, x9, #1
    sub x10, x10, #1
    b loop_invertir

fin_invertir:
    // Restaurar enlace de retorno
    ldr x30, [sp], #16
    ret

mostrar_arreglo:
    // Guardar enlace de retorno
    str x30, [sp, #-16]!

    // Inicializar
    mov x9, #0                  // Índice
    ldr x10, =array           // Dirección base
    mov x11, size             // Tamaño

loop_mostrar:
    // Verificar si terminamos
    cmp x9, x11
    bge fin_mostrar

    // Cargar número actual
    ldr x12, [x10, x9, lsl #3]

    // Convertir a string
    ldr x13, =buffer
    mov x14, x12
    mov x15, #0               // Contador de dígitos

convertir:
    mov x16, #10
    udiv x17, x14, x16
    msub x18, x17, x16, x14
    add x18, x18, #'0'
    strb w18, [x13, x15]
    add x15, x15, #1
    mov x14, x17
    cbnz x14, convertir

    // Imprimir número
    mov x0, #1
    mov x1, x13
    mov x2, x15
    mov x8, #64
    svc #0

    // Imprimir espacio
    mov x0, #1
    ldr x1, =space
    mov x2, #1
    mov x8, #64
    svc #0

    // Siguiente número
    add x9, x9, #1
    b loop_mostrar

fin_mostrar:
    // Restaurar enlace de retorno
    ldr x30, [sp], #16
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o in.o in.s

// Vincular el archivo objeto
// ld -o in in.o

// Ejecutar el programa
//  ./in

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q in

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/Nx2jJeuEU9NJBBkWzHYtfznPL



//----------------------------------------------------------------------------------------------------------------------
