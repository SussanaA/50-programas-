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





-
