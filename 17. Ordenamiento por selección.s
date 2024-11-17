// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace OrdenamientoPorSeleccion
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario la cantidad de elementos
//             Console.Write("Ingrese la cantidad de elementos del arreglo: ");
//             int n = Convert.ToInt32(Console.ReadLine());
            
//             // Crear el arreglo
//             int[] arreglo = new int[n];
            
//             // Solicitar al usuario los elementos del arreglo
//             Console.WriteLine("Ingrese los elementos del arreglo:");
//             for (int i = 0; i < n; i++)
//             {
//                 Console.Write($"Elemento {i + 1}: ");
//                 arreglo[i] = Convert.ToInt32(Console.ReadLine());
//             }

//             // Mostrar el arreglo original
//             Console.WriteLine("\nArreglo original:");
//             MostrarArreglo(arreglo);

//             // Ordenar el arreglo utilizando el algoritmo de selección
//             OrdenamientoPorSeleccion(arreglo);

//             // Mostrar el arreglo ordenado
//             Console.WriteLine("\nArreglo ordenado:");
//             MostrarArreglo(arreglo);

//             // Esperar a que el usuario presione una tecla antes de salir
//             Console.WriteLine("\nPresione cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         // Método para implementar el ordenamiento por selección
//         static void OrdenamientoPorSeleccion(int[] arreglo)
//         {
//             int n = arreglo.Length;
//             for (int i = 0; i < n - 1; i++)
//             {
//                 // Encontrar el índice del menor elemento en el arreglo desde i hasta el final
//                 int indiceMenor = i;
//                 for (int j = i + 1; j < n; j++)
//                 {
//                     if (arreglo[j] < arreglo[indiceMenor])
//                     {
//                         indiceMenor = j;
//                     }
//                 }

//                 // Intercambiar el elemento actual con el menor encontrado
//                 if (indiceMenor != i)
//                 {
//                     int temp = arreglo[i];
//                     arreglo[i] = arreglo[indiceMenor];
//                     arreglo[indiceMenor] = temp;
//                 }
//             }
//         }

//         // Método para mostrar el contenido de un arreglo
//         static void MostrarArreglo(int[] arreglo)
//         {
//             foreach (int elemento in arreglo)
//             {
//                 Console.Write(elemento + " ");
//             }
//             Console.WriteLine();
//         }
//     }
// }

//-----------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

//-----------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o sel.o sel.s

// Vincular el archivo objeto
// ld -o sel sel.o

// Ejecutar el programa
//  ./sel

//-----------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q sel

// start

// step

// q


//---------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





-
