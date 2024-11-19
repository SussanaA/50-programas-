//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace RotacionArreglo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar el tamaño del arreglo
//             Console.Write("Ingrese el tamaño del arreglo: ");
//             int n = int.Parse(Console.ReadLine());

//             // Crear el arreglo y llenarlo con números
//             int[] arreglo = new int[n];
//             Console.WriteLine("Ingrese los elementos del arreglo:");
//             for (int i = 0; i < n; i++)
//             {
//                 Console.Write($"Elemento {i + 1}: ");
//                 arreglo[i] = int.Parse(Console.ReadLine());
//             }

//             // Solicitar el número de rotaciones
//             Console.Write("Ingrese el número de rotaciones: ");
//             int rotaciones = int.Parse(Console.ReadLine());

//             // Realizar la rotación
//             RotarArreglo(arreglo, rotaciones);

//             // Mostrar el arreglo después de las rotaciones
//             Console.WriteLine("El arreglo después de las rotaciones es:");
//             foreach (var item in arreglo)
//             {
//                 Console.Write(item + " ");
//             }
//         }

//         static void RotarArreglo(int[] arreglo, int rotaciones)
//         {
//             int n = arreglo.Length;
//             rotaciones = rotaciones % n;  // En caso de que las rotaciones sean mayores que el tamaño del arreglo
//             if (rotaciones == 0)
//                 return;

//             // Realizamos la rotación
//             InvertirArreglo(arreglo, 0, n - 1);  // Invertimos todo el arreglo
//             InvertirArreglo(arreglo, 0, rotaciones - 1);  // Invertimos la parte que se mueve al final
//             InvertirArreglo(arreglo, rotaciones, n - 1);  // Invertimos la parte restante
//         }

//         static void InvertirArreglo(int[] arreglo, int inicio, int fin)
//         {
//             while (inicio < fin)
//             {
//                 int temp = arreglo[inicio];
//                 arreglo[inicio] = arreglo[fin];
//                 arreglo[fin] = temp;
//                 inicio++;
//                 fin--;
//             }
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o rot.o rot.s

// Vincular el archivo objeto
// ld -o rot rot.o

// Ejecutar el programa
//  ./rot

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q rot

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------//
