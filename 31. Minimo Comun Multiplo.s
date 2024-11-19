//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace MaximoComunMultiplo
// {
//     class Program
//     {
//         // Función para calcular el MCD usando el algoritmo de Euclides
//         static int CalcularMCD(int a, int b)
//         {
//             while (b != 0)
//             {
//                 int residuo = a % b;
//                 a = b;
//                 b = residuo;
//             }
//             return a;
//         }

//         // Función para calcular el MCM
//         static int CalcularMCM(int a, int b)
//         {
//             return Math.Abs(a * b) / CalcularMCD(a, b);
//         }

//         static void Main(string[] args)
//         {
//             Console.WriteLine("=== Cálculo del Mínimo Común Múltiplo (MCM) ===");

//             // Solicitar el primer número
//             Console.Write("Ingrese el primer número: ");
//             int numero1 = int.Parse(Console.ReadLine());

//             // Solicitar el segundo número
//             Console.Write("Ingrese el segundo número: ");
//             int numero2 = int.Parse(Console.ReadLine());

//             // Calcular el MCM
//             int mcm = CalcularMCM(numero1, numero2);

//             // Mostrar el resultado
//             Console.WriteLine($"El Mínimo Común Múltiplo de {numero1} y {numero2} es: {mcm}");

//             // Esperar a que el usuario presione una tecla antes de cerrar
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
msg1: .ascii "El MCM de 15 y 93 es: "
len1 = . - msg1
buffer: .skip 20
newline: .ascii "\n"

.text
_start:
    // Números de entrada (15 y 93)
    mov x1, #15     // Primer número en x1
    mov x2, #93     // Segundo número en x2
    
    // Guardar copias de los números originales
    mov x19, x1     // Backup de primer número
    mov x20, x2     // Backup de segundo número

calcular_mcd:
    // Si x2 es cero, x1 tiene el MCD
    cbz x2, calcular_mcm
    
    // Algoritmo de Euclides para MCD
    mov x3, x1      // Temporal para x1
    mov x1, x2      // x1 = x2
    udiv x4, x3, x2 // x4 = x3 div x2
    msub x2, x4, x2, x3 // x2 = x3 - (x4 * x2) [resto]
    b calcular_mcd

calcular_mcm:
    // MCM = (a * b) / MCD
    // x1 contiene el MCD en este punto
    mov x3, x1          // Guardar MCD
    mul x4, x19, x20    // x4 = a * b
    udiv x0, x4, x3     // x0 = (a * b) / MCD

    // Imprimir mensaje inicial
    mov x0, #1          // stdout
    ldr x1, =msg1       // puntero al mensaje
    mov x2, len1        // longitud del mensaje
    mov x8, #64         // syscall write
    svc #0

    // Convertir MCM a string
    ldr x1, =buffer     // puntero al buffer
    mov x2, x4          // número a convertir (a * b)
    udiv x2, x2, x3     // dividir por MCD para obtener MCM
    mov x4, #0          // contador de dígitos

convertir_loop:
    mov x3, #10
    udiv x5, x2, x3     // dividir por 10
    msub x6, x5, x3, x2 // obtener resto
    add x6, x6, #'0'    // convertir a ASCII
    strb w6, [x1, x4]   // guardar dígito
    add x4, x4, #1      // incrementar contador
    mov x2, x5          // actualizar número
    cbnz x2, convertir_loop

    // Invertir string
    mov x5, #0          // índice inicio
    sub x6, x4, #1      // índice final
invertir:
    cmp x5, x6
    bge imprimir_resultado
    ldrb w7, [x1, x5]   // cargar byte inicio
    ldrb w8, [x1, x6]   // cargar byte final
    strb w8, [x1, x5]   // guardar final en inicio
    strb w7, [x1, x6]   // guardar inicio en final
    add x5, x5, #1      // incrementar inicio
    sub x6, x6, #1      // decrementar final
    b invertir

imprimir_resultado:
    // Imprimir número
    mov x0, #1          // stdout
    ldr x1, =buffer     // puntero al buffer
    mov x2, x4          // longitud del número
    mov x8, #64         // syscall write
    svc #0

    // Imprimir nueva línea
    mov x0, #1          // stdout
    ldr x1, =newline    // puntero a nueva línea
    mov x2, #1          // longitud = 1
    mov x8, #64         // syscall write
    svc #0

exit:
    mov x0, #0          // código de retorno
    mov x8, #93         // syscall exit
    svc #0

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o mcm.o mcm.s

// Vincular el archivo objeto
// ld -o mcm mcm.o

// Ejecutar el programa
//  ./mcm

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q mcm

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema
https://asciinema.org/a/w1PvNGc1XgCjcutAN9VXvQrzW




//----------------------------------------------------------------------------------------------------------------------
