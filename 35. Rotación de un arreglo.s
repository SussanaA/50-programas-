//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace RotacionArreglo
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar el tamaño del arreglo
//             Console.Write("Ingrese el tamaño del arreglo: ");
//             int n = int.Parse(Console.ReadLine());

//             // Crear el arreglo y llenarlo con números
//             int[] arreglo = new int[n];
//             Console.WriteLine("Ingrese los elementos del arreglo:");
//             for (int i = 0; i < n; i++)
//             {
//                 Console.Write($"Elemento {i + 1}: ");
//                 arreglo[i] = int.Parse(Console.ReadLine());
//             }

//             // Solicitar el número de rotaciones
//             Console.Write("Ingrese el número de rotaciones: ");
//             int rotaciones = int.Parse(Console.ReadLine());

//             // Realizar la rotación
//             RotarArreglo(arreglo, rotaciones);

//             // Mostrar el arreglo después de las rotaciones
//             Console.WriteLine("El arreglo después de las rotaciones es:");
//             foreach (var item in arreglo)
//             {
//                 Console.Write(item + " ");
//             }
//         }

//         static void RotarArreglo(int[] arreglo, int rotaciones)
//         {
//             int n = arreglo.Length;
//             rotaciones = rotaciones % n;  // En caso de que las rotaciones sean mayores que el tamaño del arreglo
//             if (rotaciones == 0)
//                 return;

//             // Realizamos la rotación
//             InvertirArreglo(arreglo, 0, n - 1);  // Invertimos todo el arreglo
//             InvertirArreglo(arreglo, 0, rotaciones - 1);  // Invertimos la parte que se mueve al final
//             InvertirArreglo(arreglo, rotaciones, n - 1);  // Invertimos la parte restante
//         }

//         static void InvertirArreglo(int[] arreglo, int inicio, int fin)
//         {
//             while (inicio < fin)
//             {
//                 int temp = arreglo[inicio];
//                 arreglo[inicio] = arreglo[fin];
//                 arreglo[fin] = temp;
//                 inicio++;
//                 fin--;
//             }
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.global _start

.section .data
msg1:    .ascii "Arreglo original: "
len1 = . - msg1
msg2:    .ascii "\nRotacion izquierda: "
len2 = . - msg2
msg3:    .ascii "\nRotacion derecha: "
len3 = . - msg3
array:   .quad 78, 10, 12, 33, 51    // Arreglo original
size:    .quad 5                // Tamaño del arreglo
pos:     .quad 3                // Posiciones a rotar
buffer:  .skip 32               // Buffer para conversión
space:   .ascii " "
newline: .ascii "\n"

.section .text
_start:
    // Mostrar arreglo original
    mov x0, #1
    ldr x1, =msg1
    mov x2, len1
    mov x8, #64
    svc #0

    bl mostrar_arreglo

    // Rotar izquierda
    bl rotar_izquierda
    
    // Mostrar resultado rotación izquierda
    mov x0, #1
    ldr x1, =msg2
    mov x2, len2
    mov x8, #64
    svc #0

    bl mostrar_arreglo

    // Restaurar arreglo original
    bl restaurar_original
    
    // Rotar derecha
    bl rotar_derecha
    
    // Mostrar resultado rotación derecha
    mov x0, #1
    ldr x1, =msg3
    mov x2, len3
    mov x8, #64
    svc #0

    bl mostrar_arreglo

    // Nueva línea final
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0

    // Salir
    mov x0, #0
    mov x8, #93
    svc #0

rotar_izquierda:
    str x30, [sp, #-16]!        // Guardar enlace retorno
    ldr x9, =pos               // Cargar número de posiciones
    ldr x9, [x9]
    mov x10, #0                // Contador de rotaciones
    ldr x11, =size            // Cargar tamaño del arreglo
    ldr x11, [x11]

loop_izq:
    cmp x10, x9                // Verificar si terminamos rotaciones
    beq fin_rotar_izq
    
    // Guardar primer elemento
    ldr x12, =array
    ldr x13, [x12]             // Guardar primer elemento
    
    // Mover elementos
    mov x14, #0                // Índice actual
mover_izq:
    add x15, x14, #1           // Siguiente posición
    cmp x15, x11               // Comparar con tamaño
    beq guardar_temp_izq
    
    ldr x16, [x12, x15, lsl #3]  // Cargar siguiente
    str x16, [x12, x14, lsl #3]  // Guardar en actual
    
    add x14, x14, #1
    b mover_izq
    
guardar_temp_izq:
    sub x15, x11, #1           // Última posición
    str x13, [x12, x15, lsl #3]  // Guardar primer elemento al final
    
    add x10, x10, #1
    b loop_izq
    
fin_rotar_izq:
    ldr x30, [sp], #16
    ret

rotar_derecha:
    str x30, [sp, #-16]!
    ldr x9, =pos              // Cargar posiciones
    ldr x9, [x9]
    mov x10, #0               // Contador
    ldr x11, =size           // Cargar tamaño
    ldr x11, [x11]

loop_der:
    cmp x10, x9
    beq fin_rotar_der
    
    // Guardar último elemento
    ldr x12, =array
    sub x13, x11, #1          // Índice último elemento
    ldr x14, [x12, x13, lsl #3]  // Guardar último elemento
    
    // Mover elementos
mover_der:
    cmp x13, #0
    beq guardar_temp_der
    
    sub x15, x13, #1
    ldr x16, [x12, x15, lsl #3]
    str x16, [x12, x13, lsl #3]
    
    sub x13, x13, #1
    b mover_der
    
guardar_temp_der:
    str x14, [x12]            // Guardar último al inicio
    
    add x10, x10, #1
    b loop_der
    
fin_rotar_der:
    ldr x30, [sp], #16
    ret

mostrar_arreglo:
    str x30, [sp, #-16]!
    mov x9, #0                // Índice
    ldr x10, =array          // Base del arreglo
    ldr x11, =size          // Tamaño
    ldr x11, [x11]

mostrar_loop:
    cmp x9, x11
    beq fin_mostrar
    
    ldr x12, [x10, x9, lsl #3]
    
    // Convertir número a string
    ldr x13, =buffer
    mov x14, x12
    mov x15, #0              // Contador dígitos

convertir:
    mov x16, #10
    udiv x17, x14, x16
    msub x18, x17, x16, x14
    add x18, x18, #'0'
    strb w18, [x13, x15]
    add x15, x15, #1
    mov x14, x17
    cbnz x14, convertir
    
    // Mostrar número
    mov x0, #1
    mov x1, x13
    mov x2, x15
    mov x8, #64
    svc #0
    
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

restaurar_original:
    str x30, [sp, #-16]!
    ldr x9, =array           // Base del arreglo
    mov x10, #1              // Valor inicial
    ldr x11, =size          // Tamaño
    ldr x11, [x11]
    mov x12, #0              // Índice

restaurar_loop:
    cmp x12, x11
    beq fin_restaurar
    str x10, [x9, x12, lsl #3]
    add x10, x10, #1
    add x12, x12, #1
    b restaurar_loop

fin_restaurar:
    ldr x30, [sp], #16
    ret

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o rot.o rot.s

// Vincular el archivo objeto
// ld -o rot rot.o

// Ejecutar el programa
//  ./rot

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q rot

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/8Ki6rCdXjrytdIhXCd1XMOS6u



//----------------------------------------------------------------------------------------------------------------------//
