#include <stdio.h>
#include <string.h>

struct Superheroe {
    char nombreSuperheroe[50];
    char nombreTerrestre[50];
    char poder[50];
    char universo[50];
};

int main() {
    // Crear una instancia de Superheroe
    Superheroe heroe;

    // Asignar valores al superhéroe
    strcpy(heroe.nombreSuperheroe, "Spider-Man");
    strcpy(heroe.nombreTerrestre, "Peter Parker");
    strcpy(heroe.poder, "Agilidad aracnida");
    strcpy(heroe.universo, "Marvel");

    // Mostrar los valores por pantalla
    printf("Superheroe:\n");
    printf("Nombre de Superheroe: %s\n", heroe.nombreSuperheroe);
    printf("Nombre Terrestre: %s\n", heroe.nombreTerrestre);
    printf("Poder: %s\n", heroe.poder);
    printf("Universo: %s\n", heroe.universo);

    return 0;
}

