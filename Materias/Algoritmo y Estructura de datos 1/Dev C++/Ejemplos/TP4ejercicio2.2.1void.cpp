#include <stdio.h>
float sueldo, prestamo;

int main(){
	void ingresarSueldo ();
	printf("Ingrese el monto del sueldo del solicitante: $");
    scanf("%f", &sueldo);
    
	void calcularPrestamo ();
	 if (sueldo >= 100000) {
        prestamo = 300000;
        printf("Se autoriza un prestamo de $%.2f\n", prestamo);
    } else {
    	void restarResultado ();
        prestamo = sueldo * 0.75;
        printf("Se autoriza un prestamo de $%.2f\n", prestamo);
    }
}
