#define _USE_MATH_DEFINES
#include <cmath>

#include "main.h"

__global__ void update_Ez( int Nx, int Ny, float* Ez_d, float* Hx_d, float* Hy_d, float CEz1, float CEz2 )
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    int j = blockDim.y * blockIdx.y + threadIdx.y;

    if( (i > 0) && (i < Nx) && ( j > 0) && (j < Ny) ){
        Ez_d[ i + j*(Nx + 1) ] = Ez_d[ i + j*(Nx + 1) ] + CEz1*( Hy_d[ i + j*Nx ] - Hy_d[ i - 1 + j*Nx ] )
                                                - CEz2*( Hx_d[ i + j*(Nx+1) ] - Hx_d[i + (j-1)*(Nx+1)] );
    }

}