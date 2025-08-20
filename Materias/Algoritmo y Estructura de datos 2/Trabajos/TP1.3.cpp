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


//Voy a explicar el contenido de cada una de las variables en el contexto del c�digo proporcionado:

//a) apuntC: Contiene un puntero que apunta a NULL, ya que se le asigna el valor NULL en la l�nea apuntC = NULL;.

//b) apuntCC: Contiene un puntero que apunta a una direcci�n de memoria que se ha asignado con malloc(sizeof(cosa));, es decir, apunta a una regi�n de memoria de tama�o sizeof(cosa) (que es el tama�o de un int en este caso) que se ha reservado din�micamente en el mont�n.

//c) c: Es una variable de tipo cosa (que es un int debido a la definici�n typedef int cosa;). Sin embargo, en tu c�digo no se le asigna ning�n valor, por lo que su contenido ser�a indeterminado y podr�a ser cualquier valor que est� en esa ubicaci�n de memoria.

//d) cc: Similar a la variable c, es otra variable de tipo cosa que no se le asigna un valor espec�fico, por lo que su contenido tambi�n ser�a indeterminado.

//e) *apuntC: Esto intentar�a acceder al valor al que apunta el puntero apuntC, pero dado que apuntC se inicializ� como NULL, intentar acceder al valor causar�a un error de acceso a memoria no v�lida.

//f) *apuntCC: Accede al valor al que apunta el puntero apuntCC, que es la direcci�n de memoria que se reserv� con malloc y que es del tama�o de un int.

//Recuerda que el contenido de las variables no inicializadas o no asignadas de manera expl�cita puede ser impredecible y depende del estado actual de la memoria en el momento de la ejecuci�n.




 
