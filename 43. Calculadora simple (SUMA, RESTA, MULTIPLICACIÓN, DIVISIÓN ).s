//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace Calculadora
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             double num1, num2, resultado;
//             string operacion;

//             // Mostrar opciones al usuario
//             Console.WriteLine("Calculadora simple");
//             Console.WriteLine("Elija una operación:");
//             Console.WriteLine("1. Sumar");
//             Console.WriteLine("2. Restar");
//             Console.WriteLine("3. Multiplicar");
//             Console.WriteLine("4. Dividir");
//             Console.Write("Opción (1/2/3/4): ");
//             operacion = Console.ReadLine();

//             // Solicitar los números
//             Console.Write("Ingrese el primer número: ");
//             num1 = Convert.ToDouble(Console.ReadLine());

//             Console.Write("Ingrese el segundo número: ");
//             num2 = Convert.ToDouble(Console.ReadLine());

//             // Realizar la operación seleccionada
//             switch (operacion)
//             {
//                 case "1":
//                     resultado = num1 + num2;
//                     Console.WriteLine($"El resultado de la suma es: {resultado}");
//                     break;

//                 case "2":
//                     resultado = num1 - num2;
//                     Console.WriteLine($"El resultado de la resta es: {resultado}");
//                     break;

//                 case "3":
//                     resultado = num1 * num2;
//                     Console.WriteLine($"El resultado de la multiplicación es: {resultado}");
//                     break;

//                 case "4":
//                     if (num2 != 0)
//                     {
//                         resultado = num1 / num2;
//                         Console.WriteLine($"El resultado de la división es: {resultado}");
//                     }
//                     else
//                     {
//                         Console.WriteLine("Error: No se puede dividir entre cero.");
//                     }
//                     break;

//                 default:
//                     Console.WriteLine("Opción no válida.");
//                     break;
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
// as -o cal.o cal.s

// Vincular el archivo objeto
// ld -o cal cal.o

// Ejecutar el programa
//  ./cal

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q cal

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------//
