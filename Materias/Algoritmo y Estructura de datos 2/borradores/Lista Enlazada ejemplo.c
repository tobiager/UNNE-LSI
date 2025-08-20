#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// DECLARACION TIPOS
typedef char tString[25]; // Defino tipo string

typedef struct {
    int numero;
    long dni;
    tString nombre;
} tAlumno;

typedef struct nodo {
    tAlumno alumno;
    struct nodo* siguiente;
} tLista;

// PROTOTIPOS
void inicializarLista();
void menu();
void ingresarAlumno();
void insertarAlumno();
void eliminarAlumno();
void insertarAlumnoN(int posicion);
void eliminarAlumnoN(int posicion);
void insertarAlumnoalfinal();
void visualizarLista();
void contarLista();

// DECLARACION DE VARIABLES LOCALES
tLista* lista;
tAlumno Valumno; // para usar con scanf

// MAIN
int main() {
    inicializarLista();
    menu();
    return 0;
}

// IMPLEMENTACION
void inicializarLista() {
    lista = NULL;
    printf("Lista inicializada.......\n");
}

void ingresarAlumno() {
    printf("Ingrese numero del alumno: ");
    scanf("%d", &Valumno.numero);
    printf("Ingrese nombre del alumno: ");
    scanf("%s", Valumno.nombre);
    printf("Ingrese DNI del alumno: ");
    scanf("%ld", &Valumno.dni);
}

void insertarAlumno() {
    tLista* nuevoNodo = (tLista*)malloc(sizeof(tLista));
    nuevoNodo->alumno = Valumno;
    nuevoNodo->siguiente = lista;
    lista = nuevoNodo;
    printf("Alumno insertado en la lista.\n");
}

void eliminarAlumno() {
    if (lista != NULL) {
        tLista* temp = lista;
        lista = lista->siguiente;
        free(temp);
        printf("Primer alumno eliminado de la lista.\n");
    } else {
        printf("La lista esta vacia, no se puede eliminar.\n");
    }
}

void insertarAlumnoN(int posicion) {
    if (posicion < 1) {
        printf("Posición invalida.\n");
        return;
    }

    if (posicion == 1) {
        insertarAlumno(); // Insertar al principio
        return;
    }

    tLista* nuevoNodo = (tLista*)malloc(sizeof(tLista));
    nuevoNodo->alumno = Valumno;

    tLista* actual = lista;
    int contador = 1;

    while (actual != NULL && contador < posicion - 1) {
        actual = actual->siguiente;
        contador++;
    }

    if (actual != NULL) {
        nuevoNodo->siguiente = actual->siguiente;
        actual->siguiente = nuevoNodo;
        printf("Alumno insertado en la posición %d de la lista.\n", posicion);
    } else {
        printf("Posición fuera de rango, no se puede insertar.\n");
        free(nuevoNodo);
    }
}

void eliminarAlumnoN(int posicion) {
    if (posicion < 1 || lista == NULL) {
        printf("No se puede eliminar en la posicion especificada o la lista esta vacia.\n");
        return;
    }

    if (posicion == 1) {
        eliminarAlumno(); // Eliminar el primer elemento
        return;
    }

    tLista* actual = lista;
    tLista* anterior = NULL;
    int contador = 1;

    while (actual != NULL && contador < posicion) {
        anterior = actual;
        actual = actual->siguiente;
        contador++;
    }

    if (actual != NULL) {
        anterior->siguiente = actual->siguiente;
        free(actual);
        printf("Alumno eliminado en la posicion %d de la lista.\n", posicion);
    } else {
        printf("Posicion fuera de rango, no se puede eliminar.\n");
    }
}

void visualizarLista() {
    tLista* actual = lista;
    int contador = 1;

    printf("Lista de Alumnos:\n");

    while (actual != NULL) {
        printf("Posicion %d - numero: %d, Nombre: %s Dni: %ld\n", contador, actual->alumno.numero, actual->alumno.nombre, actual->alumno.dni);
        actual = actual->siguiente;
        contador++;
    }
}

void contarLista() {
    tLista* actual = lista;
    int contador = 0;

    while (actual != NULL) {
        contador++;
        actual = actual->siguiente;
    }

    printf("La lista tiene %d alumnos.\n", contador);
}

void insertarAlumnoalfinal(){
    tLista* nuevoNodo = (tLista*)malloc(sizeof(tLista));
    nuevoNodo->alumno = Valumno;
    nuevoNodo->siguiente = NULL;

    if (lista == NULL) {
        
        lista = nuevoNodo;
    } else {
        tLista* actual = lista;
        while (actual->siguiente != NULL) {
            actual = actual->siguiente;
        }
        actual->siguiente = nuevoNodo;
    }
    printf("Alumno insertado al final de la lista.\n");
}

void menu() {
    int opcion = 1;
    while (opcion != 0) {
        printf("\nIngrese una opcion:\n");
        printf("0 - Salir\n");
        printf("1 - Ingresar y agregar alumno\n");
        printf("2 - Eliminar primer alumno\n");
        printf("3 - Insertar alumno en posicion\n");
        printf("4 - Eliminar alumno en posicion\n");
        printf("5 - Visualizar lista\n");
        printf("6 - Contar alumnos\n"); 
		printf("7 - ingresar alumno al final\n");        
        printf("\n opcion:");       
		scanf("%d", &opcion);

        switch (opcion) {
            case 0:
                printf("Saliendo...\n");
                break;

            case 1:
                ingresarAlumno();
                insertarAlumno();
                break;

            case 2:
                eliminarAlumno();
                break;

            case 3:
                {	
					ingresarAlumno();
                    int posicion;
                    printf("En que posicion desea insertar un alumno: ");
                    scanf("%d", &posicion);
                    insertarAlumnoN(posicion);
                }
                break;

            case 4:
                {
                    int posicion;
                    printf("En que posicion desea eliminar un alumno: ");
                    scanf("%d", &posicion);
                    eliminarAlumnoN(posicion);
                }
                break;

            case 5:
                visualizarLista();
                break;

            case 6:
                contarLista();
                break;
			
			case 7:
				ingresarAlumno();
				insertarAlumnoalfinal();
				break;
				
            default:
                printf("Opción no valida. Intente de nuevo.\n");
                break;
        }
    }
}

