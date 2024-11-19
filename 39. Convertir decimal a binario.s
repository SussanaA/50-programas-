//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace DecimalABinario
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese un número decimal
//             Console.Write("Ingresa un número decimal: ");
//             int numeroDecimal = Convert.ToInt32(Console.ReadLine());

//             // Convertir el número decimal a binario
//             string numeroBinario = DecimalABinario(numeroDecimal);

//             // Mostrar el resultado
//             Console.WriteLine($"El número {numeroDecimal} en binario es: {numeroBinario}");

//             // Esperar a que el usuario presione una tecla antes de cerrar
//             Console.WriteLine("Presiona cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         // Función para convertir un número decimal a binario
//         static string DecimalABinario(int numero)
//         {
//             if (numero == 0)
//                 return "0";

//             string binario = string.Empty;
//             while (numero > 0)
//             {
//                 binario = (numero % 2) + binario; // Agregar el residuo (0 o 1) al inicio del binario
//                 numero = numero / 2; // Dividir el número entre 2
//             }
//             return binario;
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o decbin.o decbin.s

// Vincular el archivo objeto
// ld -o decbin decbin.o

// Ejecutar el programa
//  ./decbin

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q decbin

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------//
