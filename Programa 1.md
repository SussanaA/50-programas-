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


~~~

###Comandos para la ejecución del porgrama
# Ensamblar el código
as -o celsius_to_fahrenheit.o celsius_to_fahrenheit.s

# Vincular el archivo objeto
ld -o celsius_to_fahrenheit celsius_to_fahrenheit.o

# Ejecutar el programa
./celsius_to_fahrenheit
