// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail  
// No. control:** 22210346  

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#

// using System;
// using System.Numerics;

// class Program
// {
//     static void Main()
//     {
//         // Solicitar al usuario que ingrese un número
//         Console.Write("Ingrese un número para calcular su factorial: ");
//         string input = Console.ReadLine();

//         // Intentar convertir la entrada a un número
//         if (int.TryParse(input, out int numero) && numero >= 0)
//         {
//             // Calcular el factorial utilizando BigInteger para manejar números grandes
//             BigInteger factorial = 1;

//             for (int i = 1; i <= numero; i++)
//             {
//                 factorial *= i;
//             }

//             // Mostrar el resultado
//             Console.WriteLine($"El factorial de {numero} es: {factorial}");
//         }
//         else
//         {
//             // Si la entrada no es válida o el número es negativo
//             Console.WriteLine("Por favor, ingrese un número entero no negativo.");
//         }
//     }
// }


//-----------------------------------------------------------------------------------------------------------------

// Código en ARM64 Assembly

.global _start

.section .data
    prompt:     .asciz "Ingrese un número para calcular su factorial: "
    error_msg:  .asciz "Por favor, ingrese un número entero no negativo.\n"
    result_msg: .asciz "El factorial de "
    is_msg:     .asciz " es: "
    newline:    .asciz "\n"

.section .bss
    number:     .skip 4      // Espacio para el número ingresado
    result:     .skip 8      // Espacio para el resultado (64 bits)
    buffer:     .skip 12     // Buffer para conversión ASCII

.section .text
_start:
    // Mostrar prompt
    mov x0, 1
    ldr x1, =prompt
    bl print_string

    // Leer entrada del usuario
    mov x0, 0            // stdin
    ldr x1, =buffer
    mov x2, 12          // tamaño máximo a leer
    bl read_input

    // Convertir ASCII a número
    ldr x1, =buffer
    bl ascii_to_int
    
    // Guardar el número ingresado
    ldr x1, =number
    str w0, [x1]

    // Verificar si el número es negativo
    cmp w0, #0
    blt print_error

    // Calcular factorial
    bl factorial

    // Imprimir mensaje inicial
    mov x0, 1
    ldr x1, =result_msg
    bl print_string

    // Imprimir el número original
    ldr w0, number
    ldr x1, =buffer
    bl int_to_ascii
    mov x0, 1
    bl print_string

    // Imprimir " es: "
    mov x0, 1
    ldr x1, =is_msg
    bl print_string

    // Imprimir resultado
    ldr x0, result
    ldr x1, =buffer
    bl int_to_ascii
    mov x0, 1
    bl print_string

    // Imprimir nueva línea
    mov x0, 1
    ldr x1, =newline
    bl print_string

    b exit_program

print_error:
    mov x0, 1
    ldr x1, =error_msg
    bl print_string

exit_program:
    mov x0, 0
    mov x8, 93          // syscall exit
    svc 0

// Función factorial
factorial:
    // Inicializar resultado en 1
    mov x0, #1
    ldr x1, =result
    str x0, [x1]
    
    // Obtener el número para calcular factorial
    ldr w2, number
    
    // Si el número es 0, retornar 1
    cbz w2, factorial_done
    
factorial_loop:
    // Multiplicar resultado actual por el contador
    ldr x0, result
    mul x0, x0, x2
    
    // Guardar resultado
    ldr x1, =result
    str x0, [x1]
    
    // Decrementar contador
    sub w2, w2, #1
    
    // Continuar si no hemos llegado a 1
    cmp w2, #1
    bgt factorial_loop
    
factorial_done:
    ret

// Función para convertir ASCII a entero
ascii_to_int:
    mov w2, #0                // Inicializar resultado
parse_loop:
    ldrb w3, [x1], #1         // Cargar byte y avanzar puntero
    sub w3, w3, #'0'          // Convertir ASCII a número
    cmp w3, #9                // Verificar si es dígito válido
    bgt parse_done
    cmp w3, #0
    blt parse_done
    mov w4, #10
    mul w2, w2, w4            // Multiplicar resultado actual por 10
    add w2, w2, w3            // Añadir nuevo dígito
    b parse_loop
parse_done:
    mov w0, w2
    ret

// Función para convertir entero a ASCII
int_to_ascii:
    mov x2, x1               // Guardar dirección del buffer
    add x1, x1, #11          // Apuntar al final del buffer
    mov x3, #0               // Null terminator
    strb w3, [x1]
    sub x1, x1, #1           // Retroceder una posición
    
    // Si el número es 0, manejar caso especial
    cbnz x0, convert_loop
    mov w3, #'0'
    strb w3, [x1]
    b convert_done

convert_loop:
    cbz x0, convert_done     // Si el número es 0, terminamos
    mov x3, #10
    udiv x4, x0, x3          // x4 = x0 / 10
    msub x5, x4, x3, x0      // x5 = x0 - (x4 * 10) = remainder
    add w5, w5, #'0'         // Convertir a ASCII
    strb w5, [x1], #-1       // Guardar dígito y retroceder
    mov x0, x4               // Preparar para siguiente iteración
    b convert_loop

convert_done:
    add x1, x1, #1           // Ajustar puntero al primer dígito
    mov x0, x2               // Devolver dirección del buffer
    ret

// Función para imprimir string
print_string:
    mov x2, #0               // Contador de longitud
strlen_loop:
    ldrb w3, [x1, x2]       // Cargar byte
    cbz w3, strlen_done      // Si es 0, terminar
    add x2, x2, #1          // Incrementar contador
    b strlen_loop
strlen_done:
    mov x8, #64             // syscall write
    svc 0
    ret

// Función para leer input
read_input:
    mov x8, #63             // syscall read
    svc 0
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o fact.o fact.cs

// Vincular el archivo objeto
// ld -o fact fact.o

// Ejecutar el programa
//  ./fact

//---------------------------------------------------------------------------------------------------------------------------------------

// Enlace de asciinema
https://asciinema.org/a/uUueK8OHa5fObljK3WTrTVEMu








-
