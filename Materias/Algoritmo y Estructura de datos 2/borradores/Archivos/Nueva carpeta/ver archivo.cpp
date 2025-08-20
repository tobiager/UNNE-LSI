#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *archivo;
    char nombreArchivo[] = "alumnos.txt";
    int dni;
    char nombre[100];

    // Abre el archivo para lectura
    archivo = fopen(nombreArchivo, "r");

    // Verifica si se pudo abrir el archivo
    if (archivo == NULL) {
        printf("No se pudo abrir el archivo %s\n", nombreArchivo);
        return 1;
    }

    // Lee y muestra cada registro del archivo
    while (fscanf(archivo, "%d %s", &dni, nombre) != EOF) {
        printf("DNI: %d, Nombre: %s\n", dni, nombre);
    }

    // Cierra el archivo
    fclose(archivo);

    return 0;
}

