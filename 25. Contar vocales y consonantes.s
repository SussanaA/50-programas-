//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;
//
// namespace ContarVocalesConsonantes
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario una cadena de texto
//             Console.WriteLine("Ingrese una cadena de texto:");
//             string texto = Console.ReadLine();
//
//             // Inicializar contadores para vocales y consonantes
//             int contadorVocales = 0;
//             int contadorConsonantes = 0;
//
//             // Convertir el texto a minúsculas para simplificar la comparación
//             texto = texto.ToLower();
//
//             // Iterar sobre cada carácter de la cadena
//             foreach (char c in texto)
//             {
//                 // Verificar si el carácter es una letra
//                 if (char.IsLetter(c))
//                 {
//                     // Verificar si es una vocal
//                     if ("aeiou".Contains(c))
//                     {
//                         contadorVocales++;
//                     }
//                     else
//                     {
//                         // Si no es vocal, es consonante
//                         contadorConsonantes++;
//                     }
//                 }
//             }
//
//             // Mostrar los resultados
//             Console.WriteLine($"Número de vocales: {contadorVocales}");
//             Console.WriteLine($"Número de consonantes: {contadorConsonantes}");
//
//             // Pausar la consola
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
// as -o vc.o vc.s

// Vincular el archivo objeto
// ld -o vc vc.o

// Ejecutar el programa
//  ./vc

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q vc

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema






//----------------------------------------------------------------------------------------------------------------------
