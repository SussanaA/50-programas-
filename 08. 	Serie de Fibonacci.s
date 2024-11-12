// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#
// using System;

// namespace SerieFibonacci
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario el número de términos de la serie de Fibonacci
//             Console.Write("Ingrese la cantidad de términos de la Serie de Fibonacci: ");
//             int n = int.Parse(Console.ReadLine());

//             // Variables para almacenar los dos primeros términos de la serie
//             int primero = 0, segundo = 1, siguiente;

//             Console.WriteLine("Serie de Fibonacci:");

//             // Mostrar la serie de Fibonacci
//             for (int i = 0; i < n; i++)
//             {
//                 if (i <= 1)
//                     siguiente = i; // Para los dos primeros términos, asignar i
//                 else
//                 {
//                     // Calcular el siguiente término sumando los dos anteriores
//                     siguiente = primero + segundo;
//                     primero = segundo;
//                     segundo = siguiente;
//                 }

//                 // Imprimir el término de la serie
//                 Console.Write(siguiente + " ");
//             }

//             // Esperar a que el usuario presione una tecla para cerrar
//             Console.WriteLine("\nPresione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }

//-----------------------------------------------------------------------------------------------------------------

// Código en ARM64 Assembly

.global _start

.section .data
    prompt:     .asciz "Ingrese la cantidad de términos de la Serie de Fibonacci: "
    msg_serie:  .asciz "Serie de Fibonacci:\n"
    space:      .asciz " "
    newline:    .asciz "\n"
    msg_exit:   .asciz "Presione Enter para salir...\n"

.section .bss
    n:          .skip 4      // Número de términos
    buffer:     .skip 12     // Buffer para entrada/salida de números
    first:      .skip 4      // Primer número
    second:     .skip 4      // Segundo número
    next:       .skip 4      // Siguiente número
    counter:    .skip 4      // Contador del bucle

.section .text
_start:
    // Mostrar mensaje solicitando número de términos
    mov x0, 1
    ldr x1, =prompt
    bl print_string

    // Leer número de términos
    mov x0, 0
    ldr x1, =buffer
    mov x2, 12
    bl read_input

    // Convertir entrada a número
    ldr x1, =buffer
    bl ascii_to_int
    
    // Guardar n
    ldr x1, =n
    str w0, [x1]

    // Mostrar mensaje "Serie de Fibonacci:"
    mov x0, 1
    ldr x1, =msg_serie
    bl print_string

    // Inicializar variables
    mov w0, #0          // first = 0
    ldr x1, =first
    str w0, [x1]
    
    mov w0, #1          // second = 1
    ldr x1, =second
    str w0, [x1]
    
    mov w0, #0          // counter = 0
    ldr x1, =counter
    str w0, [x1]

fibonacci_loop:
    // Verificar si counter < n
    ldr x1, =counter    // Cargar dirección del contador
    ldr w0, [x1]        // Cargar valor del contador
    ldr x2, =n
    ldr w2, [x2]        // n
    cmp w0, w2
    bge end_loop

    // if (i <= 1) siguiente = i
    cmp w0, #1
    bgt calc_next

    // Para i <= 1
    ldr x1, =next
    str w0, [x1]
    b print_number

calc_next:
    // siguiente = primero + segundo
    ldr x1, =first
    ldr w1, [x1]        // w1 = first
    ldr x2, =second
    ldr w2, [x2]        // w2 = second
    add w3, w1, w2      // w3 = first + second
    
    // Actualizar variables
    str w2, [x1]        // first = second
    ldr x1, =second
    str w3, [x1]        // second = next
    ldr x1, =next
    str w3, [x1]        // guardar next

print_number:
    // Convertir número a string y mostrarlo
    ldr x1, =next
    ldr w0, [x1]
    ldr x1, =buffer
    bl int_to_ascii
    
    mov x0, 1
    bl print_string

    // Imprimir espacio
    mov x0, 1
    ldr x1, =space
    bl print_string

    // Incrementar contador
    ldr x1, =counter
    ldr w0, [x1]
    add w0, w0, #1
    str w0, [x1]
    b fibonacci_loop

end_loop:
    // Imprimir nueva línea
    mov x0, 1
    ldr x1, =newline
    bl print_string

    // Mostrar mensaje de salida
    mov x0, 1
    ldr x1, =msg_exit
    bl print_string

    // Esperar Enter
    mov x0, 0
    ldr x1, =buffer
    mov x2, 2
    bl read_input

    // Salir del programa
    mov x0, 0
    mov x8, 93
    svc 0

// Función para convertir caracteres ASCII a entero
ascii_to_int:
    mov w2, #0                // Inicializamos el acumulador en 0
parse_loop:
    ldrb w3, [x1], #1         // Leer un byte (dígito) y mover al siguiente
    cmp w3, #'\n'             // Verificar si es un salto de línea
    beq parse_done            // Si es salto de línea, terminamos
    subs w3, w3, #'0'         // Convertir el carácter ASCII al valor numérico
    blt parse_done            // Si no es un dígito, terminamos la conversión
    mov w6, #10               // Mover 10 a w6 como multiplicador
    mul w2, w2, w6            // Multiplicar acumulador por 10
    add w2, w2, w3            // Agregar el dígito convertido
    b parse_loop              // Repetir para el siguiente dígito
parse_done:
    mov w0, w2                // El resultado está en w0
    ret

// Función para convertir un entero en ASCII
int_to_ascii:
    mov x2, x1               // Guardar la dirección del buffer en x2
    add x1, x1, 10           // Apuntar al final del buffer
    mov w3, 10               // Divisor para extraer dígitos
    
    // Añadir espacio al final del buffer
    mov w5, #' '             // Espacio
    strb w5, [x1]           // Guardar espacio
    sub x1, x1, #1          // Mover puntero
    
convert_loop:
    udiv w4, w0, w3          // w4 = w0 / 10
    msub w5, w4, w3, w0      // w5 = w0 % 10 (remainder)
    add w5, w5, #'0'         // Convertir a ASCII
    strb w5, [x1]            // Guardar dígito en el buffer
    sub x1, x1, #1           // Decrementar el puntero
    mov w0, w4               // Actualizar w0 para siguiente dígito
    cbnz w0, convert_loop    // Continuar si w0 no es cero
    
    add x1, x1, #1           // Ajustar puntero al primer dígito
    mov x0, x1               // Retornar la dirección del primer dígito
    ret

// Función para imprimir cadenas
print_string:
    mov x2, #0               // Longitud de la cadena
find_null:
    ldrb w3, [x1, x2]       // Cargar un byte de la cadena
    cmp w3, #0              // Verificar si es el fin de la cadena
    beq print_done          // Si es 0 (null terminator), terminamos
    add x2, x2, #1          // Incrementamos el contador de la longitud
    b find_null             // Continuamos buscando
print_done:
    mov x0, #1              // Descriptor de archivo 1 (stdout)
    mov x8, #64             // Llamada al sistema sys_write
    svc #0                  // Ejecutamos la llamada al sistema
    ret

// Función para leer la entrada del usuario
read_input:
    mov x8, #63             // Llamada al sistema sys_read
    svc #0                  // Ejecutamos la llamada al sistema
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o fib.o fib.s

// Vincular el archivo objeto
// ld -o fib fib.o

// Ejecutar el programa
//  ./fib

//---------------------------------------------------------------------------------------------------------------------------------------

// Enlace de asciinema

https://asciinema.org/a/mwRAZSyBYSIU6jeIjt97xC3Sl





-
