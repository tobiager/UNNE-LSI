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

    printf("El valor de i es: %d\n", i); // Agregamos esta línea para imprimir el valor de i

    free(apunti);

    return 0;
}

//Al principio de la ejecución: 
//apunti: No inicializado, su valor será indeterminado.
/*apunti: Intentar acceder al valor al que apunta apuntien este punto causaría un comportamiento indefinido, ya que apuntino ha sido inicializado.
Despues de la linea apunti = (apuntIndice)malloc(sizeof(indice));:
apunti: Apuntará a una dirección de memoria recién colocada mediante malloc, que tendrá espacio para almacenar un valor de tipo indice(que es un int).
*apunti: Como apuntiapunta a una dirección de memoria válida después de la eliminación con malloc, *apuntipuede utilizarse para acceder al contenido de esa dirección. En este punto, se puede escribir un valor en esta ubicación de memoria, como se hace con *apunti = 2;.
Despues de la linea *apunti = 2;:

apunti: Apuntará a la misma dirección de memoria que antes.
*apunti: Contendrá el valor 2, ya que se asignó este valor a la dirección de memoria apuntada por apunti.
Despues de la linea i = 4;:

i: Contendrá el valor 4, ya que se le asigna directamente.
Despues de la linea free(apunti);:

apunti: Aunque la memoria ofrecida con mallocse liberó, apuntitodavía contiene la dirección de memoria que fue liberada (esto es peligroso y podría causar problemas si se intenta acceder a esta dirección de memoria).
*apunti: No se puede acceder a *apuntidespués de liberar la memoria.
En resumen, el valor de apuntidespués de liberar la memoria no es seguro, y el contenido de *apuntidespués de liberar la memoria es indefinido y podría llevar a comportamientos no deseados./
