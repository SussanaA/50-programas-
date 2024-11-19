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

.global _start

.section .data
msg1:       .ascii "Operaciones con la pila:\n"
len1 = . - msg1
msg_push:   .ascii "Push: "
len_push = . - msg_push
msg_pop:    .ascii "Pop: "
len_pop = . - msg_pop
msg_peek:   .ascii "Peek: "
len_peek = . - msg_peek
msg_empty:  .ascii "La pila está vacía\n"
len_empty = . - msg_empty
msg_full:   .ascii "La pila está llena\n"
len_full = . - msg_full
stack:      .skip 80            // Espacio para 10 números de 64 bits
stack_size: .quad 10            // Tamaño máximo de la pila
top:        .quad 0             // Índice del tope de la pila
buffer:     .skip 32            // Buffer para conversión de números
newline:    .ascii "\n"
space:      .ascii " "

.section .text
_start:
    // Mostrar mensaje inicial
    mov x0, #1
    ldr x1, =msg1
    mov x2, len1
    mov x8, #64
    svc #0

    // Push: 5
    mov x0, #5
    bl push
    
    // Push: 10
    mov x0, #10
    bl push
    
    // Push: 15
    mov x0, #15
    bl push

    // Mostrar peek
    bl peek
    
    // Pop
    bl pop
    
    // Peek de nuevo
    bl peek

exit:
    mov x0, #0
    mov x8, #93
    svc #0

// Función push: añade un elemento a la pila
push:
    str x30, [sp, #-16]!        // Guardar enlace retorno
    
    // Verificar si la pila está llena
    ldr x9, =top
    ldr x10, [x9]               // Cargar tope actual
    ldr x11, =stack_size
    ldr x11, [x11]              // Cargar tamaño máximo
    
    cmp x10, x11
    bge pila_llena
    
    // Mostrar mensaje push
    mov x19, x0                 // Guardar valor a insertar
    mov x0, #1
    ldr x1, =msg_push
    mov x2, len_push
    mov x8, #64
    svc #0
    
    // Mostrar número
    mov x21, x19
    bl mostrar_numero
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0
    
    // Insertar elemento
    ldr x12, =stack            // Dirección base de la pila
    str x19, [x12, x10, lsl #3] // Guardar elemento
    add x10, x10, #1           // Incrementar tope
    str x10, [x9]              // Actualizar tope
    
    ldr x30, [sp], #16
    ret

pila_llena:
    mov x0, #1
    ldr x1, =msg_full
    mov x2, len_full
    mov x8, #64
    svc #0
    
    ldr x30, [sp], #16
    ret

// Función pop: elimina y retorna el elemento superior
pop:
    str x30, [sp, #-16]!
    
    // Verificar si la pila está vacía
    ldr x9, =top
    ldr x10, [x9]
    cbz x10, pila_vacia
    
    // Mostrar mensaje pop
    mov x0, #1
    ldr x1, =msg_pop
    mov x2, len_pop
    mov x8, #64
    svc #0
    
    // Obtener elemento superior
    sub x10, x10, #1           // Decrementar tope
    str x10, [x9]              // Actualizar tope
    ldr x11, =stack
    ldr x21, [x11, x10, lsl #3] // Cargar elemento
    bl mostrar_numero
    
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0
    
    ldr x30, [sp], #16
    ret

pila_vacia:
    mov x0, #1
    ldr x1, =msg_empty
    mov x2, len_empty
    mov x8, #64
    svc #0
    
    ldr x30, [sp], #16
    ret

// Función peek: muestra el elemento superior sin eliminarlo
peek:
    str x30, [sp, #-16]!
    
    // Verificar si la pila está vacía
    ldr x9, =top
    ldr x10, [x9]
    cbz x10, pila_vacia
    
    // Mostrar mensaje peek
    mov x0, #1
    ldr x1, =msg_peek
    mov x2, len_peek
    mov x8, #64
    svc #0
    
    // Mostrar elemento superior
    sub x10, x10, #1
    ldr x11, =stack
    ldr x21, [x11, x10, lsl #3]
    bl mostrar_numero
    
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0
    
    ldr x30, [sp], #16
    ret

// Función auxiliar para mostrar números
mostrar_numero:
    str x30, [sp, #-16]!
    
    mov x22, x21               // Copia del número
    ldr x23, =buffer          // Buffer para dígitos
    mov x24, #0               // Contador de dígitos

convertir_loop:
    mov x25, #10
    udiv x26, x22, x25        // Dividir por 10
    msub x27, x26, x25, x22   // Obtener resto
    add x27, x27, #'0'        // Convertir a ASCII
    strb w27, [x23, x24]      // Guardar dígito
    add x24, x24, #1          // Incrementar contador
    mov x22, x26              // Actualizar número
    cbnz x22, convertir_loop
    
    // Invertir dígitos
    mov x25, #0               // Inicio
    sub x26, x24, #1          // Fin

invertir_loop:
    cmp x25, x26
    bge imprimir_numero
    ldrb w27, [x23, x25]      // Cargar byte inicio
    ldrb w28, [x23, x26]      // Cargar byte fin
    strb w28, [x23, x25]      // Guardar fin en inicio
    strb w27, [x23, x26]      // Guardar inicio en fin
    add x25, x25, #1
    sub x26, x26, #1
    b invertir_loop

imprimir_numero:
    mov x0, #1
    mov x1, x23               // Buffer
    mov x2, x24               // Longitud
    mov x8, #64
    svc #0
    
    ldr x30, [sp], #16
    ret

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

https://asciinema.org/a/A8dHRh8Soso8MjXG5qsL0e2IN



//----------------------------------------------------------------------------------------------------------------------
