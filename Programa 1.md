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
    // Programa: Celsius a Fahrenheit en ARM64 Assembly
    // Autor: ChatGPT
    // Fecha: 2024-11-05
    // Descripción: Convierte grados Celsius a Fahrenheit usando la fórmula F = C * 9/5 + 32
    // Entrada: Grados Celsius en x0
    // Salida: Grados Fahrenheit en x0

    .section .data
    .section .text
    .global _start

_start:
    // Multiplicamos el valor de Celsius en x0 por 9
    MOV x1, x0            // Copiamos Celsius a x1
    MOV x2, #9            // Constante 9 en x2
    MUL x0, x1, x2        // x0 = Celsius * 9

    // Dividimos el resultado por 5
    MOV x2, #5            // Constante 5 en x2
    SDIV x0, x0, x2       // x0 = (Celsius * 9) / 5

    // Sumamos 32 al resultado
    ADD x0, x0, #32       // x0 = (Celsius * 9 / 5) + 32

    // Finalizamos el programa
    MOV w8, #93           // Código de salida para syscall en Linux
    SVC #0                // Llamada al sistema para salir

~~~

----

#Comandos para la ejecución del porgrama
##Ensamblar el código
as -o celsius_to_fahrenheit.o celsius_to_fahrenheit.s

##Vincular el archivo objeto
ld -o celsius_to_fahrenheit celsius_to_fahrenheit.o

##Ejecutar el programa
./celsius_to_fahrenheit
