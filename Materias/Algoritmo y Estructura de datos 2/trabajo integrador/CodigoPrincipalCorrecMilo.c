#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "calculoMayorMenor.h"
#include "GrabarMovimiento.h"

/* Tipos de datos personalizados PILA */

typedef struct nodo
{
    tMovimiento datos;
    struct nodo *siguiente;
} tPila;

/* Declaración de variables */
tPila *pila;
tMovimiento mostrarUltimo;
tString buscarString;

/* Declaración de prototipos */
void inicializarPila();
void ingresarDatos();
bool PilaVacia(tPila *);
void ApilarDatos();
void desapilar();
void visualizarMovimientos(tPila *);
tMovimiento UltimoMov(tPila *);
void busquedaString(tPila *, tString);

/* ... (resto de las funciones) ... */

void menu();

int main()
{
    inicializarPila();
    printf("\tMenu\n");
    printf("1.Ingresar datos\n");
    printf("2.Deshacer ultimo movimiento\n");
    printf("3.Buscar movimiento por fecha/descripcion\n");
    printf("4.Mostrar ultimo movimiento\n");
    printf("5.Visualizar historial\n");
    printf("6.Realizar calculos\n");
    printf("0.Salir\n");
    menu();

    return 0;
}

/* ... (resto de las funciones) ... */

void busquedaString(tPila *pPila, tString buscarString)
{
    tPila *aux = pPila;
    bool encontrado = false;

    printf("\n*** RESULTADOS DE LA BUSQUEDA ***\n");
    printf("Dia\t|Fecha\t|Descripcion\t|Categoria\t|Importe\n");

    while (aux != NULL)
    {
        if (strstr(aux->datos.descripcion, buscarString) != NULL)
        {
            encontrado = true;
            printf("%d\t%s\t\t%s\t\t%d\t\t%.2f\n",
                   vDias[aux->datos.codDia], aux->datos.fecha, aux->datos.descripcion,
                   vTipoMov[aux->datos.codImporte], aux->datos.importe);
        }
        aux = aux->siguiente;
    }

    if (!encontrado)
    {
        printf("No se encontraron movimientos con la descripción proporcionada.\n");
    }
}

void menu()
{
    int opcion = 1;
    while (opcion != 0)
    {

        printf("\nIngrese una opcion:");
        scanf("%d", &opcion);

        switch (opcion)
        {
        case 0:
            finalizarProceso();
            printf("Salir.");
            break;
        case 1:
            ingresarDatos();
            ApilarDatos(regMov);
            break;
        case 2:
            desapilar(regMov);
            break;
        case 3:
            printf("Ingrese la cadena a buscar:\n");
            scanf("%s", buscarString);
            fflush(stdin);
            busquedaString(pila, buscarString);
            break;
        case 4:
            mostrarUltimo = UltimoMov(pila);
            printf("El ultimo movimiento es:\n");
            printf("%d %s %s %d %.2f\n",
                   mostrarUltimo.codDia, mostrarUltimo.fecha, mostrarUltimo.descripcion, mostrarUltimo.codImporte, mostrarUltimo.importe);
            break;
        case 5:
            visualizarMovimientos(pila);
            break;
        case 6:
            // menuCalculos();
        default:
            printf("Opcion incorrecta");
        }
    }
}


