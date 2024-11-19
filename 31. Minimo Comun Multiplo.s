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

.section .bss
    numero1: .skip 8              // Reservar espacio para un entero de 64 bits
    numero2: .skip 8              // Reservar espacio para un entero de 64 bits
    mcm: .skip 8                  // Reservar espacio para el resultado del MCM

.section .text

_start:
    // Imprimir mensaje de bienvenida
    mov x0, 1                     // File descriptor STDOUT
    ldr x1, =msg1                  // Mensaje a imprimir
    mov x2, 42                     // Longitud del mensaje
    mov x8, 64                     // Syscall number para write
        svc 0

    // Solicitar el primer número
    mov x0, 1                     // File descriptor STDOUT
    ldr x1, =msg2                  // Mensaje para primer número
    mov x2, 27                     // Longitud del mensaje
    mov x8, 64                     // Syscall number para write
    svc 0

    // Leer el primer número
    mov x0, 0                     // File descriptor STDIN
    ldr x1, =numero1               // Dirección de la variable numero1
    mov x2, 8                      // Leer un entero de 8 bytes (64 bits)
    mov x8, 63                     // Syscall number para read
    svc 0
    // Leer el primer número
    mov x0, 0                     // File descriptor STDIN
    ldr x1, =numero1               // Dirección de la variable numero1
    mov x2, 8                      // Leer un entero de 8 bytes (64 bits)
    mov x8, 63                     // Syscall number para read
    svc 0

    // Solicitar el segundo número
    mov x0, 1                     // File descriptor STDOUT
    ldr x1, =msg3                  // Mensaje para segundo número
    mov x2, 28                     // Longitud del mensaje
    mov x8, 64                     // Syscall number para write
    svc 0

    // Leer el segundo número
    mov x0, 0                     // File descriptor STDIN
    ldr x1, =numero2               // Dirección de la variable numero2
    mov x2, 8                      // Leer un entero de 8 bytes (64 bits)
    mov x8, 63                     // Syscall number para read
    svc 0
        // Calcular el MCM
    adr x1, numero1               // Cargar la dirección de numero1 en x1
    ldr x0, [x1]                  // Cargar el valor de numero1 en x0

    adr x1, numero2               // Cargar la dirección de numero2 en x1
    ldr x1, [x1]                  // Cargar el valor de numero2 en x1


    bl CalcularMCM                // Llamar a la función CalcularMCM
    adr x1, mcm                   // Cargar la dirección de mcm en x1
    str x0, [x1]                  // Guardar el valor de x0 (resultado) en mcm

    // Imprimir el resultado
    mov x0, 1                     // File descriptor STDOUT
    ldr x1, =msg4                  // Mensaje para resultado
    mov x2, 48                     // Longitud del mensaje
    mov x8, 64                     // Syscall number para write
    svc 0
        // Salir del programa
    mov x8, 93                     // Syscall number para exit
    mov x0, 0                      // Código de salida
    svc 0

// Función CalcularMCD
CalcularMCD:
    // Algoritmo de Euclides para el MCD
    cmp x1, #0                    // Comparar b con 0
    beq fin_mcd                   // Si b == 0, terminar
    mov x2, x0                    // Guardar a en x2
    mov x0, x1                    // a = b
    mov x1, x2                    // b = residuo (guardado en x2)
    bl CalcularMCD                // Llamar recursivamente
fin_mcd:
    ret

// Función CalcularMCM
CalcularMCM:
    // MCM = (a * b) / MCD(a, b)
    mov x2, x0                    // Guardar a en x2
    mov x3, x1                    // Guardar b en x3
    bl CalcularMCD                // Calcular el MCD
    mul x0, x2, x3                // Multiplicar a * b
    sdiv x0, x0, x1               // Dividir (a * b) / MCD
    ret

// Mensajes de texto
.section .data
msg1: .asciz "=== Cálculo del Mínimo Común Múltiplo (MCM) ===\n"
msg2: .asciz "Ingrese el primer número: "
msg3: .asciz "Ingrese el segundo número: "
msg4: .asciz "El Mínimo Común Múltiplo es: "

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





//----------------------------------------------------------------------------------------------------------------------
