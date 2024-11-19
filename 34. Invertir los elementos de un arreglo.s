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





//----------------------------------------------------------------------------------------------------------------------
