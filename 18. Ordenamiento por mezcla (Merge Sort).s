// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#

// using System;
// 
// namespace OrdenamientoPorMezcla
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario el tamaño del arreglo
//             Console.Write("Ingrese el tamaño del arreglo: ");
//             int n = Convert.ToInt32(Console.ReadLine());
// 
//             int[] arreglo = new int[n];
// 
//             // Solicitar los elementos del arreglo
//             Console.WriteLine("Ingrese los elementos del arreglo:");
//             for (int i = 0; i < n; i++)
//             {
//                 Console.Write($"Elemento {i + 1}: ");
//                 arreglo[i] = Convert.ToInt32(Console.ReadLine());
//             }
// 
//             Console.WriteLine("\nArreglo original:");
//             MostrarArreglo(arreglo);
// 
//             // Ordenar el arreglo usando Merge Sort
//             MergeSort(arreglo, 0, arreglo.Length - 1);
// 
//             Console.WriteLine("\nArreglo ordenado:");
//             MostrarArreglo(arreglo);
// 
//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("\nPresione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
// 
//         // Método para realizar el Merge Sort
//         static void MergeSort(int[] arreglo, int inicio, int fin)
//         {
//             if (inicio < fin)
//             {
//                 int medio = (inicio + fin) / 2;
// 
//                 // Dividir y ordenar las mitades
//                 MergeSort(arreglo, inicio, medio);
//                 MergeSort(arreglo, medio + 1, fin);
// 
//                 // Combinar las mitades ordenadas
//                 Mezclar(arreglo, inicio, medio, fin);
//             }
//         }
// 
//         // Método para combinar dos mitades ordenadas
//         static void Mezclar(int[] arreglo, int inicio, int medio, int fin)
//         {
//             int n1 = medio - inicio + 1;
//             int n2 = fin - medio;
// 
//             // Crear arreglos temporales
//             int[] izquierda = new int[n1];
//             int[] derecha = new int[n2];
// 
//             // Copiar los datos a los arreglos temporales
//             for (int i = 0; i < n1; i++)
//                 izquierda[i] = arreglo[inicio + i];
//             for (int j = 0; j < n2; j++)
//                 derecha[j] = arreglo[medio + 1 + j];
// 
//             // Combinar los arreglos temporales de nuevo en el original
//             int iL = 0, iR = 0;
//             int k = inicio;
// 
//             while (iL < n1 && iR < n2)
//             {
//                 if (izquierda[iL] <= derecha[iR])
//                 {
//                     arreglo[k] = izquierda[iL];
//                     iL++;
//                 }
//                 else
//                 {
//                     arreglo[k] = derecha[iR];
//                     iR++;
//                 }
//                 k++;
//             }
// 
//             // Copiar los elementos restantes de la izquierda (si los hay)
//            


//-------------------------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

// Sección de datos
.section .data
    msg_size:        .asciz "Ingrese el tamaño del arreglo: "
    msg_element:     .asciz "Elemento "
    msg_colon:       .asciz ": "
    msg_original:    .asciz "\nArreglo original:\n"
    msg_sorted:      .asciz "\nArreglo ordenado:\n"
    msg_space:       .asciz " "
    msg_newline:     .asciz "\n"
    
// Sección BSS para variables no inicializadas
.section .bss
    .align 4
    array:          .skip 400    // Espacio para 100 enteros (4 bytes cada uno)
    temp_array:     .skip 400    // Array temporal para el merge
    array_size:     .skip 4      // Tamaño del array
    input_buffer:   .skip 12     // Buffer para entrada
    
.section .text
_start:
    // Imprimir mensaje para tamaño del array
    ldr x1, =msg_size
    bl print_string
    
    // Leer tamaño del array
    bl read_int
    ldr x1, =array_size
    str w0, [x1]                 // Guardar tamaño en array_size
    
    // Inicializar x19 como contador = 0
    mov x19, xzr
    
