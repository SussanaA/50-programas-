// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#
// using System;

// namespace BusquedaBinaria
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Definir el arreglo ordenado
//             int[] numeros = { 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 };
            
//             Console.WriteLine("Arreglo ordenado: " + string.Join(", ", numeros));

//             // Solicitar al usuario el número a buscar
//             Console.Write("Ingresa el número que deseas buscar: ");
//             int objetivo = Convert.ToInt32(Console.ReadLine());

//             // Realizar la búsqueda binaria
//             int posicion = BusquedaBinaria(numeros, objetivo);

//             // Mostrar el resultado
//             if (posicion != -1)
//             {
//                 Console.WriteLine($"El número {objetivo} se encuentra en la posición {posicion} del arreglo.");
//             }
//             else
//             {
//                 Console.WriteLine($"El número {objetivo} no está presente en el arreglo.");
//             }

//             // Finalizar
//             Console.WriteLine("Presiona cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         /// <summary>
//         /// Realiza una búsqueda binaria en un arreglo ordenado.
//         /// </summary>
//         /// <param name="arreglo">El arreglo ordenado donde buscar.</param>
//         /// <param name="objetivo">El número a buscar.</param>
//         /// <returns>La posición del número en el arreglo, o -1 si no se encuentra.</returns>
//         static int BusquedaBinaria(int[] arreglo, int objetivo)
//         {
//             int inicio = 0;
//             int fin = arreglo.Length - 1;

//             while (inicio <= fin)
//             {
//                 int medio = inicio + (fin - inicio) / 2; // Evitar desbordamiento

//                 if (arreglo[medio] == objetivo)
//                 {
//                     return medio; // Número encontrado
//                 }

//                 if (arreglo[medio] < objetivo)
//                 {
//                     inicio = medio + 1; // Buscar en la mitad derecha
//                 }
//                 else
//                 {
//                     fin = medio - 1; // Buscar en la mitad izquierda
//                 }
//             }

//             return -1; // Número no encontrado
//         }
//     }
// }


//-------------------------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
    // Mensajes del programa
    msg_array:    .asciz "Arreglo ordenado: "
    msg_input:    .asciz "Ingresa el número que deseas buscar: "
    msg_found:    .asciz "El número se encuentra en la posición "
    msg_notfound: .asciz "El número no está presente en el arreglo.\n"
    newline:      .asciz "\n"
    comma:        .asciz ", "
    
    // Arreglo ordenado predefinido
    .align 4
    array:        .word 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
    array_size:   .word 10

.section .bss
    input_buffer: .skip 12
    number:       .skip 4
    result:       .skip 4
    str_buffer:   .skip 12

.section .text
_start:
    // Imprimir mensaje inicial
    ldr x1, =msg_array
    bl print_string

    // Imprimir el arreglo
    bl print_array

    // Imprimir nueva línea
    ldr x1, =newline
    bl print_string

    // Solicitar número a buscar
    ldr x1, =msg_input
    bl print_string

    // Leer entrada del usuario
    mov x0, 0              // stdin
    ldr x1, =input_buffer
    mov x2, 12             // tamaño máximo
    bl read_input
    
    // Convertir entrada a número
    ldr x1, =input_buffer
    bl ascii_to_int
    ldr x1, =number
    str w0, [x1]           // Guardar número a buscar

    // Preparar parámetros para búsqueda binaria
    ldr x0, =array         // dirección del arreglo
    ldr w1, number         // número a buscar
    ldr w2, array_size     // tamaño del arreglo
    bl binary_search       // llamar a búsqueda binaria

    // Guardar resultado
    ldr x1, =result
    str w0, [x1]

    // Verificar si se encontró (-1 significa no encontrado)
    cmp w0, #-1
    beq not_found

found:
    // Imprimir mensaje de éxito
    ldr x1, =msg_found
    bl print_string
    
    // Convertir posición a string y mostrar
    ldr w0, result
    ldr x1, =str_buffer
    bl int_to_ascii
    bl print_string
    
    ldr x1, =newline
    bl print_string
    b exit

