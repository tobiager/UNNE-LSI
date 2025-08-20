#include <iostream>
using namespace std;

int main() {
    float lado1, lado2, perimetro, cinta;

    // Pedir al usuario que ingrese el ancho y alto de la caja
    cout << "Ingrese el ancho de la caja en metros: ";
    cin >> lado1;

    cout << "Ingrese el alto de la caja en metros: ";
    cin >> lado2;

    // Calcular el perímetro y la cantidad de cinta requerida
    perimetro = 2 * (lado1 + lado2);
    cinta = perimetro / 2;

    // Mostrar los resultados en pantalla
    cout << endl << "Datos de la caja:" << endl;
    cout << "Ancho: " << lado1 << " metros" << endl;
    cout << "Alto: " << lado2 << " metros" << endl;
    cout << "Perimetro: " << perimetro << " metros" << endl;
    cout << "Cantidad de cinta requerida: " << cinta << " metros" << endl;

    return 0;
}

