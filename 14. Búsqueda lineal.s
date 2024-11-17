// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#

// using System;
//
// namespace BusquedaLineal
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Definir el arreglo de ejemplo
//             int[] numeros = { 5, 8, 12, 3, 7, 14, 9, 10 };
//
//             // Mostrar el arreglo al usuario
//             Console.WriteLine("Arreglo: " + string.Join(", ", numeros));
//
//             // Solicitar el número a buscar
//             Console.Write("Ingresa el número que deseas buscar: ");
//             int numeroBuscado = int.Parse(Console.ReadLine());
//
//             // Llamar a la función de búsqueda lineal
//             int posicion = BusquedaLineal(numeros, numeroBuscado);
//
//             // Mostrar el resultado
//             if (posicion != -1)
//             {
//                 Console.WriteLine($"El número {numeroBuscado} se encuentra en la posición {posicion} del arreglo.");
//             }
//             else
//             {
//                 Console.WriteLine($"El número {numeroBuscado} no se encuentra en el arreglo.");
//             }
//
//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("Presiona cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//
//         // Función de búsqueda lineal
//         static int BusquedaLineal(int[] arreglo, int elemento)
//         {
//             for (int i = 0; i < arreglo.Length; i++)
//             {
//                 if (arreglo[i] == elemento)
//                 {
//                     return i; // Devuelve la posición si se encuentra el elemento
//                 }
//             }
//             return -1; // Devuelve -1 si el elemento no se encuentra
//         }
//     }
// }

//-----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
    // Arreglo de números (8 elementos)
    array:      .word   5, 8, 12, 3, 7, 14, 9, 10
    array_len = (. - array) / 4

    // Mensajes
    msg_array:  .asciz "Arreglo: "
    msg_input:  .asciz "\nIngresa el número que deseas buscar: "
    msg_found:  .asciz "\nEl número "
    msg_pos:    .asciz " se encuentra en la posición "
    msg_notfound: .asciz "\nEl número "
    msg_notfound2: .asciz " no se encuentra en el arreglo.\n"
    comma:      .asciz ", "
    newline:    .asciz "\n"

.section .bss
    search_num: .skip 4     // Número a buscar
    buffer:     .skip 12    // Buffer para conversión de números
    input_buffer: .skip 12  // Buffer para entrada

.section .text
_start:
    // Mostrar mensaje inicial "Arreglo: "
    ldr x1, =msg_array
    bl print_string

    // Imprimir el arreglo
    mov x19, #0            // Índice del array
print_array_loop:
    cmp x19, array_len
    beq print_array_done
    
    // Cargar y convertir número actual
    ldr x1, =array
    lsl x20, x19, #2      // Multiplicar índice por 4 (tamaño de word)
    add x1, x1, x20
    ldr w0, [x1]
    
    // Convertir a string y imprimir
    ldr x1, =buffer
    bl int_to_ascii
    mov x1, x1
    bl print_string
    
    // Imprimir coma si no es el último elemento
    add x19, x19, #1
    cmp x19, array_len
    beq print_array_done
    ldr x1, =comma
    bl print_string
    
    b print_array_loop
print_array_done:

    // Solicitar número a buscar
    ldr x1, =msg_input
    bl print_string

    // Leer entrada del usuario
    mov x0, #0            // stdin
    ldr x1, =input_buffer
    mov x2, #12           // tamaño máximo
    bl read_input
    
    // Convertir entrada a número
    ldr x1, =input_buffer
    bl ascii_to_int
    
    // Guardar número a buscar
    ldr x1, =search_num
    str w0, [x1]          

    // Realizar búsqueda lineal
    bl linear_search
    mov x21, x0          // Guardar resultado

    // Verificar resultado y mostrar mensaje apropiado
    cmp x21, #-1
    beq not_found

    // Número encontrado
    ldr x1, =msg_found
    bl print_string
    
    // Cargar número buscado para mostrarlo
    ldr x1, =search_num
    ldr w0, [x1]           // Corrección aquí
    ldr x1, =buffer
    bl int_to_ascii
    mov x1, x1
    bl print_string
    
    ldr x1, =msg_pos
    bl print_string
    
    mov w0, w21          // Posición encontrada
    ldr x1, =buffer
    bl int_to_ascii
    mov x1, x1
    bl print_string
    
    ldr x1, =newline
    bl print_string
    b end_program

not_found:
    ldr x1, =msg_notfound
    bl print_string
    
    // Cargar número buscado para mostrarlo
    ldr x1, =search_num
    ldr w0, [x1]           // Corrección aquí
    ldr x1, =buffer
    bl int_to_ascii
    mov x1, x1
    bl print_string
    
    ldr x1, =msg_notfound2
    bl print_string

end_program:
    mov x0, #0
    mov x8, #93
    svc #0

// Función de búsqueda lineal
// Retorna: x0 = índice si se encuentra, -1 si no se encuentra
linear_search:
    mov x19, #0                // índice
    ldr x1, =search_num
    ldr w20, [x1]              // Corrección aquí: cargar número a buscar
search_loop:
    cmp x19, array_len
    beq not_found_search
    
    ldr x21, =array
    lsl x22, x19, #2          // multiplicar índice por 4
    add x21, x21, x22
    ldr w21, [x21]            // cargar elemento actual
    
    cmp w21, w20
    beq found_search
    
    add x19, x19, #1
    b search_loop

found_search:
    mov x0, x19
    ret

not_found_search:
    mov x0, #-1
    ret

// Función para convertir ASCII a entero
ascii_to_int:
    mov w2, #0                // Inicializamos el acumulador en 0
parse_loop:
    ldrb w3, [x1], #1         // Leer un byte y avanzar
    subs w3, w3, #'0'         // Convertir ASCII a número
    blt parse_done            // Si no es dígito, terminar
    mov w6, #10               // Base 10
    mul w2, w2, w6            // Multiplicar acumulador por 10
    add w2, w2, w3            // Agregar nuevo dígito
    b parse_loop
parse_done:
    mov w0, w2                // Retornar resultado
    ret

// Función para convertir entero a ASCII
int_to_ascii:
    mov x2, x1                // Guardar dirección del buffer
    add x1, x1, #11           // Apuntar al final del buffer
    mov w3, #10               // Divisor
convert_loop:
    udiv w4, w0, w3           // Dividir por 10
    msub w5, w4, w3, w0       // Obtener residuo
    add w5, w5, #'0'          // Convertir a ASCII
    sub x1, x1, #1            // Retroceder en buffer
    strb w5, [x1]             // Guardar dígito
    mov w0, w4                // Preparar siguiente división
    cbnz w0, convert_loop     // Continuar si no es cero
    mov x0, x2                // Retornar dirección del buffer
    ret

// Función para imprimir cadena
print_string:
    mov x2, #0                // Contador de longitud
count_loop:
    ldrb w3, [x1, x2]         // Cargar byte
    cbz w3, print_str         // Si es 0, terminar conteo
    add x2, x2, #1            // Incrementar contador
    b count_loop
print_str:
    mov x0, #1                // stdout
    mov x8, #64               // sys_write
    svc #0
    ret

// Función para leer entrada
read_input:
    mov x8, #63               // sys_read
    svc #0
    ret

//------------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o lin.o lin.s

// Vincular el archivo objeto
// ld -o lin lin.o

// Ejecutar el programa
//  ./lin

//-------------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q lin

// start

// step

// q


//-------------------------------------------------------------------------------------------------------------------------------
// Enlace asciinema

https://asciinema.org/a/yrGmlPUTZpvbXv2CKSAoPfQV8




-
