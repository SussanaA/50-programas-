// ------------------------------------------------------------
// Nombre: Rodríguez Morales Susana Abigail
// Descripción: Este programa toma dos números enteros, los divide,
//              y almacena el resultado en una variable de salida.
// -----------------------------------------------------------------------------------------------------------

// Ejemplo en C# para referencia:
//using System;

//class Program
//{
//    static void Main()
//    {
          // Solicitar al usuario que ingrese el valor de N
//        Console.Write("Ingrese el valor de N: ");
//        string input = Console.ReadLine();

          // Intentar convertir la entrada a un número
//        if (int.TryParse(input, out int N) && N > 0)
//        {
              // Inicializar la variable que almacenará la suma
//            int suma = 0;

              // Sumar los primeros N números naturales
//            for (int i = 1; i <= N; i++)
//            {
//                suma += i;
//            }

              // Mostrar el resultado
//            Console.WriteLine($"La suma de los primeros {N} números naturales es: {suma}");
//        }
//        else
//        {
               // Si la entrada no es válida o N es menor o igual a 0
 
//           Console.WriteLine("Por favor, ingrese un número entero positivo mayor que 0.");
//        }
//    }
//}


//--------------------------------------------------------------------------------------------------

// Código en ensamblador ARM64

.global _start

.section .data
    prompt:     .asciz "Ingrese el valor de N: "
    error_msg:  .asciz "Por favor, ingrese un numero entero positivo mayor que 0.\n"
    result_msg1: .asciz "La suma de los primeros "
    result_msg2: .asciz " numeros naturales es: "
    newline:    .asciz "\n"

.section .bss
    input:      .skip 12     // Buffer para la entrada del usuario
    number:     .skip 4      // Para almacenar N
    sum:        .skip 4      // Para almacenar la suma
    buffer:     .skip 12     // Buffer para convertir números a ASCII

.section .text
_start:
    // Mostrar prompt
    ldr x1, =prompt
    bl print_string

    // Leer entrada
    mov x0, #0          // stdin
    ldr x1, =input      // buffer para entrada
    mov x2, #12         // tamaño máximo a leer
    mov x8, #63         // syscall read
    svc #0

    // Convertir entrada a número
    ldr x1, =input
    bl ascii_to_int
    
    // Verificar si el número es mayor que 0
    cmp w0, #0
    ble error_case
    
    // Guardar N
    str w0, [x3]        // Guardar N
    mov w4, w0          // Copiar N a w4 para el bucle
    mov w5, #0          // Inicializar suma en 0
    mov w6, #1          // Inicializar contador i = 1

sum_loop:
    cmp w6, w4          // Comparar i con N
    bgt print_sum       // Si i > N, terminar
    add w5, w5, w6      // suma += i
    add w6, w6, #1      // i++
    b sum_loop

print_sum:
    // Imprimir mensaje 1
    ldr x1, =result_msg1
    bl print_string
    
    // Imprimir N
    mov w0, w4          // Mover N a w0
    bl print_number
    
    // Imprimir mensaje 2
    ldr x1, =result_msg2
    bl print_string
    
    // Imprimir suma
    mov w0, w5          // Mover suma a w0
    bl print_number
    
    // Imprimir nueva línea
    ldr x1, =newline
    bl print_string
    
    b exit

error_case:
    ldr x1, =error_msg
    bl print_string
    
exit:
    mov x0, #0          // Código de salida
    mov x8, #93         // syscall exit
    svc #0

// Función para convertir ASCII a entero
ascii_to_int:
    mov w0, #0          // Resultado
    mov w2, #10         // Base 10
convert_loop:
    ldrb w3, [x1], #1   // Cargar byte y avanzar puntero
    cmp w3, #0x0a       // Comprobar si es nueva línea
    beq convert_done
    cmp w3, #'0'        // Comprobar si es menor que '0'
    blt convert_done
    cmp w3, #'9'        // Comprobar si es mayor que '9'
    bgt convert_done
    sub w3, w3, #'0'    // Convertir ASCII a número
    mul w0, w0, w2      // Resultado = Resultado * 10
    add w0, w0, w3      // Resultado = Resultado + dígito
    b convert_loop
convert_done:
    ret

// Función para imprimir número
print_number:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    stp x20, x21, [sp, #-16]!
    
    mov w20, w0         // Guardar número original
    ldr x21, =buffer
    add x21, x21, #11   // Ir al final del buffer
    mov w2, #0
    strb w2, [x21]      // Almacenar null terminator
    mov w2, #10         // Divisor = 10

divide_loop:
    sub x21, x21, #1    // Mover puntero
    udiv w3, w20, w2    // w3 = número / 10
    msub w4, w3, w2, w20 // w4 = número % 10
    add w4, w4, #'0'    // Convertir a ASCII
    strb w4, [x21]      // Almacenar dígito
    mov w20, w3         // número = número / 10
    cbnz w20, divide_loop

    mov x1, x21         // Preparar para imprimir
    bl print_string
    
    // Restaurar registros
    ldp x20, x21, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Función para imprimir cadena
print_string:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    
    // Calcular longitud
    mov x2, #0          // Contador de longitud
str_len:
    ldrb w3, [x1, x2]   // Cargar byte
    cbz w3, print_str   // Si es 0, imprimir
    add x2, x2, #1      // Incrementar contador
    b str_len

print_str:
    mov x0, #1          // stdout
    mov x8, #64         // syscall write
    svc #0
    
    // Restaurar registros
    ldp x29, x30, [sp], #16
    ret

//---------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
//  as -o numnat.o numnat.s

// Vincular el archivo objeto
//  ld -o numnat numnat.o

// Ejecutar el programa
//  ./numnat

//---------------------------------------------------------------------------

// Enlace de asciinema
https://asciinema.org/a/mF4RlHdd1v4ylr7juBGr6epyE





-
