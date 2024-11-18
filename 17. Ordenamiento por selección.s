// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace OrdenamientoPorSeleccion
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario la cantidad de elementos
//             Console.Write("Ingrese la cantidad de elementos del arreglo: ");
//             int n = Convert.ToInt32(Console.ReadLine());
            
//             // Crear el arreglo
//             int[] arreglo = new int[n];
            
//             // Solicitar al usuario los elementos del arreglo
//             Console.WriteLine("Ingrese los elementos del arreglo:");
//             for (int i = 0; i < n; i++)
//             {
//                 Console.Write($"Elemento {i + 1}: ");
//                 arreglo[i] = Convert.ToInt32(Console.ReadLine());
//             }

//             // Mostrar el arreglo original
//             Console.WriteLine("\nArreglo original:");
//             MostrarArreglo(arreglo);

//             // Ordenar el arreglo utilizando el algoritmo de selección
//             OrdenamientoPorSeleccion(arreglo);

//             // Mostrar el arreglo ordenado
//             Console.WriteLine("\nArreglo ordenado:");
//             MostrarArreglo(arreglo);

//             // Esperar a que el usuario presione una tecla antes de salir
//             Console.WriteLine("\nPresione cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         // Método para implementar el ordenamiento por selección
//         static void OrdenamientoPorSeleccion(int[] arreglo)
//         {
//             int n = arreglo.Length;
//             for (int i = 0; i < n - 1; i++)
//             {
//                 // Encontrar el índice del menor elemento en el arreglo desde i hasta el final
//                 int indiceMenor = i;
//                 for (int j = i + 1; j < n; j++)
//                 {
//                     if (arreglo[j] < arreglo[indiceMenor])
//                     {
//                         indiceMenor = j;
//                     }
//                 }

//                 // Intercambiar el elemento actual con el menor encontrado
//                 if (indiceMenor != i)
//                 {
//                     int temp = arreglo[i];
//                     arreglo[i] = arreglo[indiceMenor];
//                     arreglo[indiceMenor] = temp;
//                 }
//             }
//         }

//         // Método para mostrar el contenido de un arreglo
//         static void MostrarArreglo(int[] arreglo)
//         {
//             foreach (int elemento in arreglo)
//             {
//                 Console.Write(elemento + " ");
//             }
//             Console.WriteLine();
//         }
//     }
// }

//-----------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
    msg_cantidad:    .asciz "Ingrese la cantidad de elementos del arreglo: "
    msg_elementos:   .asciz "Ingrese los elementos del arreglo:\n"
    msg_elemento:    .asciz "Elemento "
    msg_dos_puntos:  .asciz ": "
    msg_original:    .asciz "\nArreglo original:\n"
    msg_ordenado:    .asciz "\nArreglo ordenado:\n"
    msg_espacio:     .asciz " "
    msg_newline:     .asciz "\n"

.section .bss
    .align 4
    array:          .skip 400    // Espacio para 100 enteros (4 bytes cada uno)
    array_size:     .skip 4      // Tamaño del array
    buffer:         .skip 12     // Buffer para entrada/salida de números
    
.section .text
_start:
    // Imprimir mensaje para solicitar cantidad de elementos
    ldr x1, =msg_cantidad
    bl print_string

    // Leer cantidad de elementos
    ldr x1, =buffer
    bl read_input
    bl ascii_to_int
    
    // Validar que el tamaño sea positivo y menor que 100
    cmp w0, #0
    ble exit_program
    cmp w0, #100
    bgt exit_program
    
    // Guardar tamaño del array
    ldr x1, =array_size
    str w0, [x1]
    
    // Imprimir mensaje para ingresar elementos
    ldr x1, =msg_elementos
    bl print_string
    
    // Inicializar contador para lectura de elementos
    mov w21, w0           // w21 = tamaño del array
    mov w22, #0          // w22 = contador i

read_elements:
    // Verificar si hemos llegado al límite
    cmp w22, w21
    bge read_done        // Si contador >= tamaño, terminar lectura
    
    // Imprimir "Elemento X: "
    ldr x1, =msg_elemento
    bl print_string
    
    mov w0, w22
    add w0, w0, #1      // Mostrar número de elemento (1-based)
    ldr x1, =buffer
    bl int_to_ascii
    bl print_string
    
    ldr x1, =msg_dos_puntos
    bl print_string
    
    // Leer elemento
    ldr x1, =buffer
    bl read_input
    bl ascii_to_int
    
    // Guardar elemento en el array
    ldr x1, =array
    mov w2, w22
    lsl w2, w2, #2       // multiplicar por 4 (tamaño de int)
    add x1, x1, x2
    str w0, [x1]
    
    // Incrementar contador y continuar
    add w22, w22, #1
    b read_elements

read_done:
    // Mostrar array original
    ldr x1, =msg_original
    bl print_string
    bl print_array
    
    // Ordenar array
    bl selection_sort
    
    // Mostrar array ordenado
    ldr x1, =msg_ordenado
    bl print_string
    bl print_array
    
exit_program:
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc #0

