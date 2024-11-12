// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//-------------------------------------------------------------------------------------------------------------------------------------

/// Código de referencia en C#

// using System;

// namespace InvertirCadena
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese una cadena
//             Console.Write("Ingrese una cadena de texto: ");
//             string texto = Console.ReadLine();

//             // Invertir la cadena
//             string textoInvertido = InvertirTexto(texto);

//             // Mostrar el resultado
//             Console.WriteLine("La cadena invertida es: " + textoInvertido);
//         }

//         // Método para invertir una cadena de texto
//         static string InvertirTexto(string texto)
//         {
//             // Convertir la cadena en un arreglo de caracteres
//             char[] caracteres = texto.ToCharArray();
//             // Invertir el arreglo
//             Array.Reverse(caracteres);
//             // Convertir el arreglo invertido en una cadena
//             return new string(caracteres);
//         }
//     }
// }

//-----------------------------------------------------------------------------------------------------------------

// Código en ARM64 Assembly

.global _start

.section .data
    prompt:     .asciz "Ingrese una cadena de texto: "
    result_msg: .asciz "La cadena invertida es: "
    newline:    .asciz "\n"

.section .bss
    input_buffer:   .skip 100    // Buffer para almacenar la entrada del usuario
    output_buffer:  .skip 100    // Buffer para almacenar la cadena invertida
    buffer_size:    .skip 8      // Para almacenar la longitud de la cadena

.section .text
_start:
    // Mostrar prompt
    mov x0, 1                // stdout
    ldr x1, =prompt         // mensaje
    bl print_string

    // Leer la entrada del usuario
    mov x0, 0                // stdin
    ldr x1, =input_buffer   // buffer destino
    mov x2, 100             // tamaño máximo a leer
    bl read_input

    // Guardar la longitud de la cadena (sin contar newline)
    sub x0, x0, #1          // Restar 1 para quitar el newline
    ldr x1, =buffer_size
    str x0, [x1]            // Guardar longitud

    // Invertir la cadena
    bl reverse_string

    // Mostrar mensaje de resultado
    mov x0, 1
    ldr x1, =result_msg
    bl print_string

    // Mostrar la cadena invertida
    mov x0, 1
    ldr x1, =output_buffer
    bl print_string

    // Mostrar newline
    mov x0, 1
    ldr x1, =newline
    bl print_string

    // Salir del programa
    mov x0, 0
    mov x8, 93              // syscall exit
    svc 0

// Función para invertir la cadena
reverse_string:
    // Preparar registros
    ldr x0, =input_buffer   // Origen
    ldr x1, =output_buffer  // Destino
    ldr x2, =buffer_size
    ldr x2, [x2]            // Longitud de la cadena
    
    // Calcular la dirección del último carácter
    add x0, x0, x2         // Apuntar al último carácter
    sub x0, x0, #1         // Ajustar para el índice base 0

reverse_loop:
    // Verificar si hemos terminado
    cmp x2, #0
    ble reverse_done
    
    // Copiar carácter
    ldrb w3, [x0]          // Cargar carácter de la entrada
    strb w3, [x1]          // Guardar en la salida
    
    // Actualizar punteros y contador
    sub x0, x0, #1         // Mover puntero de entrada hacia atrás
    add x1, x1, #1         // Mover puntero de salida hacia adelante
    sub x2, x2, #1         // Decrementar contador
    
    b reverse_loop

reverse_done:
    // Agregar null terminator
    mov w3, #0
    strb w3, [x1]
    ret

// Función para imprimir cadenas
print_string:
    mov x2, #0             // Contador de longitud
length_loop:
    ldrb w3, [x1, x2]     // Cargar byte
    cbz w3, print_str     // Si es 0, terminar conteo
    add x2, x2, #1        // Incrementar contador
    b length_loop

print_str:
    mov x8, #64           // syscall write
    svc 0
    ret

// Función para leer entrada
read_input:
    mov x8, #63           // syscall read
    svc 0
    ret

//--------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o inv.o inv.s

// Vincular el archivo objeto
// ld -o inv inv.o

// Ejecutar el programa
//  ./inv

//---------------------------------------------------------------------------------------------------------------------------------------

// Enlace de asciinema
https://asciinema.org/a/Z3d6zfbk1ze61DzfoqSkmTleL




-
