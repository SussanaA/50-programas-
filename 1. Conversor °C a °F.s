// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail  
// No. control:** 22210346  
// Nombre del programa:** Convertir temperatura de Celsius a Fahrenheit  

// Descripción de la actividad:
//En esta actividad se elaborará un programa que convierte de grados Celsius a grados Fahrenheit en lenguaje ARM64 y lenguaje C#.

//-------------------------------------------------------------------------------------------------------------------------------------

// Código en C#
//using System;

// class Program
//{
//    static void Main()
//    {
          // Solicitar al usuario que ingrese una temperatura en grados Celsius
//        Console.Write("Ingrese la temperatura en grados Celsius: ");
//        string input = Console.ReadLine();

          // Intentar convertir la entrada a un número
//        if (double.TryParse(input, out double celsius))
//        {
              // Realizar la conversión a grados Fahrenheit
//            double fahrenheit = (celsius * 9 / 5) + 32;

              // Mostrar el resultado
//            Console.WriteLine($"{celsius} grados Celsius equivalen a {fahrenheit} grados Fahrenheit.");
//        }
//        else
//        {
              // Si la entrada no es válida
//            Console.WriteLine("Por favor, ingrese un número válido.");
//        }
//    }
//}

//-----------------------------------------------------------------------------------------------------------------

// Código en ARM64 Assembly
.global _start

.section .data
    prompt:     .asciz "Ingrese la temperatura en grados Celsius: "
    result1:    .asciz "\nLa temperatura en Fahrenheit es: "
    error_msg:  .asciz "\nPor favor, ingrese un número válido.\n"
    newline:    .asciz "\n"
    
.section .bss
    celsius:    .skip 12     // Buffer para entrada Celsius
    fahrenheit: .skip 12     // Buffer para resultado Fahrenheit
    buffer:     .skip 20     // Buffer temporal para conversiones

.section .text
_start:
    // Mostrar prompt
    mov x0, 1               // stdout
    ldr x1, =prompt
    bl print_string

    // Leer entrada Celsius
    mov x0, 0               // stdin
    ldr x1, =celsius
    mov x2, 12             // Tamaño máximo de lectura
    bl read_input

    // Convertir ASCII a número
    ldr x1, =celsius
    bl ascii_to_float
    
    // Verificar si la conversión fue exitosa
    cmp x0, #0
    blt print_error        // Si es negativo, hubo error

    // Realizar la conversión a Fahrenheit
    // Fórmula: (celsius * 9/5) + 32
    mov w3, #9
    mul w0, w0, w3         // celsius * 9
    mov w3, #5
    udiv w0, w0, w3        // / 5
    add w0, w0, #32        // + 32

    // Convertir resultado a string
    ldr x1, =buffer
    bl int_to_ascii

    // Imprimir mensaje de resultado
    mov x0, 1
    ldr x1, =result1
    bl print_string

    // Imprimir resultado
    mov x0, 1
    ldr x1, =buffer
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
    mov x0, 0              // Código de salida
    mov x8, 93             // syscall exit
    svc 0

// Función para convertir ASCII a float (entero en este caso por simplicidad)
ascii_to_float:
    mov w2, #0            // Resultado
    mov w4, #0            // Flag para números negativos
    
    // Verificar si empieza con signo negativo
    ldrb w3, [x1]
    cmp w3, #'-'
    bne parse_digit
    mov w4, #1            // Marcar como negativo
    add x1, x1, #1        // Avanzar al siguiente carácter

parse_digit:
    ldrb w3, [x1], #1     // Cargar un byte y avanzar
    cmp w3, #'\n'         // Verificar fin de línea
    beq done_parsing
    cmp w3, #'0'          // Verificar si es dígito
    blt conversion_error
    cmp w3, #'9'
    bgt conversion_error
    
    sub w3, w3, #'0'      // Convertir a número
    mov w5, #10
    mul w2, w2, w5        // Multiplicar resultado por 10
    add w2, w2, w3        // Añadir nuevo dígito
    b parse_digit

done_parsing:
    // Si es negativo, negar el resultado
    cmp w4, #1
    bne return_result
    neg w2, w2
    
return_result:
    mov w0, w2
    ret

conversion_error:
    mov w0, #-1
    ret

// Función para convertir entero a ASCII
int_to_ascii:
    mov x2, x1            // Guardar dirección inicial
    mov x3, x1            // Dirección de trabajo
    
    // Manejar signo negativo
    cmp w0, #0
    bge positive_number
    neg w0, w0            // Hacer positivo
    mov w4, #'-'
    strb w4, [x3], #1     // Almacenar signo negativo
    
positive_number:
    add x3, x3, #11       // Mover al final del buffer
    mov w4, #0
    strb w4, [x3]         // Null terminator
    sub x3, x3, #1        // Retroceder una posición
    
    mov w4, #10           // Divisor
    
convert_loop:
    udiv w5, w0, w4       // Dividir por 10
    msub w6, w5, w4, w0   // Obtener remainder
    add w6, w6, #'0'      // Convertir a ASCII
    strb w6, [x3], #-1    // Almacenar y retroceder
    mov w0, w5            // Actualizar número
    cbnz w0, convert_loop // Continuar si no es cero
    
    // Mover resultado al inicio del buffer
    add x3, x3, #1        // Avanzar a primer dígito
    mov x0, x2            // Retornar dirección inicial
    
copy_loop:
    ldrb w4, [x3], #1
    strb w4, [x2], #1
    cbnz w4, copy_loop
    
    ret

// Función para imprimir string
print_string:
    mov x2, #0            // Contador de longitud
length_loop:
    ldrb w3, [x1, x2]    // Cargar byte
    cbz w3, print_now     // Si es 0, terminar
    add x2, x2, #1       // Incrementar contador
    b length_loop
print_now:
    mov x8, #64          // syscall write
    svc 0
    ret

// Función para leer input
read_input:
    mov x8, #63          // syscall read
    svc 0
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o conv.o conv.cs

// Vincular el archivo objeto
ld -o conv conv.o

// Ejecutar el programa
//  ./conv

//---------------------------------------------------------------------------------------------------------------------------------------

// Enlace de asciinema

https://asciinema.org/a/0YxU1tf5KfKF6Fas9zUFWx2Ro






-


