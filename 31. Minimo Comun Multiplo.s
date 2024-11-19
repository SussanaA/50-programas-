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
