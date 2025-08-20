#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef char tString [50];
tString vDias[8]= {"","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"};
tString vTipoMov[3] = {"", "Ingresos", "Gastos"};

typedef struct {
	int codDia; //Codigo del día: 1-Lunes, 2-Martes.. etc
	tString fecha;
	tString descripcion;
	int codImporte; //1-Ingresos 2-Gastos
	float importe;
}tMovimiento;

tMovimiento regMov, regMovAnterior;

//---VAR OP POR DIA (Bloque)----
float totalIngresosDia, totalGastosDia; //acumuladores
float mayorIngresoDia, menorIngresoDia,mayorGastoDia, menorGastoDia;//asignacion
int  posMayorMov, posMenorMov; //Int POS para manejar los vectores de Strings
tString descripcionMayorGasto, descripcionMenorIngreso, descripcionMayorIngreso, descripcionMenorGasto;

//---VAR OP SEMANA (Generales)---
//Var de: Total ingresos/gastos semanal. Mayor/Menor Ingreso/gasto Semanal.
float totalIngresosSem, totalGastosSem; //acumuladores
float mayorGastoSem, menorGastoSem,mayorIngresoSem, menorIngresoSem,notMov; //asignacion
