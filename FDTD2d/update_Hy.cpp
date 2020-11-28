#define _USE_MATH_DEFINES
#include <cmath>
#include "main.h"

void update_Hy( double** Hy, double** Ez ){

    for( int i = 0; i < Nx; i++ ){
        for( int j = 1; j < Ny; j++ ){
            Hy[i][j] = Hy[i][j]
                        + CHy*( Ez[i+1][j] - Ez[i][j] );
        }
    }

}