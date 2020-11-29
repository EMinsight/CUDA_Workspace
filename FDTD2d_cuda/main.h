#define _USE_MATH_DEFINES
#include <cuda.h>
#include <cmath>
#include <complex>
#include <stdio.h>

const float C0 { 3.0e8 };
const float MU0 { 4.0e-7 * M_PI };
const float EPS0 { 1.0/MU0/C0/C0 };

const int Nx { 100 };
const int Ny { 100 };
const int i_s { Nx/2 };
const int j_s { Ny/2 };

const float Dx { 1.0e3 };
const float Dy { 1.0e3 };
const float Tmax { 0.5e-3 };
const float Dt { float( 0.999/C0/std::sqrt( 1.0/Dx/Dx + 1.0/Dy/Dy )) };
const float sig { float(10*Dt) };
const float t0 { float(5*sig) };
const float omega { 22.2e3 };

const float CEz1 { float(Dt/EPS0/Dx) };
const float CEz2 { float(Dt/EPS0/Dy) };
const float CHx { float(Dt/MU0/Dy) };
const float CHy { float(Dt/MU0/Dx) };

__global__ void add_Jz( int i_s, int j_s, float* Ez_d, float t, float Dt, float t0, float sigma, float EPS0 );
__global__ void update_Ez( int Nx, int Ny, float* Ez_d, float* Hx_d, float* Hy_d, float Coeff_Ez1, float Coeff_Ez2 );
__global__ void update_Hx( int Nx, int Ny, float* Hx_d, float* Ez_d, float Coeff_Hx );
__global__ void update_Hy( int Nx, int Ny, float* Hy_d, float* Ez_d, float Coeff_Hy );
__global__ void fourie( int Nx, int Ny, std::complex <float> zj, float omega, 
                        float time, float* Ez_d, std::complex <float>* Ez_famp_d ); 

//__global__ void add( float* a, float* b, float* c );

//inline int idx_Ez( int i, int j ){ return i + j*( Nx + 1 ); }
inline int idx_Ez( int i, int j ){ return i + j*( Nx + 1); }
inline int idx_Hx( int i, int j ){ return i + j*( Nx + 1); }
inline int idx_Hy( int i, int j ){ return i + j*Nx; }

