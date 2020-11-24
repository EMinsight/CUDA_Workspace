#define _USE_MATH_DEFINES
#include <cuda.h>
#include <cmath>
#include <stdio.h>

const float C0 { 3.0e8 };
const float MU0 { 4.0e-7 * M_PI };
const float EPS0 { 1.0/MU0/MU0 };

const int Nx { 100 };
const int NY { 100 };

const float Dx { 1.0e3 };
const float Dy { 1.0e3 };
const float Tmax { 0.5e-3 };
const float Dt { 0.99/C0/std::sqrt( 1.0/Dx/Dx + 1.0/Dy/Dy ) };

__global__ void add( float* a, float* b, float* c );

inline int idx_Ez( int i, int j ){ return i + j*( Nx + 1 ); }
inline int idx_Hx( int i, int j ){ return i + j*( Nx + 1 ); }
inline int idx_Hy( int i, int j ){ return i + j*Nx; }