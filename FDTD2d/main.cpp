#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>
#include "main.h"

int main( void ){

    double **Ez, **Hx, **Hy;

    Ez = new double* [ Nx + 1 ];
    for( int i = 0; i < Nx + 1; i++ ){
        Ez[i] = new double[ Ny + 1];
        for( int j = 0; j < Ny + 1; j++ ){
            Ez[i][j] = 0.0;
        }
    }

    Hx = new double* [Nx + 1];
    for( int i = 0; i < Nx + 1; i++ ){
        Hx[i] = new double[ Ny + 1 ];
        for( int j = 0; j < Ny; j++ ){
            Hx[i][j] = 0.0;
        }
    }

    Hy = new double* [Nx];
    for( int i = 0; i < Nx; i++ ){
        Hy[i] = new double[ Ny + 1 ];
        for( int j = 0; j < Ny + 1; j++ ){
            Hy[i][j] = 0.0;
        }
    }

    int NT{ int(Tmax/Dt) };

    for( int n = 0; n < NT; n++ ){

        double t = ( double(n) - 0.5 )*Dt;

        
    }


    return 0;
}