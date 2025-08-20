#include <stdio.h>


float matventas[6][12];


void cargarMatriz();
void mostrarMatrizCargada();
void MostrarResultado();
void calcularMatriz();

int i , j ,mayorJMES ,mayorIMES ;
float ventaMaxMES;
float sumarVentas ;

int main (){
	
	cargarMatriz();
 	mostrarMatrizCargada();
 	calcularMatriz();
	MostrarResultado();	
	
return 0;	
	
}
void cargarMatriz(){
	for(i=0;i<6;i++){
		
		printf("\n*** SUCURSAL %d ***\n",i+1);
		
		for(j=0;j<12;j++){
			
			printf("\nIngresar el monto de ventas del mes %d :  ",j+1);
			scanf("%f",&matventas[i][j]);
			
			
		}
			
	}	
	
}

void mostrarMatrizCargada(){

	for(i=0;i<6;i++){
		
	printf("\n\n*** SUCURSAL %d ***\n",i+1);	
	
		for(j=0;j<12;j++){
			
		printf("\n el monto de ventas del mes %d es %.2f",j+1,matventas[i][j] );	
			
		}
	}

}

void calcularMatriz(){
ventaMaxMES	=0;


	for(i=0;i<6;i++){	
	
		for(j=0;j<12;j++){
		
		if(matventas[i][j] > ventaMaxMES){
		
		ventaMaxMES = matventas[i][j] ;
		mayorJMES = j+1;
		mayorIMES = i+1;
		
		
		
		}	
			
		}

	
	}
printf("\n\nel maximo monto de ventas del mes fue de la sucursal %d en el mes %d fue de : $%.2f ",mayorIMES,mayorJMES,ventaMaxMES);
	
}
void MostrarResultado(){
	for(i=0;i<6;i++){
	
	for(j=0;j<12;j++){
		
	sumarVentas =  	matventas[i][j] +	sumarVentas;
	
		
	}

	printf("\n\n la venta anual de la sucursal %d es de $%.2f",i+1,sumarVentas );
	
	sumarVentas=0;
	
}

}
