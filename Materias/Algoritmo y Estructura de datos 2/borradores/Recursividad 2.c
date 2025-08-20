#include <stdio.h>

void rechazar(char resp);
void leer(char *resp);

int main(void) {
    char resp;
    leer(&resp);
    return 0;
}

void rechazar(char resp) {
    printf("No es una respuesta aceptable: %c\n", resp);
    leer(&resp);
}

void leer(char *resp) {
    printf("S para si o N para No: ");
    scanf(" %c", resp);

    if (*resp != 'S' && *resp != 'N') {
        rechazar(*resp);
    }
}

