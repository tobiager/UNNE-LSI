#include <stdio.h>
#include <string.h>

struct Alumno {
    long dni;
    char apellido[50];
    char nombre[50];
    short edad;
    short codLocalidad;
    short codCarrera;
};

int main() {
    // Crear una instancia de Alumno
    Alumno alumno;

    // Calcular la longitud del registro
    int longitud = sizeof(alumno.dni) + sizeof(alumno.apellido) + sizeof(alumno.nombre) +
                   sizeof(alumno.edad) + sizeof(alumno.codLocalidad) + sizeof(alumno.codCarrera);

    // Imprimir los detalles de cada campo
    printf("DNI\n");
    printf("  Identificador: dni\n");
    printf("  Tipo de dato: long\n");
    printf("  Longitud: %d\n\n", sizeof(alumno.dni));

    printf("Apellido\n");
    printf("  Identificador: apellido\n");
    printf("  Tipo de dato: char[50]\n");
    printf("  Longitud: %d\n\n", sizeof(alumno.apellido));

    printf("Nombre\n");
    printf("  Identificador: nombre\n");
    printf("  Tipo de dato: char[50]\n");
    printf("  Longitud: %d\n\n", sizeof(alumno.nombre));

    printf("Edad\n");
    printf("  Identificador: edad\n");
    printf("  Tipo de dato: short\n");
    printf("  Longitud: %d\n\n", sizeof(alumno.edad));

    printf("Código de Localidad de procedencia\n");
    printf("  Identificador: codLocalidad\n");
    printf("  Tipo de dato: short\n");
    printf("  Longitud: %d\n\n", sizeof(alumno.codLocalidad));

    printf("Código de la carrera que cursa\n");
    printf("  Identificador: codCarrera\n");
    printf("  Tipo de dato: short\n");
    printf("  Longitud: %d\n\n", sizeof(alumno.codCarrera));

    printf("Longitud del registro = %d\n", longitud);

    return 0;
}

