//-------------------------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;

// namespace ColaConArreglo
// {
//     class Cola
//     {
//         private int[] cola;
//         private int frente;
//         private int final;
//         private int capacidad;
//         private int tamaño;

//         // Constructor de la cola
//         public Cola(int capacidad)
//         {
//             this.capacidad = capacidad;
//             cola = new int[capacidad];
//             frente = 0;
//             final = -1;
//             tamaño = 0;
//         }

//         // Agregar un elemento a la cola
//         public void Enqueue(int valor)
//         {
//             if (tamaño == capacidad)
//             {
//                 Console.WriteLine("La cola está llena. No se puede agregar el elemento.");
//                 return;
//             }

//             final = (final + 1) % capacidad;  // Circular, asegurando que se mantenga dentro del tamaño del arreglo
//             cola[final] = valor;
//             tamaño++;
//             Console.WriteLine($"Elemento {valor} agregado a la cola.");
//         }

//         // Eliminar el primer elemento de la cola
//         public void Dequeue()
//         {
//             if (tamaño == 0)
//             {
//                 Console.WriteLine("La cola está vacía. No se puede eliminar ningún elemento.");
//                 return;
//             }

//             int valorEliminado = cola[frente];
//             frente = (frente + 1) % capacidad; // Circular
//             tamaño--;
//             Console.WriteLine($"Elemento {valorEliminado} eliminado de la cola.");
//         }

//         // Ver el primer elemento de la cola sin eliminarlo
//         public void Peek()
//         {
//             if (tamaño == 0)
//             {
//                 Console.WriteLine("La cola está vacía.");
//                 return;
//             }

//             Console.WriteLine($"El primer elemento en la cola es: {cola[frente]}");
//         }

//         // Verificar si la cola está vacía
//         public bool EstaVacia()
//         {
//             return tamaño == 0;
//         }

//         // Verificar si la cola está llena
//         public bool EstaLlena()
//         {
//             return tamaño == capacidad;
//         }

//         // Mostrar los elementos de la cola
//         public void MostrarCola()
//         {
//             if (tamaño == 0)
//             {
//                 Console.WriteLine("La cola está vacía.");
//                 return;
//             }

//             Console.Write("Elementos en la cola: ");
//             for (int i = 0; i < tamaño; i++)
//             {
//                 Console.Write(cola[(frente + i) % capacidad] + " ");
//             }
//             Console.WriteLine();
//         }
//     }

//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Crear una cola con capacidad para 5 elementos
//             Cola miCola = new Cola(5);

//             // Operaciones sobre la cola
//             miCola.Enqueue(10);
//             miCola.Enqueue(20);
//             miCola.Enqueue(30);
//             miCola.Enqueue(40);
//             miCola.Enqueue(50);

//             // Intento de agregar un elemento cuando la cola está llena
//             miCola.Enqueue(60);

//             miCola.MostrarCola(); // Mostrar elementos en la cola

//             miCola.Dequeue(); // Eliminar el primer elemento
//             miCola.MostrarCola(); // Mostrar elementos después de la eliminación

//             miCola.Peek(); // Ver el primer elemento sin eliminarlo

//             miCola.Dequeue(); // Eliminar el primer elemento
//             miCola.Dequeue();
//             miCola.Dequeue();
//             miCola.Dequeue(); // Intento de eliminar cuando la cola está vacía

//             miCola.MostrarCola(); // Mostrar elementos cuando la cola está vacía
//         }
//     }
// }


//-------------------------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64



//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o pila.o pila.s

// Vincular el archivo objeto
// ld -o pila pila.o

// Ejecutar el programa
//  ./pila

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q pila

// start

// step

// q


//-------------------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema





//----------------------------------------------------------------------------------------------------------------------