// Función de ordenamiento por selección
selection_sort:
    stp x29, x30, [sp, #-16]!    // Guardar registros
    mov x29, sp
    
    ldr w21, array_size          // n = array_size
    mov w22, #0                  // i = 0
outer_loop:
    sub w23, w21, #1             // n-1
    cmp w22, w23                 // comparar i con n-1
    bge outer_loop_end
    
    mov w24, w22                 // min_idx = i
    add w25, w22, #1            // j = i + 1
inner_loop:
    cmp w25, w21                // comparar j con n
    bge inner_loop_end
    
    // Comparar array[j] con array[min_idx]
    ldr x1, =array
    lsl w2, w25, #2             // j * 4
    add x2, x1, x2
    ldr w2, [x2]                // w2 = array[j]
    
    lsl w3, w24, #2             // min_idx * 4
    add x3, x1, x3
    ldr w3, [x3]                // w3 = array[min_idx]
    
    cmp w2, w3
    bge skip_update_min
    mov w24, w25               // min_idx = j
skip_update_min:
    add w25, w25, #1          // j++
    b inner_loop
inner_loop_end:

    // Intercambiar elementos si es necesario
    cmp w24, w22              // comparar min_idx con i
    beq skip_swap
    
    ldr x1, =array
    lsl w2, w22, #2          // i * 4
    add x2, x1, x2
    lsl w3, w24, #2          // min_idx * 4
    add x3, x1, x3
    
    ldr w4, [x2]             // temp = array[i]
    ldr w5, [x3]             // array[min_idx]
    str w5, [x2]             // array[i] = array[min_idx]
    str w4, [x3]             // array[min_idx] = temp
    
skip_swap:
    add w22, w22, #1         // i++
    b outer_loop
outer_loop_end:
    ldp x29, x30, [sp], #16  // Restaurar registros
    ret

// Función para imprimir el array
print_array:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    ldr w21, array_size      // Cargar tamaño del array
    mov w22, #0              // índice = 0
print_loop:
    cmp w22, w21
    bge print_loop_end
    
    // Cargar elemento actual
    ldr x1, =array
    lsl w2, w22, #2          // índice * 4
    add x1, x1, x2
    ldr w0, [x1]
    
    // Convertir a ASCII y imprimir
    ldr x1, =buffer
    bl int_to_ascii
    bl print_string
    
    // Imprimir espacio
    ldr x1, =msg_espacio
    bl print_string
    
    add w22, w22, #1
    b print_loop
print_loop_end:
    // Imprimir nueva línea
    ldr x1, =msg_newline
    bl print_string
    
    ldp x29, x30, [sp], #16
    ret

// Función para convertir ASCII a entero
ascii_to_int:
    mov w2, #0                // resultado = 0
parse_loop:
    ldrb w3, [x1], #1         // Cargar siguiente byte
    cmp w3, #0x0A             // Verificar si es nueva línea
    beq parse_done
    cmp w3, #0x20             // Verificar si es espacio
    beq parse_done
    sub w3, w3, #0x30         // Convertir ASCII a número
    mov w4, #10
    mul w2, w2, w4            // resultado = resultado * 10
    add w2, w2, w3            // resultado = resultado + dígito
    b parse_loop
parse_done:
    mov w0, w2
    ret

// Función para convertir entero a ASCII
int_to_ascii:
    mov x2, x1                // Guardar dirección inicial
    mov x3, x1                // Puntero actual
    mov w4, #0                // Contador de dígitos
    
    // Manejar caso especial de 0
    cmp w0, #0
    bne not_zero
    mov w5, #0x30             // ASCII '0'
    strb w5, [x3]
    add x3, x3, #1
    mov w4, #1
    b int_to_ascii_end
    
not_zero:
    // Convertir dígitos
conv_loop:
    cmp w0, #0
    beq conv_done
    mov w5, #10
    udiv w6, w0, w5          // w6 = w0 / 10
    msub w5, w6, w5, w0      // w5 = w0 % 10
    add w5, w5, #0x30        // Convertir a ASCII
    strb w5, [x3]            // Guardar dígito
    add x3, x3, #1           // Siguiente posición
    add w4, w4, #1           // Incrementar contador
    mov w0, w6               // w0 = w0 / 10
    b conv_loop
    
conv_done:
    // Invertir string
    sub x3, x3, #1           // Último dígito
    mov x5, x2               // Primer dígito
reverse_loop:
    cmp x5, x3
    bhs int_to_ascii_end
    ldrb w6, [x5]
    ldrb w7, [x3]
    strb w7, [x5]
    strb w6, [x3]
    add x5, x5, #1
    sub x3, x3, #1
    b reverse_loop
    
int_to_ascii_end:
    add x3, x2, x4           // Fin del string
    mov w5, #0               // Null terminator
    strb w5, [x3]
    mov x0, x2               // Retornar dirección inicial
    ret

// Función para imprimir string
print_string:
    mov x2, #0               // Contador de longitud
str_len_loop:
    ldrb w3, [x1, x2]
    cbz w3, str_len_done
    add x2, x2, #1
    b str_len_loop
str_len_done:
    mov x0, #1               // stdout
    mov x8, #64              // syscall write
    svc #0
    ret

// Función para leer entrada
read_input:
    mov x0, #0               // stdin
    mov x2, #12              // máximo 12 bytes
    mov x8, #63              // syscall read
    svc #0
    ret

//-----------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o sel.o sel.s

// Vincular el archivo objeto
// ld -o sel sel.o

// Ejecutar el programa
//  ./sel

//-----------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q sel

// start

// step

// q


//---------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/Ucom1H1WdPrfiIIht7RwG5HlX



-
