// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#

// using System;
//
// namespace BusquedaNumeroMaximo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar el tamaño del arreglo
//             Console.Write("Ingrese el tamaño del arreglo: ");
//             int tamaño = int.Parse(Console.ReadLine());
//
//             // Crear el arreglo y solicitar los elementos
//             int[] numeros = new int[tamaño];
//             for (int i = 0; i < tamaño; i++)
//             {
//                 Console.Write($"Ingrese el número en la posición {i + 1}: ");
//                 numeros[i] = int.Parse(Console.ReadLine());
//             }
//
//             // Encontrar el número máximo
//             int maximo = numeros[0];
//             for (int i = 1; i < tamaño; i++)
//             {
//                 if (numeros[i] > maximo)
//                 {
//                     maximo = numeros[i];
//                 }
//             }
//
//             // Mostrar el resultado
//             Console.WriteLine($"El número máximo en el arreglo es: {maximo}");
//
//             // Esperar a que el usuario presione una tecla para cerrar
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }

//-------------------------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
    prompt_size:     .asciz "Ingrese el tamaño del arreglo: "
    prompt_num:      .asciz "Ingrese el número en la posición "
    prompt_pos:      .asciz ": "
    result_msg:      .asciz "El número máximo en el arreglo es: "
    newline:         .asciz "\n"

.section .bss
    array:          .skip 400    // Espacio para 100 números (4 bytes cada uno)
    array_size:     .skip 4      // Tamaño del arreglo
    buffer:         .skip 12     // Buffer para entrada/salida de texto
    max_num:        .skip 4      // Para almacenar el número máximo

.section .text
_start:
    // Solicitar tamaño del arreglo
    mov x0, 1
    ldr x1, =prompt_size
    bl print_string

    // Leer tamaño del arreglo
    mov x0, 0
    ldr x1, =buffer
    mov x2, 12
    bl read_input
    
    // Convertir entrada a número
    ldr x1, =buffer
    bl ascii_to_int
    
    // Guardar tamaño del arreglo
    ldr x1, =array_size
    str w0, [x1]
    
    // Inicializar variables para el loop de entrada
    mov x19, #0           // índice del array
    ldr x20, =array      // dirección base del array
    ldr w21, [x1]        // tamaño del array

input_loop:
    // Verificar si hemos terminado de leer todos los números
    cmp x19, x21
    bge input_done
    
    // Imprimir mensaje "Ingrese el número en la posición X: "
    mov x0, 1
    ldr x1, =prompt_num
    bl print_string
    
    // Imprimir número de posición (x19 + 1)
    mov w0, w19
    add w0, w0, #1
    ldr x1, =buffer
    bl int_to_ascii
    mov x0, 1
    mov x1, x1
    bl print_string
    
    // Imprimir ": "
    mov x0, 1
    ldr x1, =prompt_pos
    bl print_string
    
    // Leer número
    mov x0, 0
    ldr x1, =buffer
    mov x2, 12
    bl read_input
    
    // Convertir a entero
    ldr x1, =buffer
    bl ascii_to_int
    
    // Guardar número en el array
    str w0, [x20, x19, lsl #2]
    
    // Incrementar índice
    add x19, x19, #1
    b input_loop

input_done:
    // Inicializar máximo con el primer elemento
    ldr w22, [x20]        // w22 contendrá el máximo
    mov x19, #1           // índice comenzando desde el segundo elemento

find_max_loop:
    cmp x19, x21
    bge find_max_done
    
    // Cargar siguiente número
    ldr w23, [x20, x19, lsl #2]
    
    // Comparar con el máximo actual
    cmp w23, w22
    ble not_larger
    mov w22, w23         // Actualizar máximo si el número actual es mayor
    
not_larger:
    add x19, x19, #1
    b find_max_loop

find_max_done:
    // Guardar el máximo
    ldr x1, =max_num
    str w22, [x1]
    
    // Imprimir mensaje de resultado
    mov x0, 1
    ldr x1, =result_msg
    bl print_string
    
    // Convertir máximo a string y mostrar
    ldr w0, [x1, #-4]    // Cargar max_num
    ldr x1, =buffer
    bl int_to_ascii
    mov x0, 1
    mov x1, x1
    bl print_string
    
    // Imprimir nueva línea
    mov x0, 1
    ldr x1, =newline
    bl print_string
    
    // Terminar programa
    mov x0, 0
    mov x8, 93
    svc 0

// Función para convertir ASCII a entero
ascii_to_int:
    mov w2, #0                // Inicializar resultado
parse_loop:
    ldrb w3, [x1], #1         // Cargar siguiente carácter
    subs w3, w3, #'0'         // Convertir ASCII a número
    blt parse_done            // Si es menor que 0, terminar
    cmp w3, #9                // Comparar con 9
    bgt parse_done            // Si es mayor que 9, terminar
    mov w4, #10               // Multiplicador
    mul w2, w2, w4            // Multiplicar resultado actual por 10
    add w2, w2, w3            // Añadir nuevo dígito
    b parse_loop              // Continuar con siguiente carácter
parse_done:
    mov w0, w2                // Mover resultado a w0
    ret

// Función para convertir entero a ASCII
int_to_ascii:
    mov x2, x1                // Guardar dirección del buffer
    add x1, x1, #11           // Apuntar al final del buffer
    mov w4, #0                // Terminador nulo
    strb w4, [x1]             // Almacenar terminador
    mov w4, #10               // Divisor

convert_loop:
    sub x1, x1, #1            // Retroceder en el buffer
    udiv w3, w0, w4           // Dividir por 10
    msub w5, w3, w4, w0       // Obtener residuo
    add w5, w5, #'0'          // Convertir a ASCII
    strb w5, [x1]             // Almacenar carácter
    mov w0, w3                // Preparar siguiente división
    cbnz w0, convert_loop     // Continuar si no es cero
    mov x0, x2                // Devolver dirección del buffer
    ret

// Función para imprimir cadena
print_string:
    mov x2, #0                // Contador de longitud
length_loop:
    ldrb w3, [x1, x2]         // Cargar carácter
    cbz w3, print_str         // Si es 0, imprimir
    add x2, x2, #1            // Incrementar contador
    b length_loop
print_str:
    mov x8, #64               // syscall write
    svc 0
    ret

// Función para leer entrada
read_input:
    mov x8, #63               // syscall read
    svc 0
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o max.o max.s

// Vincular el archivo objeto
// ld -o max max.o

// Ejecutar el programa
//  ./max

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q max

// start

// step

// q


//-------------------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/5rwhS2PEsCFMThfTFNW7oU3ac



-
