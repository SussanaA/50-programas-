//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace MaximoComunDivisor
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             Console.WriteLine("Programa para calcular el Máximo Común Divisor (MCD)");

//             // Solicitar el primer número
//             Console.Write("Ingrese el primer número: ");
//             int numero1 = Convert.ToInt32(Console.ReadLine());

//             // Solicitar el segundo número
//             Console.Write("Ingrese el segundo número: ");
//             int numero2 = Convert.ToInt32(Console.ReadLine());

//             // Calcular el MCD utilizando el algoritmo de Euclides
//             int mcd = CalcularMCD(numero1, numero2);

//             // Mostrar el resultado
//             Console.WriteLine($"El MCD de {numero1} y {numero2} es: {mcd}");

//             // Esperar a que el usuario presione una tecla antes de cerrar
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         /// <summary>
//         /// Calcula el Máximo Común Divisor (MCD) usando el algoritmo de Euclides.
//         /// </summary>
//         /// <param name="a">Primer número</param>
//         /// <param name="b">Segundo número</param>
//         /// <returns>MCD de los dos números</returns>
//         static int CalcularMCD(int a, int b)
//         {
//             // Asegurarse de que ambos números sean positivos
//             a = Math.Abs(a);
//             b = Math.Abs(b);

//             // Algoritmo de Euclides
//             while (b != 0)
//             {
//                 int temp = b;
//                 b = a % b; // Resto
//                 a = temp;  // Actualizar
//             }
//             return a; // Cuando b es 0, a contiene el MCD
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o mcd.o mcd.s

// Vincular el archivo objeto
// ld -o mcd mcd.o

// Ejecutar el programa
//  ./mcd

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q mcd

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------
