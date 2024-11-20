//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace NumeroArmstrong
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese un número
//             Console.Write("Ingresa un número: ");
//             int numero = int.Parse(Console.ReadLine());

//             // Llamar a la función para verificar si es un número Armstrong
//             if (EsNumeroArmstrong(numero))
//             {
//                 Console.WriteLine($"{numero} es un número Armstrong.");
//             }
//             else
//             {
//                 Console.WriteLine($"{numero} no es un número Armstrong.");
//             }

//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         // Función para verificar si un número es un número Armstrong
//         static bool EsNumeroArmstrong(int numero)
//         {
//             // Convertir el número a una cadena para contar los dígitos
//             string numeroStr = numero.ToString();
//             int cantidadDigitos = numeroStr.Length;

//             int suma = 0;
//             int numeroOriginal = numero;

//             // Calcular la suma de los dígitos elevados a la potencia de la cantidad de dígitos
//             while (numero > 0)
//             {
//                 int digito = numero % 10; // Obtener el último dígito
//                 suma += (int)Math.Pow(digito, cantidadDigitos); // Elevar el dígito a la cantidad de dígitos
//                 numero /= 10; // Eliminar el último dígito
//             }

//             // Verificar si la suma es igual al número original
//             return suma == numeroOriginal;
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.arch armv8-a
    .global _start

    .section ".data"
    msg_input:    .ascii "Ingrese un numero: "
    len_input    = . - msg_input
    msg_es:       .ascii "Es un numero Armstrong\n"
    len_es       = . - msg_es
    msg_no_es:    .ascii "No es un numero Armstrong\n"
    len_no_es    = . - msg_no_es
    buffer:       .skip 20
    numero:       .quad 0

    .section ".text"
    .align 2
_start:
    // Guardar el frame pointer
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Imprimir mensaje de entrada
    mov     x0, #1                      // fd = 1 (stdout)
    ldr     x1, =msg_input             // mensaje
    mov     x2, #len_input             // longitud
    mov     x8, #64                    // syscall write
    svc     #0

    // Leer número
    mov     x0, #0                      // fd = 0 (stdin)
    ldr     x1, =buffer                // buffer
    mov     x2, #20                    // tamaño máximo
    mov     x8, #63                    // syscall read
    svc     #0

    // Convertir string a número
    ldr     x1, =buffer
    bl      atoi
    mov     x19, x0                    // Guardar número original

    // Calcular número de dígitos
    mov     x1, x0
    bl      contar_digitos
    mov     x20, x0                    // x20 = número de dígitos

    // Calcular suma de potencias
    mov     x0, x19
    mov     x1, x20
    bl      calcular_suma_potencias

    // Comparar resultado con número original
    cmp     x0, x19
    b.ne    no_es_armstrong

es_armstrong:
    mov     x0, #1                      // fd = 1 (stdout)
    ldr     x1, =msg_es                // mensaje
    mov     x2, #len_es                // longitud
    mov     x8, #64                    // syscall write
    svc     #0
    b       exit

no_es_armstrong:
    mov     x0, #1                      // fd = 1 (stdout)
    ldr     x1, =msg_no_es             // mensaje
    mov     x2, #len_no_es             // longitud
    mov     x8, #64                    // syscall write
    svc     #0

exit:
    // Restaurar frame pointer y retornar
    ldp     x29, x30, [sp], #16
    mov     x0, #0                      // código de retorno
    mov     x8, #93                    // syscall exit
    svc     #0

// Función para convertir ASCII a entero (atoi)
atoi:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    
    mov     x0, #0                      // resultado
    mov     x2, #10                    // base 10
atoi_loop:
    ldrb    w3, [x1], #1               // cargar siguiente byte
    sub     w3, w3, #'0'               // convertir ASCII a número
    cmp     w3, #9                     // verificar si es dígito válido
    b.gt    atoi_done
    cmp     w3, #0
    b.lt    atoi_done
    mul     x0, x0, x2                 // resultado *= 10
    add     x0, x0, x3                 // resultado += dígito
    b       atoi_loop
atoi_done:
    ldp     x29, x30, [sp], #16
    ret

// Función para contar dígitos
contar_digitos:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    
    mov     x2, #0                     // Contador
    mov     x3, #10                    // Divisor
loop_contar:
    add     x2, x2, #1                // Incrementar contador
    udiv    x1, x1, x3                // Dividir por 10
    cbnz    x1, loop_contar           // Si no es cero, continuar
    mov     x0, x2                    // Retornar contador
    
    ldp     x29, x30, [sp], #16
    ret

// Función para calcular suma de potencias
calcular_suma_potencias:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    mov     x21, x0                    // Número original
    mov     x22, x1                    // Exponente (número de dígitos)
    mov     x23, #0                    // Suma total
    mov     x24, #10                   // Divisor

loop_suma:
    udiv    x25, x21, x24             // División por 10
    msub    x26, x25, x24, x21        // Obtener último dígito
    
    // Calcular potencia
    mov     x0, x26                    // Base
    mov     x1, x22                    // Exponente
    bl      potencia
    
    add     x23, x23, x0               // Sumar a total
    
    mov     x21, x25                   // Actualizar número
    cbnz    x21, loop_suma            // Si no es cero, continuar
    
    mov     x0, x23                    // Retornar suma
    ldp     x29, x30, [sp], #16
    ret

// Función para calcular potencia
potencia:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    
    mov     x2, #1                     // Resultado
    cbz     x1, fin_potencia          // Si exponente es 0, retornar 1
loop_potencia:
    mul     x2, x2, x0                // Multiplicar por base
    sub     x1, x1, #1                // Decrementar exponente
    cbnz    x1, loop_potencia        // Si no es cero, continuar
fin_potencia:
    mov     x0, x2                    // Retornar resultado
    ldp     x29, x30, [sp], #16
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o arm.o arm.s

// Vincular el archivo objeto
// ld -o arm arm.o

// Ejecutar el programa
//  ./arm

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q arm

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/JDujPFSX65yWb6dpahzw4e5Vf



//----------------------------------------------------------------------------------------------------------------------//
