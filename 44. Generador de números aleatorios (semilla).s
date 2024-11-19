//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

//using System;

//namespace GenerarNumerosAleatorios
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {
//            // Solicitar al usuario una semilla para los números aleatorios
//            Console.Write("Ingrese una semilla para los números aleatorios: ");
//            int semilla = Convert.ToInt32(Console.ReadLine());

//            // Crear una instancia de la clase Random usando la semilla
//            Random random = new Random(semilla);

//            // Generar y mostrar 5 números aleatorios entre 1 y 100
//            Console.WriteLine("Generando números aleatorios:");
//            for (int i = 0; i < 5; i++)
//            {
//                int numeroAleatorio = random.Next(1, 101); // Rango de 1 a 100
//                Console.WriteLine(numeroAleatorio);
//            }

//            // Esperar que el usuario presione una tecla antes de salir
//            Console.WriteLine("Presione cualquier tecla para salir...");
//            Console.ReadKey();
//        }
//    }
//}


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o alea.o alea.s

// Vincular el archivo objeto
// ld -o alea alea.o

// Ejecutar el programa
//  ./alea

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q alea

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------//
