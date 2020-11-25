#define _USE_MATH_DEFINES
#include <cmath>
#include "main.h"

__global__ void update_Hx( int Nx, int Ny, float* Hx_d, float* Ez_d, float CHx )
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    int j = blockDim.y * blockIdx.y + threadIdx.y;

    if( (i > 0) && ( i < Nx) && ( j >= 0) && ( j < Ny) ){
        Hx_d[i + j*(Nx+1)] = Hx_d[i + j*(Nx+1)]
         - CHx * ( Ez_d[i + (j+1)*(Nx+1)] - Ez_d[i + j*(Nx+1)] );
    }

}