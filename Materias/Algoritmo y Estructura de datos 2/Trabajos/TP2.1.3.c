#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Definición de la estructura para representar un nodo de la lista
struct Alumno {
    int numeroLibreta;
    char nombre[100];
    struct Alumno* siguiente;
};

// Función para crear un nuevo nodo de alumno
struct Alumno* crearAlumno(int numeroLibreta, const char* nombre) {
    struct Alumno* nuevoAlumno = (struct Alumno*)malloc(sizeof(struct Alumno));
    nuevoAlumno->numeroLibreta = numeroLibreta;
    strcpy(nuevoAlumno->nombre, nombre);
    nuevoAlumno->siguiente = NULL;
    return nuevoAlumno;
}

// Función para insertar un alumno al principio de la lista
void insertarAlumnoAlPrincipio(struct Alumno** lista, int numeroLibreta, const char* nombre) {
    struct Alumno* nuevoAlumno = crearAlumno(numeroLibreta, nombre);
    nuevoAlumno->siguiente = *lista;
    *lista = nuevoAlumno;
}

// Función para eliminar el primer alumno de la lista
void eliminarPrimerAlumno(struct Alumno** lista) {
    if (*lista != NULL) {
        struct Alumno* temp = *lista;
        *lista = (*lista)->siguiente;
        free(temp);
    }
}

// Función para insertar un alumno en una posición determinada de la lista
void insertarAlumnoEnPosicion(struct Alumno** lista, int posicion, int numeroLibreta, const char* nombre) {
    if (posicion < 0)
        return;

    if (posicion == 0) {
        insertarAlumnoAlPrincipio(lista, numeroLibreta, nombre);
        return;
    }

    struct Alumno* nuevoAlumno = crearAlumno(numeroLibreta, nombre);
    struct Alumno* actual = *lista;
    int contador = 0;

    while (actual != NULL && contador < posicion - 1) {
        actual = actual->siguiente;
        contador++;
    }

    if (actual != NULL) {
        nuevoAlumno->siguiente = actual->siguiente;
        actual->siguiente = nuevoAlumno;
    } else {
        free(nuevoAlumno);
    }
}

// Función para eliminar un alumno en una posición determinada de la lista
void eliminarAlumnoEnPosicion(struct Alumno** lista, int posicion) {
    if (posicion < 0 || *lista == NULL)
        return;

    if (posicion == 0) {
        eliminarPrimerAlumno(lista);
        return;
    }

    struct Alumno* actual = *lista;
    int contador = 0;

    while (actual != NULL && contador < posicion - 1) {
        actual = actual->siguiente;
        contador++;
    }

    if (actual != NULL && actual->siguiente != NULL) {
        struct Alumno* temp = actual->siguiente;
        actual->siguiente = temp->siguiente;
        free(temp);
    }
}

// Función para visualizar todos los datos de los alumnos en la lista
void visualizarAlumnos(struct Alumno* lista) {
    printf("Lista de Alumnos:\n");
    while (lista != NULL) {
        printf("Numero de Libreta: %d, Nombre: %s\n", lista->numeroLibreta, lista->nombre);
        lista = lista->siguiente;
    }
    printf("\n");
}

// Función para contar la cantidad de alumnos en la lista
int contarAlumnos(struct Alumno* lista) {
    int contador = 0;
    while (lista != NULL) {
        contador++;
        lista = lista->siguiente;
    }
    return contador;
}

// Función para liberar la memoria de todos los nodos de la lista
void liberarLista(struct Alumno* lista) {
    while (lista != NULL) {
        struct Alumno* temp = lista;
        lista = lista->siguiente;
        free(temp);
    }
}

int main() {
    struct Alumno* lista = NULL;
    int opcion;
    
    do {
        printf("Menu Principal:\n");
        printf("0. Salir\n");
        printf("1. Insertar un alumno al principio\n");
        printf("2. Eliminar el primer alumno\n");
        printf("3. Insertar un alumno en una posición\n");
        printf("4. Eliminar un alumno en una posición\n");
        printf("5. Visualizar todos los alumnos\n");
        printf("6. Cantidad de alumnos en la lista\n");
        printf("Elija una opcion:  ");
        scanf("%d", &opcion);

        switch (opcion) {
        	case 0:
                liberarLista(lista);
                printf("Programa finalizado.\n");
                break;
            case 1:
                {
                    int numLibreta;
                    char nombre[100];
                    printf("Ingrese el numero de libreta del alumno: ");
                    scanf("%d", &numLibreta);
                    printf("Ingrese el nombre del alumno: ");
                    scanf("%s", nombre);
                    insertarAlumnoAlPrincipio(&lista, numLibreta, nombre);
                    break;
                }
            case 2:
                eliminarPrimerAlumno(&lista);
                break;
            case 3:
                {
                    int posicion, numLibreta;
                    char nombre[100];
                    printf("Ingrese la posicion de insercion: ");
                    scanf("%d", &posicion);
                    printf("Ingrese el numero de libreta del alumno: ");
                    scanf("%d", &numLibreta);
                    printf("Ingrese el nombre del alumno: ");
                    scanf("%s", nombre);
                    insertarAlumnoEnPosicion(&lista, posicion, numLibreta, nombre);
                    break;
                }
            case 4:
                {
                    int posicion;
                    printf("Ingrese la posicion de eliminacion: ");
                    scanf("%d", &posicion);
                    eliminarAlumnoEnPosicion(&lista, posicion);
                    break;
                }
            case 5:
                visualizarAlumnos(lista);
                break;
            case 6:
                printf("Cantidad de alumnos en la lista: %d\n", contarAlumnos(lista));
                break;
            default:
                printf("Opcion no valida. Por favor, ingrese una opcion valida.\n");
        }
    } while (opcion != 0);

    return 0;
}

