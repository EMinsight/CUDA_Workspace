#define _USE_MATH_DEFINES
#include <cmath>
#include "fdtd3d.h"

__global__ void add_J( 
    int Nr, int Ntheta, int Nphi, float delta_r, float delta_theta, float delta_phi, float delta_t,
    float sigma_t, int t_0, int i_s, int j_s, int k_s, float *Etheta_d){

    int i = blockDim.x * blockIdx.x + threadIdx.x;
    int j = blockDim.y * blockIdx.y + threadIdx.y;
    

    if( (i == i_s) && (j == j_s) && (k == k_s) ){
        E_theta_d[i*()]
    }


}