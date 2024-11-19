//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;

// namespace BitOperations
// {
//     class Program
//     {
//         // Método para establecer un bit en una posición específica (ponerlo a 1)
//         static int SetBit(int number, int position)
//         {
//             return number | (1 << position);
//         }

//         // Método para alternar un bit en una posición específica (invertirlo)
//         static int ToggleBit(int number, int position)
//         {
//             return number ^ (1 << position);
//         }

//         // Método para borrar un bit en una posición específica (ponerlo a 0)
//         static int ClearBit(int number, int position)
//         {
//             return number & ~(1 << position);
//         }

//         static void Main(string[] args)
//         {
//             int number = 0;  // Número inicial (todos los bits en 0)

//             Console.WriteLine("Número inicial en binario: " + Convert.ToString(number, 2).PadLeft(32, '0'));

//             // Establecer el bit en la posición 3 (contando desde 0)
//             number = SetBit(number, 3);
//             Console.WriteLine("Después de establecer el bit en la posición 3: " + Convert.ToString(number, 2).PadLeft(32, '0'));

//             // Alternar el bit en la posición 3
//             number = ToggleBit(number, 3);
//             Console.WriteLine("Después de alternar el bit en la posición 3: " + Convert.ToString(number, 2).PadLeft(32, '0'));

//             // Establecer el bit en la posición 2
//             number = SetBit(number, 2);
//             Console.WriteLine("Después de establecer el bit en la posición 2: " + Convert.ToString(number, 2).PadLeft(32, '0'));

//             // Borrar el bit en la posición 2
//             number = ClearBit(number, 2);
//             Console.WriteLine("Después de borrar el bit en la posición 2: " + Convert.ToString(number, 2).PadLeft(32, '0'));

//             // Final
//             Console.WriteLine("Número final en binario: " + Convert.ToString(number, 2).PadLeft(32, '0'));
//         }
//     }
// }

//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
    inicial_msg:     .asciz "Ingrese un número inicial: "
    set_bit_msg:     .asciz "Ingrese la posición del bit a establecer (0-31): "
    clear_bit_msg:   .asciz "Ingrese la posición del bit a borrar (0-31): "
    formato_int:     .asciz "%d"
    binario_msg:     .asciz "Número en binario: %032b\n"
    result_msg:      .asciz "Resultado después de operaciones: %032b\n"

.bss
    numero:  .skip 4   // Espacio para almacenar el número
    posicion: .skip 4  // Espacio para almacenar la posición del bit

.text
.global main
.extern printf
.extern scanf

SetBit:
    mov x2, #1
    lsl x2, x2, x1
    orr x0, x0, x2
    ret

ToggleBit:
    mov x2, #1
    lsl x2, x2, x1
    eor x0, x0, x2
    ret

ClearBit:
    mov x2, #1
    lsl x2, x2, x1
    mvn x2, x2
    and x0, x0, x2
    ret

main:
    // Prólogo estándar
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Imprimir mensaje para ingresar número inicial
    adr x0, inicial_msg
    bl printf

    // Leer número inicial
    adr x0, formato_int
    adr x1, numero
    bl scanf

    // Cargar número ingresado
    ldr x19, [x19, #numero]

    // Mostrar número inicial en binario
    adr x0, binario_msg
    mov x1, x19
    bl printf

    // Imprimir mensaje para establecer bit
    adr x0, set_bit_msg
    bl printf

    // Leer posición del bit
    adr x0, formato_int
    adr x1, posicion
    bl scanf

    // Cargar posición del bit
    ldr x20, [x19, #posicion]

    // Establecer bit
    mov x0, x19
    mov x1, x20
    bl SetBit
    mov x19, x0

    // Mostrar resultado después de establecer bit
    adr x0, result_msg
    mov x1, x19
    bl printf

    // Imprimir mensaje para borrar bit
    adr x0, clear_bit_msg
    bl printf

    // Leer posición del bit a borrar
    adr x0, formato_int
    adr x1, posicion
    bl scanf

    // Cargar posición del bit
    ldr x20, [x19, #posicion]

    // Borrar bit
    mov x0, x19
    mov x1, x20
    bl ClearBit
    mov x19, x0

    // Mostrar resultado final
    adr x0, result_msg
    mov x1, x19
    bl printf

    // Epílogo estándar
    ldp x29, x30, [sp], #16
    mov x0, #0
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o aeb.o aeb.s

// Vincular el archivo objeto
// ld -o aeb aeb.o

// Ejecutar el programa
//  ./aeb

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q aeb

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/kiweaghX3kz2YdDJqoXNoAskD




//----------------------------------------------------------------------------------------------------------------------
