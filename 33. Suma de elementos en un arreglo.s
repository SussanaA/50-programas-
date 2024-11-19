//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace SumaElementosArreglo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar el tamaño del arreglo
//             Console.Write("Ingrese el tamaño del arreglo: ");
//             int tamaño = Convert.ToInt32(Console.ReadLine());

//             // Declarar el arreglo
//             int[] arreglo = new int[tamaño];

//             // Solicitar los elementos del arreglo
//             Console.WriteLine("Ingrese los elementos del arreglo:");
//             for (int i = 0; i < tamaño; i++)
//             {
//                 Console.Write($"Elemento {i + 1}: ");
//                 arreglo[i] = Convert.ToInt32(Console.ReadLine());
//             }

//             // Calcular la suma de los elementos
//             int suma = 0;
//             for (int i = 0; i < tamaño; i++)
//             {
//                 suma += arreglo[i];
//             }

//             // Mostrar el resultado
//             Console.WriteLine($"La suma de los elementos del arreglo es: {suma}");

//             // Esperar a que el usuario presione una tecla para salir
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
// as -o elem.o elem.s

// Vincular el archivo objeto
// ld -o elem elem.o

// Ejecutar el programa
//  ./elem

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q elem

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------
