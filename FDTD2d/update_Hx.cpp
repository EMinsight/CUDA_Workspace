#define _USE_MATH_DEFINES
#include <cmath>
#include "main.h"

void update_Hx( double** Hx, double** Ez ){

    for( int i = 1; i < Nx; i++ ){
        for( int j = 0; j < Ny; j++ ){
            Hx[i][j] = Hx[i][j]
                    - CHx * ( Ez[i][j+1] - Ez[i][j] );
        }
    }

}
