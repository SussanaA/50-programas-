//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace HexadecimalToDecimal
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario ingresar un número hexadecimal
//             Console.Write("Ingrese un número en formato hexadecimal: ");
//             string hexNumber = Console.ReadLine();

//             // Intentar convertir el número hexadecimal a decimal
//             try
//             {
//                 // Convertir el número hexadecimal a decimal
//                 int decimalNumber = Convert.ToInt32(hexNumber, 16);

//                 // Mostrar el resultado
//                 Console.WriteLine($"El número hexadecimal {hexNumber} en decimal es: {decimalNumber}");
//             }
//             catch (FormatException)
//             {
//                 // Si ocurre un error en la conversión, mostrar un mensaje
//                 Console.WriteLine("El número ingresado no es válido en formato hexadecimal.");
//             }

//             // Esperar a que el usuario presione una tecla para cerrar
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
// as -o hxde.o hxde.s

// Vincular el archivo objeto
// ld -o hxde hxde.o

// Ejecutar el programa
//  ./hxde

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q hxde

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------////
