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
tAlumno valumno; // para usar con scanf

// MAIN
int main() {
    inicializarLista();
    menu();
    return 0;
}
void inicializarLista()	{
	lista = NULL;
	printf("Lista inicializada");
}

void ingresarAlumno(){
	printf("ingresar nombre del alumno: ");
	scanf("%s", valumno.nombre);
	printf("ingresar numero del alumno: ");
	scanf("%d", &valumno.numero);
	printf("ingresar DNI del alumno: ");
	scanf("%ld", &valumno.dni);
}

void insertarAlumno(){
	tLista* nuevonodo = (tLista*)malloc(sizeof(tLista));
	nuevonodo-> alumno = valumno;
	nuevonodo-> siguiente = lista;
	lista = nuevonodo;
	printf("\nalumno ingresado al principio\n");
}

void eliminarAlumno(){
	if(lista!=NULL){
		tLista* temp = lista;
		lista = lista->siguiente;
		free(temp);
	}
}

void insertarAlumnoN(int posicion){
	if(posicion < 1){
		printf("\n posicion invalida\n");
		return;
	}
	
	if(posicion == 1){
		insertarAlumno();
		return;
	}
	
	tLista* nuevonodo = (tLista*)malloc(sizeof(tLista));
	nuevonodo-> alumno = valumno;
	
	tLista* actual = lista;
	int contador = 1;
	
	while (actual!=NULL && contador < posicion - 1){
		actual = actual -> siguiente;
		contador++;
	}
	 if (actual != NULL) {
        nuevonodo->siguiente = actual->siguiente;
        actual->siguiente = nuevonodo;
        printf("Alumno insertado en la posición %d de la lista.\n", posicion);
    } else {
        printf("Posición fuera de rango, no se puede insertar.\n");
        free(nuevonodo);
    }
	
}
void eliminarAlumnoN(int posicion){
	
}
void insertarAlumnoalfinal(){
}

void visualizarLista(){
	tLista* actual = lista;
    int contador = 1;

    printf("Lista de Alumnos:\n");

    while (actual != NULL) {
        printf("Posicion %d - numero: %d, Nombre: %s Dni: %ld\n", contador, actual->alumno.numero, actual->alumno.nombre, actual->alumno.dni);
        actual = actual->siguiente;
        contador++;
    }

}
void contarLista(){
	
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

