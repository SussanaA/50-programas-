# Instituto Tecnológico de Tijuana
# Departamento de Sistemas y Computación
## Materia: Lenguajes de Interfaz

**Nombre del alumno:** Rodríguez Morales Susana Abigail  
**No. control:** 22210346  
**Nombre del programa:** Convertir temperatura de Celsius a Fahrenheit  

### Descripción de la actividad:
En esta actividad se elaborará un programa que convierte de grados Celsius a grados Fahrenheit en lenguaje ARM64 y lenguaje C#.

---

### Código en C#
~~~
using System;

class Program
{
    static void Main()
    {
        Console.Write("Ingresa la temperatura en grados Celsius: ");
        
        // Leer el valor ingresado por el usuario y convertirlo a double
        double celsius = Convert.ToDouble(Console.ReadLine());
        
        // Realizar la conversión a Fahrenheit
        double fahrenheit = (celsius * 9 / 5) + 32;
        
        // Mostrar el resultado
        Console.WriteLine($"{celsius} grados Celsius equivalen a {fahrenheit} grados Fahrenheit.");
    }
}
~~~

---

### Código en ARM64 Assembly

~~~

#Programa: Celsius a Fahrenheit en ARM64 Assembly
#Descripción: Convierte grados Celsius a Fahrenheit usando la fórmula F = C * 9/5 + 32
#Entrada: Grados Celsius en x0
#Salida: Grados Fahrenheit en x0

.data
    // Mensajes para el usuario
    msg_input: .string "Ingrese la temperatura en Celsius: "
    msg_output: .string "La temperatura en Fahrenheit es: "
    format_input: .string "%d"    // Formato para scanf
    format_output: .string "%d\n"  // Formato para printf

.text
.global main
.align 2

// Función principal
main:
    // Prólogo
    stp     x29, x30, [sp, #-16]!    // Guardar frame pointer y link register
    mov     x29, sp                   // Actualizar frame pointer

    // Imprimir mensaje de entrada
    adrp    x0, msg_input            // Cargar dirección del mensaje
    add     x0, x0, :lo12:msg_input
    bl      printf

    // Leer temperatura en Celsius
    sub     sp, sp, #16              // Reservar espacio en el stack
    mov     x2, sp                   // Dirección donde guardar el input
    adrp    x0, format_input         // Formato para scanf
    add     x0, x0, :lo12:format_input
    mov     x1, x2                   // Pasar dirección como segundo argumento
    bl      scanf

    // Cargar el valor ingresado
    ldr     w0, [sp]                 // Cargar valor de Celsius

    // Realizar la conversión: °F = (°C × 9/5) + 32
    mov     w1, #9
    mul     w0, w0, w1               // Multiplicar por 9
    mov     w1, #5
    sdiv    w0, w0, w1               // Dividir por 5
    add     w0, w0, #32              // Sumar 32

    // Imprimir mensaje de resultado
    mov     w1, w0                   // Mover resultado a w1 para printf
    adrp    x0, msg_output           // Cargar mensaje de salida
    add     x0, x0, :lo12:msg_output
    bl      printf

    // Imprimir el resultado
    mov     w1, w1                   // El resultado ya está en w1
    adrp    x0, format_output        // Formato para imprimir el número
    add     x0, x0, :lo12:format_output
    bl      printf

    // Epílogo
    add     sp, sp, #16              // Liberar espacio del stack
    mov     w0, #0                   // Retornar 0
    ldp     x29, x30, [sp], #16      // Restaurar frame pointer y link register
    ret

~~~

---

# Comandos para ejecutar el programa

## Ensamblar el código
as -o programa1.o programa1.cs

## Vincular el archivo objeto
ld -o programa1 programa1.o

## Ejecutar el programa
./programa1

---


