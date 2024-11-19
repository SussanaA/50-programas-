//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace MaximoComunDivisor
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             Console.WriteLine("Programa para calcular el Máximo Común Divisor (MCD)");

//             // Solicitar el primer número
//             Console.Write("Ingrese el primer número: ");
//             int numero1 = Convert.ToInt32(Console.ReadLine());

//             // Solicitar el segundo número
//             Console.Write("Ingrese el segundo número: ");
//             int numero2 = Convert.ToInt32(Console.ReadLine());

//             // Calcular el MCD utilizando el algoritmo de Euclides
//             int mcd = CalcularMCD(numero1, numero2);

//             // Mostrar el resultado
//             Console.WriteLine($"El MCD de {numero1} y {numero2} es: {mcd}");

//             // Esperar a que el usuario presione una tecla antes de cerrar
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         /// <summary>
//         /// Calcula el Máximo Común Divisor (MCD) usando el algoritmo de Euclides.
//         /// </summary>
//         /// <param name="a">Primer número</param>
//         /// <param name="b">Segundo número</param>
//         /// <returns>MCD de los dos números</returns>
//         static int CalcularMCD(int a, int b)
//         {
//             // Asegurarse de que ambos números sean positivos
//             a = Math.Abs(a);
//             b = Math.Abs(b);

//             // Algoritmo de Euclides
//             while (b != 0)
//             {
//                 int temp = b;
//                 b = a % b; // Resto
//                 a = temp;  // Actualizar
//             }
//             return a; // Cuando b es 0, a contiene el MCD
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start
.text

_start:
    // Alinear el stack
    sub sp, sp, #16

    // Inicializar números
    mov x9, #48     // a = 48
    mov x10, #36    // b = 36

    // Mensaje inicial
    mov x0, #1      // stdout
    adr x1, msg1
    mov x2, #23     // longitud del mensaje
    mov x8, #64     // syscall write
    svc #0

calcular_mcd:
    mov x0, x9      // a en x0
    mov x1, x10     // b en x1

bucle:
    // Si b es 0, terminar
    cbz x1, imprimir
    
    // Guardar b
    mov x2, x1
    
    // Calcular a mod b (usando división y multiplicación)
    udiv x3, x0, x1     // x3 = a / b
    msub x4, x3, x1, x0 // x4 = a - (x3 * b) = resto
    
    // a = b
    mov x0, x2
    // b = resto
    mov x1, x4
    
    b bucle

imprimir:
    // Guardar resultado
    mov x9, x0

    // Imprimir "El resultado es: "
    mov x0, #1
    adr x1, msg2
    mov x2, #17
    mov x8, #64
    svc #0

    // Convertir número a ASCII
    mov x0, x9          // Recuperar el número
    mov x4, #0          // Contador de dígitos
    
    // Reservar espacio para los dígitos (alineado a 16 bytes)
    sub sp, sp, #16
    mov x2, sp

convertir:
    mov x1, #10
    udiv x3, x0, x1     // x3 = x0 / 10
    msub x5, x3, x1, x0 // x5 = resto
    add x5, x5, #'0'    // Convertir a ASCII
    strb w5, [x2, x4]   // Guardar dígito
    add x4, x4, #1      // Incrementar contador
    mov x0, x3          // Preparar siguiente división
    cbnz x0, convertir

    // Imprimir dígitos
    mov x0, #1
    mov x1, x2
    mov x2, x4
    mov x8, #64
    svc #0

    // Nueva línea
    mov x0, #1
    adr x1, newline
    mov x2, #1
    mov x8, #64
    svc #0

    // Restaurar stack y salir
    add sp, sp, #32     // Liberar todo el espacio usado (16 + 16)
    mov x0, #0
    mov x8, #93
    svc #0

.data
msg1: .ascii "Calculando MCD(48,36):\n"
msg2: .ascii "El resultado es: "
newline: .ascii "\n"
.align 4               // Alinear los datos

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o mcd.o mcd.s

// Vincular el archivo objeto
// ld -o mcd mcd.o

// Ejecutar el programa
//  ./mcd

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q mcd

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/hOlXUTt5KkhQ236F7cIpRloRn



//----------------------------------------------------------------------------------------------------------------------
