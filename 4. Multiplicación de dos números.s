// ----------------------------------------------------------------------------------
// Nombre: Rodríguez Morales Susana Abigail
// Descripción: Este programa toma dos números enteros, los multilpica,
//              y almacena el resultado en una variable de salida.
// ------------------------------------------------------------------------------------

// Ejemplo en C# para referencia:
//using System;

//namespace MultiplicacionDeNumeros
//{
//    class Program
//    {
//        static void Main(string[] args)
//        {
              // Solicitar el primer número
//            Console.Write("Ingrese el primer número: ");
//            double numero1 = Convert.ToDouble(Console.ReadLine());

              // Solicitar el segundo número
//            Console.Write("Ingrese el segundo número: ");
//            double numero2 = Convert.ToDouble(Console.ReadLine());

//              // Realizar la multiplicación
//            double resultado = numero1 * numero2;

              // Mostrar el resultado
//            Console.WriteLine("El resultado de la multiplicación es: " + resultado);

              // Esperar a que el usuario presione una tecla para cerrar
//            Console.WriteLine("Presione cualquier tecla para salir...");
//            Console.ReadKey();
//        }
//    }
//}

//--------------------------------------------------------------------------------------

// Código en ensamblador ARM64

.global _start           // Define la etiqueta global para el punto de entrada

.section .data
    prompt1:      .asciz "Ingrese el primer numero: "  // Mensaje para el primer número
    prompt2:      .asciz "Ingrese el segundo numero: " // Mensaje para el segundo número
    result_msg:   .asciz "El resultado de la multiplicacion es: " // Mensaje para el resultado
    newline:      .asciz "\n"    // Carácter de nueva línea

.section .bss
    num1:   .skip 4      // Reservamos espacio para el primer número
    num2:   .skip 4      // Reservamos espacio para el segundo número
    result: .skip 4      // Reservamos espacio para el resultado
    buffer: .skip 12     // Buffer temporal para almacenar el número en ASCII

.section .text
_start:
    // Mostrar mensaje para el primer número
    mov x0, 1            // Descriptor de archivo 1 (stdout)
    ldr x1, =prompt1     // Cargar la dirección de la cadena de texto
    bl print_string      // Llamar a la función para imprimir el mensaje

    // Leer primer número
    mov x0, 0            // Descriptor de archivo 0 (stdin)
    ldr x1, =num1        // Dirección de la variable donde guardar el número
    mov x2, 4            // Leer 4 bytes
    bl read_input        // Llamar a la función para leer la entrada

    // Convertir primer número ASCII a entero
    ldr x1, =num1
    bl ascii_to_int

    // Guardar entero en `num1`
    ldr x1, =num1
    str w0, [x1]

      // Mostrar mensaje para el segundo número
    mov x0, 1
    ldr x1, =prompt2
    bl print_string

    // Leer segundo número
    mov x0, 0
    ldr x1, =num2
    mov x2, 4
    bl read_input

    // Convertir segundo número ASCII a entero
    ldr x1, =num2
    bl ascii_to_int

    // Guardar entero en `num2`
    ldr x1, =num2
    str w0, [x1]

      // Realizar la multiplicación
    ldr w1, num1         // Cargar el primer número en w1
    ldr w2, num2         // Cargar el segundo número en w2
    mul w3, w1, w2       // Realizar la multiplicación: w3 = w1 * w2

    // Guardar el resultado
    ldr x1, =result
    str w3, [x1]

    // Mostrar mensaje de resultado
    mov x0, 1
    ldr x1, =result_msg
    bl print_string

    // Convertir el resultado a cadena
    ldr w0, result
    ldr x1, =buffer
    bl int_to_ascii

    // Imprimir el resultado
    mov x0, 1
    mov x1, x1
    bl print_string

    // Imprimir nueva línea
    mov x0, 1
    ldr x1, =newline
    bl print_string

    // Terminar el programa
    mov x0, 0            // Código de salida
    mov x8, 93           // Código del sistema para terminar el programa (exit)
    svc 0                // Llamar al sistema

// Función para convertir caracteres ASCII a entero
ascii_to_int:
    mov w2, #0                // Inicializamos el acumulador en 0
parse_loop:
    ldrb w3, [x1], #1         // Leer un byte (dígito) y mover al siguiente
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
convert_loop:
    udiv w4, w0, w3          // w4 = w0 / 10
    msub w5, w4, w3, w0      // w5 = w0 % 10 (remainder)
    add w5, w5, '0'          // Convertir a ASCII
    sub x1, x1, 1            // Decrementar el puntero
    strb w5, [x1]            // Guardar dígito en el buffer
    mov w0, w4               // Actualizar w0 para siguiente dígito
    cbnz w0, convert_loop    // Continuar si w0 no es cero

    mov x0, x2               // Retornar la dirección del buffer
    ret

// Función para imprimir cadenas
print_string:
    mov x2, 0            // Inicializar contador de longitud
find_null:
    ldrb w3, [x1, x2]   // Cargar un byte de la cadena
    cmp w3, 0           // Verificar si es el fin de la cadena
    beq print_done      // Si es 0 (null terminator), terminamos
    add x2, x2, 1       // Incrementar contador
    b find_null         // Continuar buscando
print_done:
    mov x0, 1           // stdout
    mov x1, x1          // Dirección de la cadena
    mov x8, 64          // sys_write
    svc 0
    ret


// Función para leer la entrada del usuario
read_input:
    mov x8, 63          // sys_read
    svc 0
    ret


//--------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
//  as -o mult.o mult.s

// Vincular el archivo objeto
//  ld -o mult mult.o

// Ejecutar el programa
//  ./mult

//---------------------------------------------------------------------------

// Enlace de asciinema
https://asciinema.org/a/k6saow3do1QtPXFxB9gDGUjDR 




