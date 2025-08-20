#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *archivo;
    char nombreArchivo[] = "alumnos.txt";
    int dni;
    char nombre[100];
    char respuesta;

    // Abre el archivo para escritura
    archivo = fopen(nombreArchivo, "w");

    // Verifica si se pudo abrir el archivo
    if (archivo == NULL) {
        printf("No se pudo abrir el archivo %s\n", nombreArchivo);
        return 1;
    }

    int cantidadRegistros = 0;

    do {
        printf("Ingrese el DNI del alumno: ");
        scanf("%d", &dni);
        printf("Ingrese el nombre del alumno: ");
        scanf("%s", nombre);

        // Escribe los datos en el archivo
        fprintf(archivo, "%d %s\n", dni, nombre);

        cantidadRegistros++;

        printf("¿Desea continuar ingresando datos? (S/N): ");
        scanf(" %c", &respuesta); // El espacio en blanco antes de %c es importante

    } while (respuesta == 'S' || respuesta == 's');

    // Cierra el archivo
    fclose(archivo);

    printf("Se han grabado %d registros en el archivo.\n", cantidadRegistros);

    return 0;
}

