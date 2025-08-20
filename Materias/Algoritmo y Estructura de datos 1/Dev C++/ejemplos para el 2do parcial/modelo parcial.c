/* Nos ejercitamos para el parcial

1- La empresa Supermercados Impulso cuenta con 6 sucursales en la ciudad de Corrientes:

0-Tucum�n, 1-Maip�, 2-Irigoyen, 3-Paraguay, 4-Riachuelo, 5- Santa Ana, 6 las mil.

En cada sucursal se encuentran art. de diferentes rubros de articulos, los cuales deber�n ser declarados en una lista enumerativa: Pastas Frescos-L�cteos-Limpieza-art. en Latas- Perfumeria-Bebidas - Verduleria.

Se requiere un programa en lenguaje C que resuelva los puntos que se detallan a continuaci�n: Generar una matriz cuyas filas corresponder�n a las sucursales y en ella cargue los datos correspondientes al monto vendido en cada rubro.

. Detectar la sucursal que realiza el mayor total de ventas el gro y nombre de la sucursal Generar un vector que muestre por pantalla los totales por rubros acuerdo a cada rubro.

Calcular e informar el porcentaje del monto vendido en Perfumeria con respecto al total de los otros rubros.

Al final debe mostrar la matriz completa cargada y la informaci�n solicitada anteriormente y

los vectores correspondientes Adem�s, debe aplicar el m�todo de resoluci�n de problema estableciendo: el objetivo, la estrategia (se recomienda realizar el esquema del escenario) y un caso de prueba que pueda

determinar la soluci�n solicitada */



#include <stdio.h>

int mBanco[7][7];
char* vSucursales[4] = {"Casa Central", "Sucursal de Teniente Iba�ez", "Sucursal La Rioja", "Sucursal de Av. La Paz"};
char* vOperaciones[5] = {"Depositos", "Extracciones", "Transferencias", "Cobro de cheques", "Cobro de Sueldos"};
int i, j;
int minVenta = 0;
int sucursal = 0;
int operacion = 0;
float porcentaje;
void ingresarDatos();
void detectarVentaMin();
void totalOperaciones();
void calcularPorcentaje();
void crearMatriz();
void mostrarInforme();

int main(){
 ingresarDatos();
 detectarVentaMin();
 totalOperaciones();
 calcularPorcentaje();
 crearMatriz();
 mostrarInforme();
}

void ingresarDatos(){
	printf("Ingrese los datos de venta\n");
	for(i = 0; i < 4; i++){
		printf("\nSUCURSAL %s ", vSucursales[i]);
		for(j = 0; j < 5; j++){
			printf("\nIngrese las ventas en el rubro de %s:  ", vOperaciones[j]);
			scanf(" %i", &mBanco[i][j]);
		}
		printf("\n\n");
	}
}

void mostrarInforme(){
	for(i = 0; i < 4; i++){
		for(j = 0; j < 5; j++){
			printf("\nLa sucursal de %s tuvo un total de operaciones de %i", vSucursales[i], mBanco[i][j]);
		}
		printf ("\n");
	}
}


void detectarVentaMin(){
	int minVenta = mBanco[0][0]; // Initialize minVenta with the first element of the matrix
	for(i = 0; i < 4; i++){
		for(j = 0; j < 5; j++)
			if(mBanco[i][j] < minVenta){
				minVenta = mBanco[i][j];
				sucursal = i;
				operacion = j;
			}
	}
	printf("\n\nLa menor operacion se dio en la sucursal de %s y fue de %i  \n\n", vSucursales[sucursal], minVenta);
}



void totalOperaciones(){
	for(i = 0; i <4; i++){
		for(j = 0; j < 5; j++){
			vSucursales[j] += mBanco[i][j];
		}
		
	}
	for(i = 0; i < 7; i++){
		printf("\nEl total de operaciones %s es de %i \n", vOperaciones[i], mBanco[i]);
	}
	printf("\n");
}
void calcularPorcentaje(){
    int totalOperaciones = 0;
    for(i = 0; i < 4; i++){
        if(i != 0) // No se incluye el rubro de Perfumer�a en el c�lculo
            totalOperaciones += mBanco[i];
    }
    
    porcentaje = (float)(mBanco[0]) / totalOperaciones * 100;
	
	printf("La cantidad de operaciones de deposito es %i porcentaje de venta de deposito es del %.2f%%\n",mBanco[0], porcentaje);
}


void crearMatriz(){
	
	printf("\n\nCrear la Matriz del Banco: \n\n");
	
	for(i=0;i<4;i++){
		for(j=0;j<5;j++){
			
			printf("\t[%d] ",mBanco[i][j]);
			
		}
		printf("\n");
	}
	
}


/*mVentas: Es una matriz de tama�o 7x7 que almacena los datos de venta para cada sucursal y rubro.
vVentasR: Es un vector de tama�o 7 que almacena la suma de las ventas por rubro.
vSucursales: Es un vector de tama�o 7 que almacena los nombres de las sucursales.
vArticulos: Es un vector de tama�o 7 que almacena los nombres de los rubros.
i y j: Son variables de control utilizadas en los bucles para iterar sobre las filas y columnas de la matriz.
maxVenta: Almacena la mayor venta encontrada en la matriz.
minVenta: Almacena la menor venta encontrada en la matriz.
sucursal: Almacena el �ndice de la sucursal donde se encontr� la venta m�xima o m�nima.
rubro: Almacena el �ndice del rubro donde se encontr� la venta m�xima o m�nima.
porcentaje: Almacena el porcentaje de ventas de Perfumer�a en relaci�n con las ventas de otros rubros.
Funciones:

main(): Es la funci�n principal que llama a las dem�s funciones en el orden necesario para ejecutar el programa.
ingresarDatos(): Permite al usuario ingresar los datos de venta para cada sucursal y rubro.
mostrarInforme(): Muestra un informe de las ventas realizadas en cada sucursal y rubro.
detectarVentaMax(): Encuentra la mayor venta en la matriz y muestra la sucursal y el rubro correspondientes.
detectarVentaMin(): Encuentra la menor venta en la matriz y muestra la sucursal y el rubro correspondientes.
totalRubros(): Calcula la suma de las ventas por rubro y muestra el total para cada rubro.
calcularPorcentaje(): Calcular el porcentaje de ventas de Perfumer�a en relaci�n con las ventas de otros rubros.
crearMatriz(): Muestra la matriz de ventas completa en forma tabular.
*/
