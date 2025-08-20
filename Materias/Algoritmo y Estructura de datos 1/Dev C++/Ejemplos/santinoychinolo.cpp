#include <iostream>
#include <string>

int main() {
    std::string input;
    bool es_verdadero = true;
    
    std::cout << "¿La van a poner Santino y Chinolo?: ";
    std::cin >> input;
    
    if (input == "s" || input == "S") {
        es_verdadero = false;
    }
    
    if (es_verdadero) {
        std::cout << "Es verdadero\n";
    } else {
        std::cout << "Es mentira\n";
    }
    
    return 0;
}

