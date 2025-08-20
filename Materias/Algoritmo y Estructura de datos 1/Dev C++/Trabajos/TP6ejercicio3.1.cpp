#include <stdio.h>
#include <string.h>

int main() {
    char nombre[50];
    char apellido[50];
    char cadenaCompleta[100];
    int longitud;

    // Ciclo para ingresar los datos hasta que se indique una condición de fin
    while (true) {
        printf("Ingrese el nombre (o ingrese 'fin' para salir): ");
        scanf("%s", nombre);

        // Comprobar la condición de fin
        if (strcmp(nombre, "fin") == 0) {
            break;
        }

        printf("Ingrese el apellido: ");
        scanf("%s", apellido);

        // Concatenar el apellido y nombre separados por coma
        strcpy(cadenaCompleta, apellido);
        strcat(cadenaCompleta, ", ");
        strcat(cadenaCompleta, nombre);

        // Obtener la longitud de la cadena completa
        longitud = strlen(cadenaCompleta);

        // Mostrar la nueva cadena y su longitud
        printf("Cadena completa: %s\n", cadenaCompleta);
        printf("Longitud: %d\n", longitud);
    }

    return 0;
}

