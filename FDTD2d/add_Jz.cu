#define _USE_MATH_DEFINES
#include <cmath>

#include "main.h"

__global__ void add_Jz( int i_s, int j_s, float* Ez_d, float t, float Dt, float t0, float sig )
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    int j = blockDim.y * blockIdx.y + threadIdx.y;

    if( (i == i_s)&&(j == j_s) ){
        Ez_d[ i + j*( Nx + 1 ) ] = Ez_d[ i + j*( Nx + 1 ) ]
            -   Dt/EPS0 * std::exp( -(t - t0)*(t - t0) / 2.0 / sig / sig );
    }

}