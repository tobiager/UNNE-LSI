#include <stdio.h>
#include <string.h>

struct RegistroNetflix {
    char titulo[50];
    char genero[20];
    int duracion;
    int anio;
    float rating;
    bool visto;
    char idioma[20];
};

int main() {
    // Crear una instancia de RegistroNetflix
    RegistroNetflix registro;

    // Determinar el tipo y el tamaño de cada campo
    printf("Titulo\n");
    printf("  Tipo de dato: char[50]\n");
    printf("  Longitud: %d\n\n", sizeof(registro.titulo));

    printf("Genero\n");
    printf("  Tipo de dato: char[20]\n");
    printf("  Longitud: %d\n\n", sizeof(registro.genero));

    printf("Duracion\n");
    printf("  Tipo de dato: int\n");
    printf("  Longitud: %d\n\n", sizeof(registro.duracion));

    printf("Anio\n");
    printf("  Tipo de dato: int\n");
    printf("  Longitud: %d\n\n", sizeof(registro.anio));

    printf("Rating\n");
    printf("  Tipo de dato: float\n");
    printf("  Longitud: %d\n\n", sizeof(registro.rating));

    printf("Visto\n");
    printf("  Tipo de dato: bool\n");
    printf("  Longitud: %d\n\n", sizeof(registro.visto));

    printf("Idioma\n");
    printf("  Tipo de dato: char[20]\n");
    printf("  Longitud: %d\n\n", sizeof(registro.idioma));

    // Calcular la longitud del registro
    int longitud = sizeof(registro.titulo) + sizeof(registro.genero) + sizeof(registro.duracion) +
                   sizeof(registro.anio) + sizeof(registro.rating) + sizeof(registro.visto) + sizeof(registro.idioma);

    // Asignar valores al registro
    strcpy(registro.titulo, "Cars 2");
    strcpy(registro.genero, "Ciencia Ficcion");
    registro.duracion = 169;
    registro.anio = 2014;
    registro.rating = 8.6;
    registro.visto = true;
    strcpy(registro.idioma, "Ingles");

    // Mostrar el registro por pantalla
    printf("Registro de Netflix:\n");
    printf("Titulo: %s\n", registro.titulo);
    printf("Genero: %s\n", registro.genero);
    printf("Duracion: %d minutos\n", registro.duracion);
    printf("Anio: %d\n", registro.anio);
    printf("Rating: %.1f\n", registro.rating);
    printf("Visto: %s\n", registro.visto ? "Si" : "No");
    printf("Idioma: %s\n", registro.idioma);

    // Mostrar la longitud del registro
    printf("Longitud del registro = %d\n", longitud);

    return 0;
}

