//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace NumeroArmstrong
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese un número
//             Console.Write("Ingresa un número: ");
//             int numero = int.Parse(Console.ReadLine());

//             // Llamar a la función para verificar si es un número Armstrong
//             if (EsNumeroArmstrong(numero))
//             {
//                 Console.WriteLine($"{numero} es un número Armstrong.");
//             }
//             else
//             {
//                 Console.WriteLine($"{numero} no es un número Armstrong.");
//             }

//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         // Función para verificar si un número es un número Armstrong
//         static bool EsNumeroArmstrong(int numero)
//         {
//             // Convertir el número a una cadena para contar los dígitos
//             string numeroStr = numero.ToString();
//             int cantidadDigitos = numeroStr.Length;

//             int suma = 0;
//             int numeroOriginal = numero;

//             // Calcular la suma de los dígitos elevados a la potencia de la cantidad de dígitos
//             while (numero > 0)
//             {
//                 int digito = numero % 10; // Obtener el último dígito
//                 suma += (int)Math.Pow(digito, cantidadDigitos); // Elevar el dígito a la cantidad de dígitos
//                 numero /= 10; // Eliminar el último dígito
//             }

//             // Verificar si la suma es igual al número original
//             return suma == numeroOriginal;
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o arm.o arm.s

// Vincular el archivo objeto
// ld -o arm arm.o

// Ejecutar el programa
//  ./arm

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q arm

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------//
