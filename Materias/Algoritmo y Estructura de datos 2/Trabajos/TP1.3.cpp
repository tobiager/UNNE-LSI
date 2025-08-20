#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef int cosa;
typedef cosa *apuntadorACosa;

cosa c, cc;
apuntadorACosa apuntC, apuntCC;

int main() {
    apuntC = NULL;
    apuntCC = (apuntadorACosa)malloc(sizeof(cosa));

    printf("Valor de apuntC: %p\n", (void *)apuntC);
    printf("Valor de apuntCC: %p\n", (void *)apuntCC);

    free(apuntCC);
    free(apuntC);

    return 0;
}


//Voy a explicar el contenido de cada una de las variables en el contexto del código proporcionado:

//a) apuntC: Contiene un puntero que apunta a NULL, ya que se le asigna el valor NULL en la línea apuntC = NULL;.

//b) apuntCC: Contiene un puntero que apunta a una dirección de memoria que se ha asignado con malloc(sizeof(cosa));, es decir, apunta a una región de memoria de tamaño sizeof(cosa) (que es el tamaño de un int en este caso) que se ha reservado dinámicamente en el montón.

//c) c: Es una variable de tipo cosa (que es un int debido a la definición typedef int cosa;). Sin embargo, en tu código no se le asigna ningún valor, por lo que su contenido sería indeterminado y podría ser cualquier valor que esté en esa ubicación de memoria.

//d) cc: Similar a la variable c, es otra variable de tipo cosa que no se le asigna un valor específico, por lo que su contenido también sería indeterminado.

//e) *apuntC: Esto intentaría acceder al valor al que apunta el puntero apuntC, pero dado que apuntC se inicializó como NULL, intentar acceder al valor causaría un error de acceso a memoria no válida.

//f) *apuntCC: Accede al valor al que apunta el puntero apuntCC, que es la dirección de memoria que se reservó con malloc y que es del tamaño de un int.

//Recuerda que el contenido de las variables no inicializadas o no asignadas de manera explícita puede ser impredecible y depende del estado actual de la memoria en el momento de la ejecución.




 
