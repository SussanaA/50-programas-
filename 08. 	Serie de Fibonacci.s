// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#
// using System;

// namespace SerieFibonacci
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario el número de términos de la serie de Fibonacci
//             Console.Write("Ingrese la cantidad de términos de la Serie de Fibonacci: ");
//             int n = int.Parse(Console.ReadLine());

//             // Variables para almacenar los dos primeros términos de la serie
//             int primero = 0, segundo = 1, siguiente;

//             Console.WriteLine("Serie de Fibonacci:");

//             // Mostrar la serie de Fibonacci
//             for (int i = 0; i < n; i++)
//             {
//                 if (i <= 1)
//                     siguiente = i; // Para los dos primeros términos, asignar i
//                 else
//                 {
//                     // Calcular el siguiente término sumando los dos anteriores
//                     siguiente = primero + segundo;
//                     primero = segundo;
//                     segundo = siguiente;
//                 }

//                 // Imprimir el término de la serie
//                 Console.Write(siguiente + " ");
//             }

//             // Esperar a que el usuario presione una tecla para cerrar
//             Console.WriteLine("\nPresione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }

//-----------------------------------------------------------------------------------------------------------------

// Código en ARM64 Assembly



//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o fib.o fib.cs

// Vincular el archivo objeto
// ld -o fib fib.o

// Ejecutar el programa
//  ./fib

//---------------------------------------------------------------------------------------------------------------------------------------

// Enlace de asciinema







-
