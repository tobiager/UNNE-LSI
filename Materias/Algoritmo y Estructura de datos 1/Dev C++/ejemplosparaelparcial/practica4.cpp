#include <stdio.h>

#define TITULO "Campana de ventas - Supermercado"

void inicializarVariables();
void ingresarDatos();
void procesarFormaDePago();
void importeTotalRecaudado();
void contarVentaCaja1();
void contarVentaCaja2();
void contarVentaCaja3();
void calcularPorcentajeCaja1();
void mostrarInforme();

int dniCliente, nroDeCaja, formaDePago;
float montoTotalDeLaCompra, importeTotal, totalFacturado, ventaCajaN1, ventaCajaN2, ventaCajaN3, porcentajeVentaCaja1;
char respuesta;


int main() {

    inicializarVariables();

    do {
        ingresarDatos();
        procesarFormaDePago();
        importeTotalRecaudado();
        contarVentaCaja1();
        contarVentaCaja2();
        contarVentaCaja3();
        calcularPorcentajeCaja1();
        printf("\nDesea cargar datos ? s/n: ");
        fflush(stdin);
        scanf("%c", &respuesta);
    } while(respuesta == 's');

    mostrarInforme();

    return 0;
}

void inicializarVariables() {
    importeTotal = 0;
    totalFacturado = 0;
    formaDePago = 0;
    nroDeCaja = 0;
    ventaCajaN1 = 0;
    porcentajeVentaCaja1 = 0;
}

void ingresarDatos() {
    printf("Ingrese DNI: ");
    scanf("%d", &dniCliente);
    printf("Ingrese Nro de caja(1-Caja 1/ 2-Caja 2 / 3- Caja 3): ");
    scanf("%d", &nroDeCaja);
    printf("Ingrese forma de pago (1-Efectivo / 2-Tarjeta): ");
    scanf("%d", &formaDePago);
    printf("Ingrese Monto total de la compra: ");
    scanf("%f", &montoTotalDeLaCompra);
}

void procesarFormaDePago() {
    if(nroDeCaja == 3 && formaDePago == 2) {
        printf("*** Caja Nro: 3 - DNI: %d - Tarjeta ! ***\n", dniCliente);
    }
}

void importeTotalRecaudado() {
    importeTotal += montoTotalDeLaCompra;
    totalFacturado = importeTotal;
}

void contarVentaCaja1() {
    if(nroDeCaja == 1) {
        ventaCajaN1 += montoTotalDeLaCompra;
    }
}

void contarVentaCaja2() {
    if(nroDeCaja == 2) {
        ventaCajaN2 += montoTotalDeLaCompra;
    }
}

void contarVentaCaja3() {
    if(nroDeCaja == 3) {
        ventaCajaN3 += montoTotalDeLaCompra;
    }
}

void calcularPorcentajeCaja1() {
    if (ventaCajaN1 > 0) { // Verificar que se hayan registrado ventas en la caja Nro. 1
        porcentajeVentaCaja1 = (ventaCajaN1 * 100) / (ventaCajaN2 + ventaCajaN3);
    } else {
        porcentajeVentaCaja1 = 0;
    }
}


void mostrarInforme() {
    printf("%s\n", TITULO);
    printf("Importe total facturado: %.2f\n", totalFacturado);
    printf("importe recaudado por ventas de caja Nro 1:$ %2.f\n",ventaCajaN1);
    printf("Porcentaje de venta de Caja Nro1 sobre el total de las ventas: %.2f\n", porcentajeVentaCaja1 );	
}
 	
