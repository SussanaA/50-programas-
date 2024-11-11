// ------------------------------------------------------------
// Nombre: Rodríguez Morales Susana Abigail
// Descripción: Este programa toma dos números enteros, los resta,
//              y almacena el resultado en una variable de salida.
// -----------------------------------------------------------------------------------------------------------
### Descripción de la actividad:
El objetivo de esta actividad es desarrollar un programa en 
lenguaje ensamblador ARM64 que permita al usuario ingresar 
dos números y luego realice su resta. 

---

### Código en C#

~~~
using System;

namespace RestaConsola
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Programa de Resta de Dos Números");

            // Solicitar el primer número
            Console.Write("Introduce el primer número: ");
            string entrada1 = Console.ReadLine();
            int numero1 = int.Parse(entrada1);

            // Solicitar el segundo número
            Console.Write("Introduce el segundo número: ");
            string entrada2 = Console.ReadLine();
            int numero2 = int.Parse(entrada2);

            // Realizar la resta
            int resta = numero1 - numero2;

            // Mostrar el resultado
            Console.WriteLine("La resta de {0} y {1} es: {2}", numero1, numero2, resta);
        }
    }
}

~~~

---

### Código en ARM64 Assembly

~~~
   .global _start           // Define la etiqueta global para el punto de entrada

.section .data
    prompt1:      .asciz "Ingresa el primer numero: "  // Mensaje para el primer número
    prompt2:      .asciz "Ingresa el segundo numero: " // Mensaje para el segundo número
    result_msg:   .asciz "El resultado de la resta es: " // Mensaje para el resultado

.section .bss
    num1:   .skip 4      // Reservamos espacio para el primer número
    num2:   .skip 4      // Reservamos espacio para el segundo número
    result: .skip 4      // Reservamos espacio para el resultado
    buffer: .skip 12   ///////// Buffer temporal para almacenar el número en ASCII (suficiente para 10 dígitos y el null terminator)

.section .text
_start:
    // Mostrar mensaje "Ingresa el primer numero: "
    mov x0, 1            // Descriptor de archivo 1 (stdout)
    ldr x1, =prompt1     // Cargar la dirección de la cadena de texto
    bl print_string      // Llamar a la función para imprimir el mensaje

    // Leer primer número
    mov x0, 0            // Descriptor de archivo 0 (stdin)
    ldr x1, =num1        // Dirección de la variable donde guardar el número
    mov x2, 4            // Leer 4 bytes (tamaño de un entero)
    bl read_input        // Llamar a la función para leer la entrada
    // Convertir primer número ASCII a entero
    ldr x1, =num1
    bl ascii_to_int

    // Guardar entero en `num1`
    ldr x1, =num1            // Cargar la dirección de `num1`
    str w0, [x1]             // Usar el registro `x1` como dirección para almacenar `w0`

    // Mostrar mensaje "Ingresa el segundo numero: "
    mov x0, 1            // Descriptor de archivo 1 (stdout)
    ldr x1, =prompt2     // Cargar la dirección de la cadena de texto
    bl print_string      // Llamar a la función para imprimir el mensaje

    // Leer segundo número
    mov x0, 0            // Descriptor de archivo 0 (stdin)
    ldr x1, =num2        // Dirección de la variable donde guardar el número
    mov x2, 4            // Leer 4 bytes (tamaño de un entero)
    bl read_input        // Llamar a la función para leer la entrada

    // Convertir segundo número ASCII a entero
    ldr x1, =num2
    bl ascii_to_int

    // Guardar entero en `num2`
    ldr x1, =num2            // Cargar la dirección de `num2`
    str w0, [x1]             // Usar el registro `x1` como dirección para almacenar `w0`

    // Realizar la suma
    ldr w1,num1       // Cargar el primer número en w1
    ldr w2,num2       // Cargar el segundo número en w2
    add w3, w1, w2       // Realizar la resta: w3 = w1 - w2

    // Guardar el resultado en la variable result
    ldr x1, =result      // Cargar la dirección de la variable result
    str w3, [x1]         // Guardar el resultado de la resta en result

    // Mostrar mensaje "El resultado de la resta es: "
    mov x0, 1            // Descriptor de archivo 1 (stdout)
    ldr x1, =result_msg  // Cargar la dirección de la cadena de texto
    bl print_string      // Llamar a la función para imprimir el mensaje

    // Convertir el resultado a cadena
    ldr w0,result      // Cargar el resultado en w0
    ldr x1, =buffer       // Pasar el buffer como destino
    bl int_to_ascii       // Llamar a la función de conversión

    // Imprimir el número convertido
    mov x0, 1
    mov x1, x1            // Buffer con el número en ASCII
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
    mov w6, #10              // Mover 10 a w6 como multiplicador
    mul w2, w2, w6           // Multiplicar `w2` por 10
    mul w2, w2, w6             // Multiplicar acumulador por 10
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
    mov x2, 0            // Longitud de la cadena, la computamos a mano o con un loop si es necesario
    find_null:
        ldrb w3, [x1, x2]   // Cargar un byte de la cadena
        cmp w3, 0            // Verificar si es el fin de la cadena
        beq print_done       // Si es 0 (null terminator), terminamos
        add x2, x2, 1        // Incrementamos el contador de la longitud
        b find_null          // Continuamos buscando
    print_done:
    mov x0, 1                // Descriptor de archivo 1 (stdout)
    mov x1, x1                // Dirección de la cadena
    mov x2, x2                // Longitud de la cadena
    mov x8, 64                // Llamada al sistema sys_write
    svc 0                      // Ejecutamos la llamada al sistema
    ret

// Función para leer la entrada del usuario
read_input:
    mov x8, 63                // Llamada al sistema sys_read
    svc 0                      // Ejecutamos la llamada al sistema
    ret

~~~

---

# Comandos para ejecutar el programa

## Ensamblar el código
as -o resta.o resta.s

## Vincular el archivo objeto
ld -o resta resta.o

## Ejecutar el programa
./resta







    
