#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    FILE *archivo;
    char nombreArchivo[] = "Fix_you.txt";

    // Abre el archivo para lectura
    archivo = fopen(nombreArchivo, "r");

    // Verifica si se pudo abrir el archivo
    if (archivo == NULL) {
        printf("No se pudo abrir el archivo %s\n", nombreArchivo);
        return 1;
    }

    // Lee y muestra la canción por pantalla
    char linea[500]; // Suponemos que ninguna línea de la canción supera los 500 caracteres
    while (fgets(linea, sizeof(linea), archivo) != NULL) {
        printf("%s", linea);
    }

    // Cierra el archivo
    fclose(archivo);

    return 0;
}

