//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace SegundoElementoMasGrande
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Definir un arreglo de números
//             int[] numeros = { 3, 5, 7, 2, 8, 6, 1 };

//             // Llamar al método para encontrar el segundo elemento más grande
//             int segundoMasGrande = EncontrarSegundoMasGrande(numeros);

//             // Mostrar el resultado
//             Console.WriteLine("El segundo elemento más grande es: " + segundoMasGrande);

//             // Esperar a que el usuario presione una tecla para cerrar
//             Console.ReadKey();
//         }

//         static int EncontrarSegundoMasGrande(int[] arreglo)
//         {
//             if (arreglo.Length < 2)
//             {
//                 throw new InvalidOperationException("El arreglo debe contener al menos dos elementos.");
//             }

//             // Inicializar los dos números más grandes
//             int primeroMasGrande = int.MinValue;
//             int segundoMasGrande = int.MinValue;

//             // Recorrer el arreglo para encontrar el segundo más grande
//             foreach (int numero in arreglo)
//             {
//                 if (numero > primeroMasGrande)
//                 {
//                     // Si encontramos un número más grande, el actual más grande pasa a segundo más grande
//                     segundoMasGrande = primeroMasGrande;
//                     primeroMasGrande = numero;
//                 }
//                 else if (numero > segundoMasGrande && numero != primeroMasGrande)
//                 {
//                     // Si el número no es igual al más grande y es mayor que el segundo más grande
//                     segundoMasGrande = numero;
//                 }
//             }

//             return segundoMasGrande;
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
msg1:    .ascii "Arreglo: "
len1 = . - msg1
msg2:    .ascii "\nEl segundo elemento mas grande es: "
len2 = . - msg2
array:   .quad 3, 5, 7, 2, 8, 6, 1    // Arreglo de números
size:    .quad 7                          // Tamaño del arreglo
buffer:  .skip 32                         // Buffer para conversión
space:   .ascii " "
newline: .ascii "\n"
max1:    .quad 0                          // Primer máximo
max2:    .quad 0                          // Segundo máximo

.section .text
_start:
    // Mostrar mensaje inicial
    mov x0, #1
    ldr x1, =msg1
    mov x2, len1
    mov x8, #64
    svc #0

    // Mostrar arreglo
    bl mostrar_arreglo

    // Encontrar segundo máximo
    bl encontrar_segundo_max

    // Mostrar mensaje resultado
    mov x0, #1
    ldr x1, =msg2
    mov x2, len2
    mov x8, #64
    svc #0

    // Mostrar resultado
    ldr x21, =max2
    ldr x21, [x21]
    bl mostrar_numero

    // Nueva línea
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0

    // Salir
    mov x0, #0
    mov x8, #93
    svc #0

encontrar_segundo_max:
    str x30, [sp, #-16]!           // Guardar enlace retorno

    // Inicializar max1 y max2 con primer elemento
    ldr x9, =array
    ldr x10, [x9]                  // Primer elemento
    ldr x11, =max1
    str x10, [x11]                 // max1 = primer elemento
    ldr x11, =max2
    str x10, [x11]                 // max2 = primer elemento

    // Inicializar índice
    mov x12, #1                    // Empezar desde segundo elemento
    ldr x13, =size
    ldr x13, [x13]                 // Cargar tamaño

buscar_loop:
    cmp x12, x13                   // Verificar si terminamos
    beq fin_buscar

    // Cargar elemento actual
    ldr x14, [x9, x12, lsl #3]     // Elemento actual
    ldr x15, =max1
    ldr x15, [x15]                 // Cargar max1

    // Comparar con max1
    cmp x14, x15
    ble comparar_max2              // Si es menor o igual, comparar con max2
    
    // Actualizar máximos
    ldr x16, =max2
    str x15, [x16]                 // max2 = antiguo max1
    ldr x16, =max1
    str x14, [x16]                 // max1 = elemento actual
    b siguiente

comparar_max2:
    ldr x15, =max2
    ldr x15, [x15]                 // Cargar max2
    cmp x14, x15
    ble siguiente                  // Si es menor o igual, siguiente
    
    // Actualizar max2
    ldr x16, =max2
    str x14, [x16]                 // max2 = elemento actual

siguiente:
    add x12, x12, #1              // Siguiente elemento
    b buscar_loop

fin_buscar:
    ldr x30, [sp], #16
    ret

mostrar_arreglo:
    str x30, [sp, #-16]!          // Guardar enlace retorno
    
    mov x9, #0                    // Índice
    ldr x10, =array              // Base del arreglo
    ldr x11, =size              // Tamaño
    ldr x11, [x11]

mostrar_loop:
    cmp x9, x11
    beq fin_mostrar
    
    ldr x21, [x10, x9, lsl #3]
    bl mostrar_numero
    
    // Mostrar espacio
    mov x0, #1
    ldr x1, =space
    mov x2, #1
    mov x8, #64
    svc #0
    
    add x9, x9, #1
    b mostrar_loop

fin_mostrar:
    ldr x30, [sp], #16
    ret

mostrar_numero:
    str x30, [sp, #-16]!          // Guardar enlace retorno
    
    // Preparar para conversión
    mov x22, x21                  // Copia del número
    ldr x23, =buffer             // Buffer
    mov x24, #0                  // Contador de dígitos

convertir_loop:
    mov x25, #10
    udiv x26, x22, x25           // Dividir por 10
    msub x27, x26, x25, x22      // Obtener resto
    add x27, x27, #'0'           // Convertir a ASCII
    strb w27, [x23, x24]         // Guardar dígito
    add x24, x24, #1             // Incrementar contador
    mov x22, x26                 // Actualizar número
    cbnz x22, convertir_loop
    
    // Invertir dígitos
    mov x25, #0                  // Inicio
    sub x26, x24, #1             // Fin

invertir_loop:
    cmp x25, x26
    bge mostrar_digitos
    
    ldrb w27, [x23, x25]         // Cargar byte inicio
    ldrb w28, [x23, x26]         // Cargar byte fin
    strb w28, [x23, x25]         // Guardar fin en inicio
    strb w27, [x23, x26]         // Guardar inicio en fin
    
    add x25, x25, #1
    sub x26, x26, #1
    b invertir_loop

mostrar_digitos:
    mov x0, #1                   // stdout
    mov x1, x23                  // buffer
    mov x2, x24                  // longitud
    mov x8, #64                  // syscall write
    svc #0
    
    ldr x30, [sp], #16
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o seg.o seg.s

// Vincular el archivo objeto
// ld -o seg seg.o

// Ejecutar el programa
//  ./seg

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q seg

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema


https://asciinema.org/a/zBIo4USJyW1dpXh3gHCouMZun


//----------------------------------------------------------------------------------------------------------------------//
