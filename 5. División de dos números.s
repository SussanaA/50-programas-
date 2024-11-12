// ------------------------------------------------------------
// Nombre: Rodríguez Morales Susana Abigail
// Descripción: Este programa toma dos números enteros, los divide,
//              y almacena el resultado en una variable de salida.
// -----------------------------------------------------------------------------------------------------------

// Ejemplo en C# para referencia:
//using System;

//namespace DivisionDeNumeros
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {
              // Solicitar el primer número
//            Console.Write("Ingresa el primer número: ");
//            double numero1 = Convert.ToDouble(Console.ReadLine());

              // Solicitar el segundo número
//            Console.Write("Ingresa el segundo número: ");
//            double numero2 = Convert.ToDouble(Console.ReadLine());

              // Verificar si el segundo número es diferente de cero para evitar la división por cero
//            if (numero2 != 0)
//            {
                  // Realizar la división
//                double resultado = numero1 / numero2;

                  // Mostrar el resultado
//                Console.WriteLine("El resultado de la división es: " + resultado);
//            }
//            else
//            {
                  // Mostrar un mensaje si el segundo número es cero
//                Console.WriteLine("Error: No se puede dividir entre cero.");
//            }

              // Esperar a que el usuario presione una tecla para cerrar
//            Console.WriteLine("Presione cualquier tecla para salir...");
//            Console.ReadKey();
//        }
//    }
//}

//--------------------------------------------------------------------------------------------------

// Código en ensamblador ARM64

.global _start

.section .data
    prompt1:     .asciz "Ingresa el primer numero: "
    prompt2:     .asciz "Ingresa el segundo numero: "
    result_msg:  .asciz "El resultado de la division es: "
    error_msg:   .asciz "Error: No se puede dividir entre cero.\n"
    exit_msg:    .asciz "Presione cualquier tecla para salir...\n"
    newline:     .asciz "\n"

  .section .bss
    .align 4
    num1:        .skip 4      // Primer número
    num2:        .skip 4      // Segundo número
    result:      .skip 4      // Resultado
    buffer:      .skip 12     // Buffer para conversión ASCII
    key_buffer:  .skip 1      // Buffer para ReadKey

.section .text
_start:
    // Mostrar prompt1
    mov x0, 1
    ldr x1, =prompt1
    bl print_string

      // Leer primer número
    mov x0, 0
    ldr x1, =num1
    mov x2, 4
    bl read_input

    // Convertir ASCII a entero
    ldr x1, =num1
    bl ascii_to_int
    ldr x1, =num1
    str w0, [x1]

    // Mostrar prompt2
    mov x0, 1
    ldr x1, =prompt2
    bl print_string

      // Leer segundo número
    mov x0, 0
    ldr x1, =num2
    mov x2, 4
    bl read_input

    // Convertir ASCII a entero
    ldr x1, =num2
    bl ascii_to_int
    ldr x1, =num2
    str w0, [x1]

    // Verificar división por cero
    ldr w0, [x1]
    cmp w0, #0
    beq division_by_zero

      // Realizar división
    ldr x1, =num1
    ldr w1, [x1]        // Dividendo
    ldr x2, =num2
    ldr w2, [x2]        // Divisor
    sdiv w3, w1, w2     // División con signo

    // Guardar resultado
    ldr x1, =result
    str w3, [x1]

    // Mostrar mensaje de resultado
    mov x0, 1
    ldr x1, =result_msg
    bl print_string

      // Convertir resultado a ASCII y mostrarlo
    ldr w0, result
    ldr x1, =buffer
    bl int_to_ascii
    mov x0, 1
    bl print_string

    // Imprimir nueva línea
    mov x0, 1
    ldr x1, =newline
    bl print_string
    b exit_prompt

  division_by_zero:
    // Mostrar mensaje de error
    mov x0, 1
    ldr x1, =error_msg
    bl print_string

exit_prompt:
    // Mostrar mensaje de salida
    mov x0, 1
    ldr x1, =exit_msg
    bl print_string

    // Esperar tecla
    mov x0, 0
    ldr x1, =key_buffer
    mov x2, 1
    mov x8, 63
    svc 0

      // Terminar programa
    mov x0, 0
    mov x8, 93
    svc 0

// Función para convertir ASCII a entero
ascii_to_int:
    mov w2, #0                // Inicializar acumulador
parse_loop:
    ldrb w3, [x1], #1         // Cargar byte y avanzar puntero
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
    mov x2, x1                // Guardar dirección inicial
    add x1, x1, #11           // Apuntar al final del buffer
    mov w3, #10               // Divisor
convert_loop:
    udiv w4, w0, w3           // Dividir por 10
    msub w5, w4, w3, w0       // Obtener residuo
    add w5, w5, #'0'          // Convertir a ASCII
    sub x1, x1, #1            // Retroceder en buffer
    strb w5, [x1]             // Guardar dígito
    mov w0, w4                // Preparar siguiente división
    ret

// Función para imprimir cadena
print_string:
    mov x2, #0                // Contador de longitud
length_loop:
    ldrb w3, [x1, x2]         // Cargar byte
    cbz w3, print             // Si es cero, imprimir
    add x2, x2, #1            // Incrementar contador
    b length_loop
print:
    mov x0, #1                // stdout
    mov x8, #64               // syscall write
    svc #0
    ret

//---------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
//  as -o div.o div.s

// Vincular el archivo objeto
//  ld -o div div.o

// Ejecutar el programa
//  ./div

//---------------------------------------------------------------------------

// Enlace de asciinema
https://asciinema.org/a/IdRVERPClj2H98ivQccCM1oPe





-
