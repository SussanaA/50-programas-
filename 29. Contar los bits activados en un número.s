//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;

// class Program
// {
//     static void Main(string[] args)
//     {
//         // Solicitar al usuario que ingrese un número
//         Console.Write("Ingrese un número: ");
//         int numero = int.Parse(Console.ReadLine());

//         // Contar los bits activados
//         int bitsActivados = ContarBitsActivados(numero);

//         // Mostrar el resultado
//         Console.WriteLine($"El número de bits activados (1's) en {numero} es: {bitsActivados}");
//     }

//     // Método para contar los bits activados de un número
//     static int ContarBitsActivados(int numero)
//     {
//         int cuenta = 0;

//         // Usar un loop para revisar cada bit
//         while (numero != 0)
//         {
//             // Incrementar el contador si el bit más bajo está activado (1)
//             cuenta += numero & 1;

//             // Desplazar los bits a la derecha
//             numero >>= 1;
//         }

//         return cuenta;
//     }
// }

//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o cbi.o cbi.s

// Vincular el archivo objeto
// ld -o cbi cbi.o

// Ejecutar el programa
//  ./cbi

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q cbi

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------
