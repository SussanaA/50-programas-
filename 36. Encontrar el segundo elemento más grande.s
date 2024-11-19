//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace SegundoElementoMasGrande
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Definir un arreglo de números
//             int[] numeros = { 3, 5, 7, 2, 8, 6, 1 };

//             // Llamar al método para encontrar el segundo elemento más grande
//             int segundoMasGrande = EncontrarSegundoMasGrande(numeros);

//             // Mostrar el resultado
//             Console.WriteLine("El segundo elemento más grande es: " + segundoMasGrande);

//             // Esperar a que el usuario presione una tecla para cerrar
//             Console.ReadKey();
//         }

//         static int EncontrarSegundoMasGrande(int[] arreglo)
//         {
//             if (arreglo.Length < 2)
//             {
//                 throw new InvalidOperationException("El arreglo debe contener al menos dos elementos.");
//             }

//             // Inicializar los dos números más grandes
//             int primeroMasGrande = int.MinValue;
//             int segundoMasGrande = int.MinValue;

//             // Recorrer el arreglo para encontrar el segundo más grande
//             foreach (int numero in arreglo)
//             {
//                 if (numero > primeroMasGrande)
//                 {
//                     // Si encontramos un número más grande, el actual más grande pasa a segundo más grande
//                     segundoMasGrande = primeroMasGrande;
//                     primeroMasGrande = numero;
//                 }
//                 else if (numero > segundoMasGrande && numero != primeroMasGrande)
//                 {
//                     // Si el número no es igual al más grande y es mayor que el segundo más grande
//                     segundoMasGrande = numero;
//                 }
//             }

//             return segundoMasGrande;
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o seg.o seg.s

// Vincular el archivo objeto
// ld -o seg seg.o

// Ejecutar el programa
//  ./seg

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q seg

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------//
