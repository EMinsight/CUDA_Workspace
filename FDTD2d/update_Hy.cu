#define _USE_MATH_DEFINES
#include <cmath>
#include "main.h"

__global__ void update_Hy( int Nx, int Ny, float* Hy, float* Ez, float CHy )
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    int j = blockDim.y * blockIdx.y + threadIdx.y;

    if( (i >= 0) && (i < Nx) && (j > 0) && (j < Ny) ){
        Hy[i + j*Nx] = Hy[i + j*Nx]
                        + CHy*( Ez[i + 1 + j*(Nx+1)] - Ez[i + j*(Nx+1)] );
    }

}