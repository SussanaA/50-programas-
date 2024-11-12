// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código de referencia en C#

// using System;

// namespace VerificarNumeroPrimo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario un número para verificar si es primo
//             Console.Write("Ingrese un número para verificar si es primo: ");
//             int numero = Convert.ToInt32(Console.ReadLine());

//             // Llamar a la función que verifica si el número es primo
//             bool esPrimo = EsPrimo(numero);

//             // Mostrar el resultado
//             if (esPrimo)
//             {
//                 Console.WriteLine($"{numero} es un número primo.");
//             }
//             else
//             {
//                 Console.WriteLine($"{numero} no es un número primo.");
//             }
//         }

//         // Función que determina si un número es primo
//         static bool EsPrimo(int numero)
//         {
//             // Los números menores que 2 no son primos
//             if (numero < 2)
//                 return false;

//             // Verificar divisibilidad desde 2 hasta la raíz cuadrada del número
//             for (int i = 2; i <= Math.Sqrt(numero); i++)
//             {
//                 if (numero % i == 0)
//                 {
//                     return false; // Si es divisible por 'i', no es primo
//                 }
//             }

//             return true; // Si no se encontró divisor, el número es primo
//         }
//     }
// }


//-----------------------------------------------------------------------------------------------------------------

// Código en ARM64 Assembly

.global _start

.section .data
    prompt:     .asciz "Ingrese un numero para verificar si es primo: "
    es_primo:   .asciz " es un numero primo.\n"
    no_primo:   .asciz " no es un numero primo.\n"
    buffer:     .skip 12    // Buffer para entrada/salida de números

.section .bss
    numero:     .skip 4     // Para almacenar el número ingresado

.section .text
_start:
    // Mostrar prompt
    mov x0, 1              // stdout
    ldr x1, =prompt
    bl print_string

    // Leer número
    mov x0, 0              // stdin
    ldr x1, =buffer
    mov x2, 12             // Tamaño máximo de lectura
    bl read_input

    // Convertir ASCII a entero
    ldr x1, =buffer
    bl ascii_to_int
    
    // Guardar número
    ldr x1, =numero
    str w0, [x1]

    // Llamar a es_primo
    bl check_prime

    // w0 contiene 1 si es primo, 0 si no es primo
    // Convertir el número original a string para output
    ldr w0, numero
    ldr x1, =buffer
    bl int_to_ascii

    // Imprimir el número
    mov x0, 1
    mov x1, x1
    bl print_string

    // Verificar resultado y mostrar mensaje apropiado
    ldr w0, [sp]           // Recuperar resultado de es_primo
    cbnz w0, print_prime   // Si es primo (!=0), imprimir mensaje primo
    
    // No es primo
    mov x0, 1
    ldr x1, =no_primo
    bl print_string
    b exit_program

print_prime:
    mov x0, 1
    ldr x1, =es_primo
    bl print_string

exit_program:
    mov x0, 0
    mov x8, 93
    svc 0

// Función check_prime
// Entrada: w0 = número a verificar
// Salida: w0 = 1 si es primo, 0 si no es primo
check_prime:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    stp x19, x20, [sp, -16]!

    mov w19, w0            // Guardar número original
    
    // Verificar si es menor que 2
    cmp w19, #2
    blt not_prime

    // Inicializar divisor (i = 2)
    mov w20, #2

check_loop:
    // Calcular aproximadamente la raíz cuadrada
    // Usamos un método simple: i * i <= numero
    mul w0, w20, w20
    cmp w0, w19
    bgt is_prime

    // Verificar si es divisible por el divisor actual
    sdiv w0, w19, w20
    msub w0, w0, w20, w19  // w0 = numero - (numero/divisor * divisor) = resto
    cbnz w0, next_divisor  // Si el resto no es 0, probar siguiente divisor

not_prime:
    mov w0, #0
    b end_check

next_divisor:
    add w20, w20, #1
    b check_loop

is_prime:
    mov w0, #1

end_check:
    // Restaurar registros
    ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
    ret

// Función para convertir ASCII a entero
ascii_to_int:
    mov w2, #0                // Resultado
parse_loop:
    ldrb w3, [x1], #1         // Cargar siguiente byte
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
    mov x2, x1                // Guardar dirección inicial
    add x1, x1, #11           // Apuntar al final del buffer
    mov w3, #0
    strb w3, [x1]             // Null terminator
    mov w3, #10               // Divisor
convert_loop:
    sub x1, x1, #1            // Mover puntero
    udiv w4, w0, w3           // Dividir por 10
    msub w5, w4, w3, w0       // Obtener resto
    add w5, w5, #'0'          // Convertir a ASCII
    strb w5, [x1]             // Guardar dígito
    mov w0, w4                // Preparar para siguiente iteración
    cbnz w0, convert_loop     // Continuar si quedan dígitos
    mov x0, x1                // Retornar puntero al inicio del número
    ret

// Función para imprimir string
print_string:
    mov x2, #0                // Contador longitud
str_len_loop:
    ldrb w3, [x1, x2]         // Cargar byte
    cbz w3, str_len_done      // Si es 0, terminar
    add x2, x2, #1            // Incrementar contador
    b str_len_loop
str_len_done:
    mov x8, #64               // syscall write
    svc #0
    ret

// Función para leer input
read_input:
    mov x8, #63               // syscall read
    svc #0
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o primo.o primo.s

// Vincular el archivo objeto
// ld -o primo primo.o

// Ejecutar el programa
//  ./primo

//---------------------------------------------------------------------------------------------------------------------------------------

// Enlace de asciinema
https://asciinema.org/a/gUqu3AGpjks2cBKc0incuO0lq





-
