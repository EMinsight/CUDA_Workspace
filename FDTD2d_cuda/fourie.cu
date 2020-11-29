#define _USE_MATH_DEFINES
#include <cmath>
#include <complex>
#include "main.h"

__global__ void fourie( int Nx, int Ny, std::complex <float> zj, float omega,
                        float t, float *Ez_d, std::complex <float>* Ez_famp_d )
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    int j = blockDim.y * blockIdx.y + threadIdx.y;

    if( j == (Ny/2) ){
        Ez_famp_d[i] = Ez_famp_d[i]
                 + Ez_d[i + j*(Nx + 1)]*std::exp( -zj*omega*t )*Dt;
    }
}