not_found:
    // Imprimir mensaje de no encontrado
    ldr x1, =msg_notfound
    bl print_string

exit:
    mov x0, 0
    mov x8, 93
    svc 0

// Función de búsqueda binaria
// x0: dirección del arreglo
// w1: número a buscar
// w2: tamaño del arreglo
// Retorna: w0 = posición o -1 si no se encuentra
binary_search:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    // Inicializar variables
    mov w3, #0          // inicio = 0
    sub w4, w2, #1      // fin = tamaño - 1
    
search_loop:
    // Verificar si inicio <= fin
    cmp w3, w4
    bgt not_found_bs
    
    // Calcular medio = inicio + (fin - inicio) / 2
    sub w5, w4, w3      // fin - inicio
    lsr w5, w5, #1      // dividir por 2
    add w5, w5, w3      // inicio + (fin - inicio)/2
    
    // Cargar array[medio]
    lsl w6, w5, #2      // multiplicar por 4 (tamaño de word)
    add x6, x0, x6      // dirección de array[medio]
    ldr w7, [x6]        // w7 = array[medio]
    
    // Comparar con objetivo
    cmp w7, w1
    beq found_bs        // si son iguales, encontrado
    blt greater_bs      // si array[medio] < objetivo
    
    // array[medio] > objetivo
    sub w4, w5, #1      // fin = medio - 1
    b search_loop
    
greater_bs:
    add w3, w5, #1      // inicio = medio + 1
    b search_loop
    
found_bs:
    mov w0, w5          // retornar posición
    b end_binary_search
    
not_found_bs:
    mov w0, #-1         // retornar -1
    
end_binary_search:
    // Restaurar registros y retornar
    ldp x29, x30, [sp], #16
    ret

// Función para imprimir el arreglo
print_array:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    
    mov x19, #0                 // índice
    ldr x20, =array            // dirección del arreglo
    ldr w21, array_size        // tamaño
    
print_loop:
    cmp x19, x21
    beq end_print_array
    
    // Cargar y convertir número actual
    ldr w0, [x20, x19, lsl #2]
    ldr x1, =str_buffer
    bl int_to_ascii
    bl print_string
    
    // Imprimir coma si no es el último elemento
    add x19, x19, #1
    cmp x19, x21
    beq end_print_array
    
    ldr x1, =comma
    bl print_string
    
    b print_loop
    
end_print_array:
    ldp x29, x30, [sp], #16
    ret

// Función para convertir ASCII a entero (como en ejemplos anteriores)
ascii_to_int:
    mov w2, #0
parse_loop:
    ldrb w3, [x1], #1
    subs w3, w3, #'0'
    blt parse_done
    mov w6, #10
    mul w2, w2, w6
    add w2, w2, w3
    b parse_loop
parse_done:
    mov w0, w2
    ret

// Función para convertir entero a ASCII
int_to_ascii:
    mov x2, x1
    add x1, x1, #10
    mov w3, #10
convert_loop:
    udiv w4, w0, w3
    msub w5, w4, w3, w0
    add w5, w5, #'0'
    sub x1, x1, #1
    strb w5, [x1]
    mov w0, w4
    cbnz w0, convert_loop
    mov x0, x2
    ret

// Función para imprimir string
print_string:
    mov x2, #0
find_null:
    ldrb w3, [x1, x2]
    cbz w3, print_str
    add x2, x2, #1
    b find_null
print_str:
    mov x0, #1
    mov x8, #64
    svc #0
    ret

// Función para leer input
read_input:
    mov x8, #63
    svc #0
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o bin.o bin.s

// Vincular el archivo objeto
// ld -o bin bin.o

// Ejecutar el programa
//  ./bin

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q bin

// start

// step

// q


//-------------------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/rvVfiTAwJHlVbbLGoAH8A09WO



-
