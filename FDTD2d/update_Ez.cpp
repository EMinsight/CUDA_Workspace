#define _USE_MATH_DEFINES
#include <cmath>
#include "main.h"

void update_Ez( double** Ez, double** Hx, double** Hy )
{
    for( int i = 1; i < Nx; i++ ){
        for( int j = 1; j < Ny; j++ ){
            Ez[i][j] = Ez[i][j]
                    + CEz1 * (Hy[i][j] - Hy[i-1][j])
                    - CEz2 * (Hx[i][j] - Hx[i][j-1]);
        }
    }
    
}