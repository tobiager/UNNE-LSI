/* El río Paraná presenta una histórica bajante en todo su cauce, y no se registran valores similares durante
abril desde hace más de 130 años. El nivel del agua apenas alcanza los 70 centímetros en algunos sectores.
Esta situación produce grandes pérdidas económicas, debido a que afecta en gran medida al transporte
fluvial. Las autoridades del gobierno desean conocer información de las alturas del río, a efectos de
relacionarlas con las pérdidas producidas. La Prefectura cuenta con los datos de la altura máxima mensual
del río Paraná, organizadas en dos series:

Serie1: mayo/18 a abril/19
Serie 2: mayo/19 a abril/20

Escriba un programa que, utilizando funciones, informe:

en qué mes de cada una de las series ocurrió la menor altura.
cuál fue la menor altura en cada una de las dos series.
en qué serie se dio la menor altura */

#include <stdio.h>
#include <string.h>

    //--definidas por el usuario--//

typedef char tmes[20];
typedef float taltura1;
typedef float taltura2;

//--variables--//

taltura1 nivel2018[12];
taltura2 nivel2019[12];
taltura1 menorAltura2018;
taltura2 menorAltura2019;
tmes MESES[12] = {"Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre", "Enero", "Febrero", "Marzo", "Abril"};
int i, j;

//--funciones--//
void cargarDatos(){

    for(i=0; i<12; i++){
        printf("Ingrese el nivel del rio en CM del mes de %s de 2018:   ", MESES[i]);
        scanf("%f", &nivel2018[i]);
        fflush(stdin);
    }
    printf("**\n");
    for (j=0; j<12; j++){
        printf("Ingrese el nivel del rio en CM del mes de %s de 2019:   ", MESES[j]);
        scanf("%f", &nivel2019[j]);
        fflush(stdin);
    }
}

void encontrarMenorAltura2018(){

    int mesMenorAltura = 0;
    taltura1 menorAltura2018 = nivel2018[0];

    for (i = 0; i < 12; i++) {
        if (nivel2018[i] < menorAltura2018) {
            menorAltura2018 = nivel2018[i];
            mesMenorAltura = i;
        }
    }
    printf("\nEl mes de con menor nivel de la primera serie fue %s con un nivel de %.2f\n", MESES[i], menorAltura2018);
}

void encontrarMenorAltura2019(){

    int mesMenorAltura = 0;
    taltura2 menorAltura2019 = nivel2019[0];

    for (j = 0; j < 12; j++) {

        if (nivel2019[j] < menorAltura2019) {
            menorAltura2019 = nivel2019[j];
            mesMenorAltura = j;
        }
    }
    printf("El mes de con menor nivel de la segunda serie fue %s con un nivel de %.2f\n", MESES[j], menorAltura2019);
}

void determinarSerieMenorAltura() {

    if (menorAltura2018 < menorAltura2019) {
        printf("La serie 2018 tuvo la menor altura\n");
    } else if (menorAltura2018 > menorAltura2019) {
        printf("La serie 2019 tuvo la menor altura\n");
    }
}

// algoritmo principal //

int main(){

    cargarDatos();
    encontrarMenorAltura2018();
    printf("**\n");
    encontrarMenorAltura2019();
    determinarSerieMenorAltura();

return 0;
}
