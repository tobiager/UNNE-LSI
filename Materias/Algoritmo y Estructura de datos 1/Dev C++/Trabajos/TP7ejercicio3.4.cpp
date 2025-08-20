#include <stdio.h>
#include <string.h>

#define MAX_LIBROS 150
#define MAX_TITULO 100
#define MAX_EDITORIAL 100

struct Libro {
    int ISBN;
    char titulo[MAX_TITULO];
    char editorial[MAX_EDITORIAL];
};

struct PilaLibros {
    Libro libros[MAX_LIBROS];
    int top;
};

void inicializarPila(PilaLibros& pila) {
    pila.top = -1;
}

bool estaPilaVacia(const PilaLibros& pila) {
    return pila.top == -1;
}

bool estaPilaLlena(const PilaLibros& pila) {
    return pila.top == MAX_LIBROS - 1;
}

void apilarLibro(PilaLibros& pila, const Libro& libro) {
    if (estaPilaLlena(pila)) {
        printf("La pila de libros esta llena. No se puede apilar mas libros.\n");
        return;
    }

    pila.libros[++pila.top] = libro;
}

void desapilarLibro(PilaLibros& pila) {
    if (estaPilaVacia(pila)) {
        printf("La pila de libros esta vacía. No se puede desapilar.\n");
        return;
    }

    pila.top--;
}

Libro topePila(const PilaLibros& pila) {
    if (estaPilaVacia(pila)) {
        printf("La pila de libros esta vacia. No hay un tope definido.\n");
        return Libro();
    }

    return pila.libros[pila.top];
}

void listarUltimosLibros(const PilaLibros& pila, int cantidad) {
    if (estaPilaVacia(pila)) {
        printf("La pila de libros esta vacia. No hay libros para mostrar.\n");
        return;
    }

    printf("Ultimos %d libros apilados:\n", cantidad);
    int inicio = (pila.top - cantidad + 1) < 0 ? 0 : pila.top - cantidad + 1;

    for (int i = inicio; i <= pila.top; i++) {
        printf("ISBN: %d, Titulo: %s, Editorial: %s\n", pila.libros[i].ISBN, pila.libros[i].titulo, pila.libros[i].editorial);
    }
}

int main() {
    PilaLibros pila;
    inicializarPila(pila);

    while (true) {
        printf("\n=== Menú ===\n");
        printf("1. Apilar libro\n");
        printf("2. Desapilar libro\n");
        printf("3. Mostrar libro en el tope\n");
        printf("4. Listar ultimos libros apilados\n");
        printf("5. Salir\n");
        printf("Ingrese una opcion: ");

        int opcion;
        scanf("%d", &opcion);

        if (opcion == 1) {
            if (estaPilaLlena(pila)) {
                printf("La pila de libros esta llena. No se puede apilar mas libros.\n");
                continue;
            }

            Libro libro;
            printf("Ingrese el ISBN del libro: ");
            scanf("%d", &libro.ISBN);
            printf("Ingrese el titulo del libro: ");
            scanf(" %[^\n]s", libro.titulo);
            printf("Ingrese la editorial del libro: ");
            scanf(" %[^\n]s", libro.editorial);

            apilarLibro(pila, libro);
            printf("Libro apilado correctamente.\n");
        } else if (opcion == 2) {
            desapilarLibro(pila);
            printf("Libro desapilado correctamente.\n");
        } else if (opcion == 3) {
            Libro libroTope = topePila(pila);
            printf("Libro en el tope:\n");
            printf("ISBN: %d, Titulo: %s, Editorial: %s\n", libroTope.ISBN, libroTope.titulo, libroTope.editorial);
        } else if (opcion == 4) {
            int cantidad;
            printf("Ingrese la cantidad de libros a mostrar: ");
            scanf("%d", &cantidad);

            listarUltimosLibros(pila, cantidad);
        } else if (opcion == 5) {
            break;
        } else {
            printf("Opcion invalida. Por favor, ingrese una opción valida.\n");
        }
    }

    return 0;
}

