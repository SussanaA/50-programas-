//-----------------------------------------------------------------------------------------------------------------------
// Instituto Tecnológico de Tijuana
// Departamento de Sistemas y Computación
// Materia: Lenguajes de Interfaz

// Nombre del alumno:** Rodríguez Morales Susana Abigail
// No. control:** 22210346

//----------------------------------------------------------------------------------------------------------------------
// Código en C#

// using System;

// namespace PrefijoComun
// {
//     class Program
//     {
//         static void Main(string[] args)
//         {
//             // Solicitar al usuario que ingrese las cadenas
//             Console.Write("Ingrese el número de cadenas: ");
//             int n = int.Parse(Console.ReadLine());

//             string[] cadenas = new string[n];

//             // Leer las cadenas
//             for (int i = 0; i < n; i++)
//             {
//                 Console.Write($"Ingrese la cadena {i + 1}: ");
//                 cadenas[i] = Console.ReadLine();
//             }

//             // Llamar al método para encontrar el prefijo común más largo
//             string prefijoComun = EncontrarPrefijoComunMasLargo(cadenas);

//             // Mostrar el resultado
//             if (string.IsNullOrEmpty(prefijoComun))
//             {
//                 Console.WriteLine("No hay un prefijo común.");
//             }
//             else
//             {
//                 Console.WriteLine("El prefijo común más largo es: " + prefijoComun);
//             }

//             // Esperar a que el usuario presione una tecla para salir
//             Console.WriteLine("Presione cualquier tecla para salir...");
//             Console.ReadKey();
//         }

//         // Método que encuentra el prefijo común más largo
//         static string EncontrarPrefijoComunMasLargo(string[] cadenas)
//         {
//             if (cadenas == null || cadenas.Length == 0)
//                 return "";

//             // Suponemos que el prefijo más largo es la primera cadena
//             string prefijoComun = cadenas[0];

//             // Comparamos el prefijo con cada cadena
//             foreach (string cadena in cadenas)
//             {
//                 // Compara el prefijo con la cadena actual
//                 while (cadena.IndexOf(prefijoComun) != 0)
//                 {
//                     // Recorta el último carácter del prefijo hasta encontrar coincidencia
//                     prefijoComun = prefijoComun.Substring(0, prefijoComun.Length - 1);

//                     // Si no hay prefijo común, retornamos una cadena vacía
//                     if (prefijoComun == "")
//                         return "";
//                 }
//             }

//             return prefijoComun;
//         }
//     }
// }


//----------------------------------------------------------------------------------------------------------------------
// Código en ensamblador ARM64

.arch armv8-a
    .global _start

    .section ".data"
    msg_input:    .ascii "Cuantas cadenas va a ingresar?: "
    len_input    = . - msg_input
    
    msg_str:      .ascii "Ingrese cadena "
    len_msg_str  = . - msg_str
    
    msg_result:   .ascii "\nPrefijo comun mas largo: "
    len_result   = . - msg_result
    
    newline:      .ascii "\n"
    len_newline  = . - newline

    buffer:       .skip 100
    strings:      .skip 1000
    result:       .skip 100
    num_strings:  .quad 0

    .section ".text"
    .align 2
_start:
    // Pedir número de cadenas
    mov     x0, #1              // stdout
    ldr     x1, =msg_input
    mov     x2, #len_input
    mov     x8, #64            // syscall write
    svc     #0

    // Leer número
    mov     x0, #0              // stdin
    ldr     x1, =buffer
    mov     x2, #5
    mov     x8, #63            // syscall read
    svc     #0

    // Convertir a número
    ldr     x1, =buffer
    bl      atoi
    ldr     x1, =num_strings
    str     x0, [x1]           // Guardar número de cadenas
    mov     x19, x0            // Guardar en x19 también

    // Leer cadenas
    mov     x20, #0            // Contador de cadenas
    ldr     x21, =strings      // Base de strings

read_loop:
    // Imprimir prompt
    mov     x0, #1
    ldr     x1, =msg_str
    mov     x2, #len_msg_str
    mov     x8, #64
    svc     #0

    // Leer cadena
    mov     x0, #0
    mov     x1, x21
    mov     x2, #100
    mov     x8, #63
    svc     #0
    
    sub     x0, x0, #1         // Ajustar longitud (quitar \n)
    strb    wzr, [x21, x0]     // Poner null al final
    
    add     x21, x21, #100     // Siguiente posición de memoria
    add     x20, x20, #1       // Incrementar contador
    cmp     x20, x19
    b.lt    read_loop

    // Encontrar prefijo común
    bl      find_prefix

    // Imprimir mensaje resultado
    mov     x0, #1
    ldr     x1, =msg_result
    mov     x2, #len_result
    mov     x8, #64
    svc     #0

    // Imprimir prefijo
    mov     x0, #1
    ldr     x1, =result
    mov     x2, x23            // Longitud del prefijo
    mov     x8, #64
    svc     #0

    // Imprimir newline
    mov     x0, #1
    ldr     x1, =newline
    mov     x2, #1
    mov     x8, #64
    svc     #0

    // Exit
    mov     x8, #93
    mov     x0, #0
    svc     #0

// Función para encontrar prefijo común
find_prefix:
    ldr     x0, =strings       // Primera cadena
    ldr     x1, =result        // Buffer resultado
    mov     x23, #0            // Contador de caracteres del prefijo

next_char:
    // Cargar carácter de primera cadena
    ldrb    w2, [x0, x23]
    cbz     w2, done           // Si es null, terminamos

    // Comparar con resto de cadenas
    mov     x4, #1             // Índice de cadena actual
compare_loop:
    cmp     x4, x19            // Comparar con número total de cadenas
    b.ge    store_char         // Si terminamos comparación, guardar carácter

    // Calcular dirección de cadena actual
    mov     x5, #100
    mul     x5, x4, x5
    ldr     x6, =strings
    add     x6, x6, x5

    // Comparar carácter
    ldrb    w7, [x6, x23]
    cmp     w7, w2
    b.ne    done              // Si no coincide, terminamos

    add     x4, x4, #1
    b       compare_loop

store_char:
    // Guardar carácter en resultado
    strb    w2, [x1, x23]
    add     x23, x23, #1
    b       next_char

done:
    // Terminar string con null
    strb    wzr, [x1, x23]
    ret

// Convertir ASCII a número
atoi:
    mov     x0, #0              // Resultado
    mov     x2, #10             // Base 10
atoi_loop:
    ldrb    w3, [x1], #1        // Cargar siguiente byte
    cmp     w3, #'\n'           // Si es newline, terminar
    b.eq    atoi_done
    sub     w3, w3, #'0'        // Convertir a número
    mul     x0, x0, x2          // Multiplicar por 10
    add     x0, x0, x3          // Añadir dígito
    b       atoi_loop
atoi_done:
    ret


//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar el programa

// Ensamblar el código
// as -o pref.o pref.s

// Vincular el archivo objeto
// ld -o pref pref.o

// Ejecutar el programa
//  ./pref

//-----------------------------------------------------------------------------------------------------------------------

// Comandos para ejecutar en gdb

// gdb -q pref

// start

// step

// q


//------------------------------------------------------------------------------------------------------------------------
// Enlace de asciinema

https://asciinema.org/a/A10dSqafNgx384ESZpPfU8B9x



//----------------------------------------------------------------------------------------------------------------------//
