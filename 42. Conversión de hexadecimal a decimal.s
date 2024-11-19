//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace HexadecimalToDecimal
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario ingresar un número hexadecimal
//             Console.Write("Ingrese un número en formato hexadecimal: ");
//             string hexNumber = Console.ReadLine();

//             // Intentar convertir el número hexadecimal a decimal
//             try
//             {
//                 // Convertir el número hexadecimal a decimal
//                 int decimalNumber = Convert.ToInt32(hexNumber, 16);

//                 // Mostrar el resultado
//                 Console.WriteLine($"El número hexadecimal {hexNumber} en decimal es: {decimalNumber}");
//             }
//             catch (FormatException)
//             {
//                 // Si ocurre un error en la conversión, mostrar un mensaje
//                 Console.WriteLine("El número ingresado no es válido en formato hexadecimal.");
//             }

//             // Esperar a que el usuario presione una tecla para cerrar
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
    prompt:     .asciz "Ingresa un número hexadecimal (sin 0x): "
    buffer:     .skip   20
    result:     .skip   33
    newline:    .asciz "\n"

.text
.global _start

_start:
    // Print prompt
    mov     x0, #1              // stdout
    adr     x1, prompt
    mov     x2, #43             // length of prompt
    mov     x8, #64             // sys_write
    svc     #0

    // Read input
    mov     x0, #0              // stdin
    adr     x1, buffer
    mov     x2, #20             // buffer size
    mov     x8, #63             // sys_read
    svc     #0

    // Convert hexadecimal to decimal
    adr     x1, buffer
    mov     x2, #0              // result
hex_convert_loop:
    ldrb    w3, [x1]
    cmp     w3, #'\n'
    beq     hex_convert_done

    // Convert hex digit to value
    cmp     w3, #'9'
    bls     is_digit
    
    // Handle A-F or a-f
    cmp     w3, #'F'
    bls     uppercase
    sub     w3, w3, #32         // Convert to uppercase
uppercase:
    sub     w3, w3, #'A'
    add     w3, w3, #10
    b       add_digit

is_digit:
    sub     w3, w3, #'0'

add_digit:
    lsl     x2, x2, #4          // Multiply previous result by 16
    add     x2, x2, x3          // Add current digit
    
    add     x1, x1, #1
    b       hex_convert_loop

hex_convert_done:
    // Convert decimal to ASCII
    adr     x1, result
    mov     x3, #10             // Divisor
    mov     x4, #0              // Digit counter

convert_to_ascii:
    udiv    x5, x2, x3          // Divide by 10
    msub    x6, x5, x3, x2      // Get remainder
    add     x6, x6, #'0'        // Convert to ASCII
    strb    w6, [x1, x4]        // Store digit
    add     x4, x4, #1          // Increment counter
    mov     x2, x5              // Update number
    cbnz    x2, convert_to_ascii

    // Reverse the string
    mov     x5, #0              // Start index
    sub     x6, x4, #1          // End index
reverse_loop:
    cmp     x5, x6
    bhs     reverse_done
    ldrb    w7, [x1, x5]
    ldrb    w8, [x1, x6]
    strb    w8, [x1, x5]
    strb    w7, [x1, x6]
    add     x5, x5, #1
    sub     x6, x6, #1
    b       reverse_loop

reverse_done:
    // Add newline
    strb    w3, [x1, x4]
    mov     w3, #'\n'
    strb    w3, [x1, x4]

    // Print result
    mov     x0, #1              // stdout
    adr     x1, result
    add     x2, x4, #1          // Length including newline
    mov     x8, #64             // sys_write
    svc     #0

exit:
    mov     x0, #0              // return 0
    mov     x8, #93             // sys_exit
    svc     #0

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o hxde.o hxde.s

// Vincular el archivo objeto
// ld -o hxde hxde.o

// Ejecutar el programa
//  ./hxde

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q hxde

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/EQqkv9xDgz1uMIGbeVsqAZ7gV



//----------------------------------------------------------------------------------------------------------------------////
