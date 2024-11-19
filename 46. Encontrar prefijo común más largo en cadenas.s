//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace PrefijoComun
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese las cadenas
//             Console.Write("Ingrese el número de cadenas: ");
//             int n = int.Parse(Console.ReadLine());

//             string[] cadenas = new string[n];

//             // Leer las cadenas
//             for (int i = 0; i < n; i++)
//             {
//                 Console.Write($"Ingrese la cadena {i + 1}: ");
//                 cadenas[i] = Console.ReadLine();
//             }

//             // Llamar al método para encontrar el prefijo común más largo
//             string prefijoComun = EncontrarPrefijoComunMasLargo(cadenas);

//             // Mostrar el resultado
//             if (string.IsNullOrEmpty(prefijoComun))
//             {
//                 Console.WriteLine("No hay un prefijo común.");
//             }
//             else
//             {
//                 Console.WriteLine("El prefijo común más largo es: " + prefijoComun);
//             }

//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         // Método que encuentra el prefijo común más largo
//         static string EncontrarPrefijoComunMasLargo(string[] cadenas)
//         {
//             if (cadenas == null || cadenas.Length == 0)
//                 return "";

//             // Suponemos que el prefijo más largo es la primera cadena
//             string prefijoComun = cadenas[0];

//             // Comparamos el prefijo con cada cadena
//             foreach (string cadena in cadenas)
//             {
//                 // Compara el prefijo con la cadena actual
//                 while (cadena.IndexOf(prefijoComun) != 0)
//                 {
//                     // Recorta el último carácter del prefijo hasta encontrar coincidencia
//                     prefijoComun = prefijoComun.Substring(0, prefijoComun.Length - 1);

//                     // Si no hay prefijo común, retornamos una cadena vacía
//                     if (prefijoComun == "")
//                         return "";
//                 }
//             }

//             return prefijoComun;
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o pref.o pref.s

// Vincular el archivo objeto
// ld -o pref pref.o

// Ejecutar el programa
//  ./pref

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q pref

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------//
