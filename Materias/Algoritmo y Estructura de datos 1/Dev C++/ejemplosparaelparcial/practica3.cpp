/*La asignatura Algoritmos 1 al final del dictado cuenta con las notas del 1er. y 2do. parcial de todos sus
alumnos. Se requiere determinar la categoría que le corresponde a cada uno de ellos: “Promocionó”,
“Regularizó”, o “Libre”. Se ingresan por teclado los datos: nro. de libreta universitaria, nota del primer
parcial (p1) y nota del segundo parcial (p2). El fin de datos está dado con libreta universitaria igual a cero.
El parcial se aprueba con nota >= 6. Las condiciones para cada categoría son:
- Para promocionar: aprobados los 2(dos) parciales y el promedio de ambos debe ser mayor o igual
a 7 (siete).
- Para regularizar: aprobados los 2(dos) parciales.
- Libre: si desaprueba al menos un parcial.
Para cada alumno, mostrar: libreta universitaria, nota p1, nota p2 y categoría.
El programa deberá contemplar las siguientes funciones:
• Una función que devuelva true en el caso que el parcial esté aprobado y false en caso contrario.
• Una función que retorne el promedio de 2 notas que se reciben como parámetros.
*/
#include <stdio.h>

bool parcialAprobado(float nota){
    return nota >= 6;
}

float calcularPromedio(float nota1, float nota2){
    return (nota1 + nota2) / 2;
}

int main(){
    int libreta = 1; // Iniciamos con 1 para que entre al while
    while(libreta != 0){
        printf("Ingrese numero de libreta (0 para salir): ");
        scanf("%d", &libreta);

        if(libreta != 0){ // Si ingresó 0 sale del while
            float nota1, nota2;
            printf("Ingrese nota del primer parcial: ");
            scanf("%f", &nota1);
            printf("Ingrese nota del segundo parcial: ");
            scanf("%f", &nota2);

            printf("Libreta universitaria: %d\n", libreta);
            printf("Nota primer parcial: %.2f\n", nota1);
            printf("Nota segundo parcial: %.2f\n", nota2);

            if(parcialAprobado(nota1) && parcialAprobado(nota2)){
                float promedio = calcularPromedio(nota1, nota2);
                if(promedio >= 7){
                    printf("Categoria: Promociono\n");
                } else {
                    printf("Categoria: Regularizo\n");
                }
            } else {
                printf("Categoria: Libre\n");
            }
        }
    }
    return 0;
}

