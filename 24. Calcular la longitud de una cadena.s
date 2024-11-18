//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#
// using System;
// 
// namespace LongitudDeCadena
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese una cadena
//             Console.Write("Ingrese una cadena: ");
//             string cadena = Console.ReadLine();
// 
//             // Calcular la longitud de la cadena
//             int longitud = cadena.Length;
// 
//             // Mostrar el resultado
//             Console.WriteLine($"La longitud de la cadena ingresada es: {longitud}");
// 
//             // Esperar a que el usuario presione una tecla para finalizar
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }
//     }
// }

//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.data
    prompt:     .ascii "Ingrese una cadena: "
    promptLen = . - prompt
    result:     .ascii "La longitud de la cadena ingresada es: "
    resultLen = . - result
    exit_msg:   .ascii "Presione cualquier tecla para salir...\n"
    exit_msgLen = . - exit_msg
    buffer:     .skip 100
    newline:    .ascii "\n"

.text
.global _start

_start:
    // Imprimir prompt
    mov x0, #1                  // fd = 1 (stdout)
    adr x1, prompt             // dirección del mensaje
    mov x2, promptLen          // longitud del mensaje
    mov x8, #64                // syscall write
    svc #0

    // Leer entrada del usuario
    mov x0, #0                  // fd = 0 (stdin)
    adr x1, buffer             // buffer para almacenar la entrada
    mov x2, #100               // tamaño máximo a leer
    mov x8, #63                // syscall read
    svc #0
    
    // Guardar la longitud leída
    mov x19, x0                // x19 = longitud de la cadena (sin contar \n)
    sub x19, x19, #1           // restar 1 para quitar el \n

    // Imprimir mensaje de resultado
    mov x0, #1                  // fd = 1 (stdout)
    adr x1, result             // dirección del mensaje
    mov x2, resultLen          // longitud del mensaje
    mov x8, #64                // syscall write
    svc #0

    // Convertir longitud a ASCII e imprimir
    mov x20, x19               // copiar longitud para conversión
    adr x21, buffer            // usar buffer para conversion
    mov x22, #0                // contador de dígitos
    
convert_loop:
    mov x23, #10
    udiv x24, x20, x23        // dividir por 10
    msub x25, x24, x23, x20   // obtener residuo
    add x25, x25, #48         // convertir a ASCII
    strb w25, [x21, x22]      // guardar dígito
    add x22, x22, #1          // incrementar contador
    mov x20, x24              // actualizar número
    cbnz x20, convert_loop    // continuar si no es cero

print_digits:
    // Imprimir dígitos en orden inverso
    mov x0, #1                 // fd = 1 (stdout)
    mov x2, #1                 // imprimir un carácter a la vez
    mov x8, #64                // syscall write
print_loop:
    sub x22, x22, #1          // decrementar contador
    add x1, x21, x22          // calcular dirección del dígito
    svc #0                    // llamar write
    cbnz x22, print_loop      // continuar si hay más dígitos

    // Imprimir nueva línea
    mov x0, #1                 // fd = 1 (stdout)
    adr x1, newline           // dirección de nueva línea
    mov x2, #1                // longitud = 1
    mov x8, #64               // syscall write
    svc #0

    // Imprimir mensaje de salida
    mov x0, #1                 // fd = 1 (stdout)
    adr x1, exit_msg          // dirección del mensaje
    mov x2, exit_msgLen       // longitud del mensaje
    mov x8, #64               // syscall write
    svc #0

    // Esperar tecla
    mov x0, #0                 // fd = 0 (stdin)
    adr x1, buffer            // buffer temporal
    mov x2, #1                // leer un carácter
    mov x8, #63               // syscall read
    svc #0

    // Salir del programa
    mov x0, #0                 // código de salida = 0
    mov x8, #93                // syscall exit
    svc #0

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o long.o long.s

// Vincular el archivo objeto
// ld -o long long.o

// Ejecutar el programa
//  ./long

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q long

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/8ueO2D0xbWXANq5nAu3fdl6BQ




//----------------------------------------------------------------------------------------------------------------------
