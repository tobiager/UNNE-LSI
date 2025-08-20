#include <iostream>
#include <cmath>

using namespace std;

int main()
{
    int cantidad_figuras;
    double radio, area_circulo, area_total;

    // Pedimos la cantidad de figuras y el valor del radio
    cout << "Ingrese la cantidad de figuras: ";
    cin >> cantidad_figuras;
    cout << "Ingrese el valor del radio: ";
    cin >> radio;

    // Calculamos el área de un círculo y luego la superficie total a cubrir
    area_circulo = M_PI * pow(radio, 2);
    area_total = cantidad_figuras * area_circulo;

    // Mostramos la cantidad de figuras y el total de la superficie a cubrir
    cout << "Cantidad de figuras: " << cantidad_figuras << endl;
    cout << "Superficie a cubrir: " << area_total << endl;

    return 0;
}

