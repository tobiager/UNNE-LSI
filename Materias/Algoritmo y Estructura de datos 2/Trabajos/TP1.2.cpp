#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {
    typedef int indice;
    typedef indice *apuntIndice;

    indice i;
    apuntIndice apunti;

    apunti = (apuntIndice)malloc(sizeof(indice));
    *apunti = 2;
    i = 4;

    printf("El valor de i es: %d\n", i); // Agregamos esta l�nea para imprimir el valor de i

    free(apunti);

    return 0;
}

//Al principio de la ejecuci�n: 
//apunti: No inicializado, su valor ser� indeterminado.
/*apunti: Intentar acceder al valor al que apunta apuntien este punto causar�a un comportamiento indefinido, ya que apuntino ha sido inicializado.
Despues de la linea apunti = (apuntIndice)malloc(sizeof(indice));:
apunti: Apuntar� a una direcci�n de memoria reci�n colocada mediante malloc, que tendr� espacio para almacenar un valor de tipo indice(que es un int).
*apunti: Como apuntiapunta a una direcci�n de memoria v�lida despu�s de la eliminaci�n con malloc, *apuntipuede utilizarse para acceder al contenido de esa direcci�n. En este punto, se puede escribir un valor en esta ubicaci�n de memoria, como se hace con *apunti = 2;.
Despues de la linea *apunti = 2;:

apunti: Apuntar� a la misma direcci�n de memoria que antes.
*apunti: Contendr� el valor 2, ya que se asign� este valor a la direcci�n de memoria apuntada por apunti.
Despues de la linea i = 4;:

i: Contendr� el valor 4, ya que se le asigna directamente.
Despues de la linea free(apunti);:

apunti: Aunque la memoria ofrecida con mallocse liber�, apuntitodav�a contiene la direcci�n de memoria que fue liberada (esto es peligroso y podr�a causar problemas si se intenta acceder a esta direcci�n de memoria).
*apunti: No se puede acceder a *apuntidespu�s de liberar la memoria.
En resumen, el valor de apuntidespu�s de liberar la memoria no es seguro, y el contenido de *apuntidespu�s de liberar la memoria es indefinido y podr�a llevar a comportamientos no deseados./
