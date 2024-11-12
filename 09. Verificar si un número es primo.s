// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código de referencia en C#

// using System;

// namespace VerificarNumeroPrimo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario un número para verificar si es primo
//             Console.Write("Ingrese un número para verificar si es primo: ");
//             int numero = Convert.ToInt32(Console.ReadLine());

//             // Llamar a la función que verifica si el número es primo
//             bool esPrimo = EsPrimo(numero);

//             // Mostrar el resultado
//             if (esPrimo)
//             {
//                 Console.WriteLine($"{numero} es un número primo.");
//             }
//             else
//             {
//                 Console.WriteLine($"{numero} no es un número primo.");
//             }
//         }

//         // Función que determina si un número es primo
//         static bool EsPrimo(int numero)
//         {
//             // Los números menores que 2 no son primos
//             if (numero < 2)
//                 return false;

//             // Verificar divisibilidad desde 2 hasta la raíz cuadrada del número
//             for (int i = 2; i <= Math.Sqrt(numero); i++)
//             {
//                 if (numero % i == 0)
//                 {
//                     return false; // Si es divisible por 'i', no es primo
//                 }
//             }

//             return true; // Si no se encontró divisor, el número es primo
//         }
//     }
// }


//-----------------------------------------------------------------------------------------------------------------

// Código en ARM64 Assembly



//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o primo.o primo.s

// Vincular el archivo objeto
// ld -o primo primo.o

// Ejecutar el programa
//  ./primo

//---------------------------------------------------------------------------------------------------------------------------------------

// Enlace de asciinema






-




-