input_loop:
    // Verificar si hemos terminado de leer
    ldr x1, =array_size
    ldr w0, [x1]                 // Cargar array_size
    sxtw x0, w0                  // Extender w0 a 64 bits
    cmp x19, x0                  // Comparar contador con tamaño
    bge input_done               // Si contador >= tamaño, terminar
    
    // Imprimir "Elemento X: "
    ldr x1, =msg_element
    bl print_string
    mov x0, x19
    add x0, x0, #1              // Elemento número (1-based)
    bl print_int
    ldr x1, =msg_colon
    bl print_string
    
    // Leer elemento
    bl read_int
    ldr x1, =array
    str w0, [x1, x19, lsl #2]   // Guardar en array[i]
    
    add x19, x19, #1            // Incrementar contador
    b input_loop
    
input_done:
    // Imprimir arreglo original
    ldr x1, =msg_original
    bl print_string
    bl print_array
    
    // Llamar a merge_sort
    mov x0, xzr                 // inicio = 0
    ldr x2, =array_size
    ldr w2, [x2]
    sub x2, x2, #1             // fin = size - 1
    bl merge_sort
    
    // Imprimir arreglo ordenado
    ldr x1, =msg_sorted
    bl print_string
    bl print_array
    
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc #0

// Función merge_sort(int[] arr, int inicio, int fin)
merge_sort:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    
    // if (inicio >= fin) return
    cmp x0, x2
    bge merge_sort_done
    
    // medio = (inicio + fin) / 2
    add x1, x0, x2
    lsr x1, x1, #1              // x1 = medio
    
    // Guardar parámetros
    mov x19, x0                 // inicio
    mov x20, x2                 // fin
    mov x21, x1                 // medio
    
    // merge_sort(arr, inicio, medio)
    mov x2, x1
    bl merge_sort
    
    // merge_sort(arr, medio + 1, fin)
    mov x0, x21
    add x0, x0, #1
    mov x2, x20
    bl merge_sort
    
    // merge(arr, inicio, medio, fin)
    mov x0, x19                 // inicio
    mov x1, x21                 // medio
    mov x2, x20                 // fin
    bl merge
    
merge_sort_done:
    // Restaurar registros
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función merge
merge:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!
    
    // Guardar parámetros
    mov x19, x0                 // inicio
    mov x20, x1                 // medio
    mov x21, x2                 // fin
    
    // Calcular tamaños
    sub x22, x20, x19          // n1 = medio - inicio
    add x22, x22, #1
    sub x23, x21, x20          // n2 = fin - medio
    
    // Copiar a array temporal
    mov x24, xzr               // índice para temp_array
    mov x0, x19                // índice para array original
    
copy_first_half:
    cmp x24, x22
    bge copy_second_half_init
    ldr x1, =array
    ldr w2, [x1, x0, lsl #2]
    ldr x1, =temp_array
    str w2, [x1, x24, lsl #2]
    add x24, x24, #1
    add x0, x0, #1
    b copy_first_half
    
copy_second_half_init:
    mov x0, x20
    add x0, x0, #1              // medio + 1
    
copy_second_half:
    cmp x24, x22
    sub x3, x24, x22
    cmp x3, x23
    bge merge_halves_init
    ldr x1, =array
    ldr w2, [x1, x0, lsl #2]
    ldr x1, =temp_array
    str w2, [x1, x24, lsl #2]
    add x24, x24, #1
    add x0, x0, #1
    b copy_second_half
    
merge_halves_init:
    mov x0, xzr                // índice para primera mitad
    mov x1, x22                // índice para segunda mitad
    mov x2, x19                // índice para array original
    
merge_halves:
    cmp x0, x22
    bge copy_remaining_first
    sub x3, x24, x22
    cmp x1, x24
    bge copy_remaining_first
    
    ldr x3, =temp_array
    ldr w4, [x3, x0, lsl #2]
    ldr w5, [x3, x1, lsl #2]
    cmp w4, w5
    bgt copy_from_second
    
    // Copiar de primera mitad
    ldr x3, =array
    str w4, [x3, x2, lsl #2]
    add x0, x0, #1
    add x2, x2, #1
    b merge_halves
    
copy_from_second:
    ldr x3, =array
    str w5, [x3, x2, lsl #2]
    add x1, x1, #1
    add x2, x2, #1
    b merge_halves
    
copy_remaining_first:
    cmp x0, x22
    bge copy_remaining_second
    ldr x3, =temp_array
    ldr w4, [x3, x0, lsl #2]
    ldr x3, =array
    str w4, [x3, x2, lsl #2]
    add x0, x0, #1
    add x2, x2, #1
    b copy_remaining_first
    
copy_remaining_second:
    cmp x1, x24
    bge merge_done
    ldr x3, =temp_array
    ldr w4, [x3, x1, lsl #2]
    ldr x3, =array
    str w4, [x3, x2, lsl #2]
    add x1, x1, #1
    add x2, x2, #1
    b copy_remaining_second
    
merge_done:
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función para imprimir el array
print_array:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    
    mov x19, xzr               // i = 0
    ldr x20, =array_size
    ldr w20, [x20]             // size
    
print_loop:
    cmp x19, x20
    bge print_array_done
    
    ldr x0, =array
    ldr w0, [x0, x19, lsl #2]
    bl print_int
    
    ldr x1, =msg_space
    bl print_string
    
    add x19, x19, #1
    b print_loop
    
print_array_done:
    ldr x1, =msg_newline
    bl print_string
    
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función para leer un entero
read_int:
    stp x29, x30, [sp, #-16]!
    
    // Leer entrada
    mov x0, #0                  // stdin
    ldr x1, =input_buffer
    mov x2, #12                 // tamaño máximo
    mov x8, #63                 // sys_read
    svc #0
    
    // Limpiar buffer después de lectura
    mov x4, x0                  // guardar número de bytes leídos
    ldr x1, =input_buffer
    add x1, x1, x4             // ir al final de los datos leídos
    mov w2, #0
    strb w2, [x1]              // añadir null terminator
    
    // Convertir ASCII a entero
    ldr x1, =input_buffer
    mov w0, #0                  // resultado
    mov w2, #10                 // base 10
    
convert_loop:
    ldrb w3, [x1], #1          // cargar siguiente byte
    cmp w3, #'\n'              // verificar fin de línea
    beq read_int_done
    cmp w3, #'0'               // verificar si es dígito
    blt read_int_done
    cmp w3, #'9'
    bgt read_int_done
    
    sub w3, w3, #'0'           // convertir a número
    mul w0, w0, w2             // resultado *= 10
    add w0, w0, w3             // resultado += dígito
    b convert_loop
    
read_int_done:
    ldp x29, x30, [sp], #16
    ret

// Función para imprimir un entero
print_int:
    stp x29, x30, [sp, #-16]!
    
    // Convertir entero a ASCII
    mov x2, xzr                // contador de dígitos
    mov x3, #10                // divisor
    
    // Si el número es 0, imprimir directamente
    cmp w0, #0
    bne convert_to_ascii
    
    mov w4, #'0'
    ldr x1, =input_buffer
    strb w4, [x1]
    mov x2, #1
    b print_digits
    
convert_to_ascii:
    // Convertir dígitos
    ldr x1, =input_buffer
convert_digit:
    udiv w4, w0, w3            // w4 = n / 10
    msub w5, w4, w3, w0        // w5 = n % 10
    add w5, w5, #'0'           // convertir a ASCII
    strb w5, [x1, x2]          // guardar dígito
    add x2, x2, #1             // incrementar contador
    mov w0, w4                 // n = n / 10
    cbnz w0, convert_digit     // continuar si n > 0
    
    // Invertir dígitos
    ldr x1, =input_buffer
    mov x3, xzr                // inicio
    sub x4, x2, #1             // fin
    
reverse_loop:
    cmp x3, x4
    bge print_digits
    ldrb w5, [x1, x3]          // temp = str[i]
    ldrb w6, [x1, x4]          // str[i] = str[j]
    strb w6, [x1, x3]
    strb w5, [x1, x4]          // str[j] = temp
    add x3, x3, #1
    sub x4, x4, #1
    b reverse_loop
    
print_digits:
    mov x0, #1                  // stdout
    ldr x1, =input_buffer      // buffer
    mov x8, #64                // sys_write
    svc #0
    
    ldp x29, x30, [sp], #16
    ret

// Función para imprimir una cadena
print_string:
    stp x29, x30, [sp, #-16]!
    
    // Calcular longitud de la cadena
    mov x2, xzr
strlen_loop:
    ldrb w0, [x1, x2]
    cbz w0, print_str
    add x2, x2, #1
    b strlen_loop
    
print_str:
    mov x0, #1                  // stdout
    mov x8, #64                // sys_write
    svc #0
    
    ldp x29, x30, [sp], #16
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o merg.o merg.s

// Vincular el archivo objeto
// ld -o merg merg.o

// Ejecutar el programa
//  ./bin

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q merg

// start

// step

// q


//-------------------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/i2bbnpIlfTyNf9vBB7YmFe2GW



-
