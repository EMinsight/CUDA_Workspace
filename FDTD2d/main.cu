#define _USE_MATH_DEFINES

#include <iostream>
#include <cmath>
#include <fstream>
#include <string>
#include <stdio.h>



int main( void )
{
    /* Memory allocate (host) */
    float *Ez = new float[ ( Nx+1 )*( Ny+1 )];
    float *Hx = new float[ ( Nx+1 )*Ny ];
    float *Hy = new float[ Nx*( Ny+1 ) ];

    /* initialize */
    for( int i = 0; i < Nx+1; i++ ){
        for( int j = 0; j < Ny+1; j++ ) Ez[ idx_Ez(i, j) ] = 0.0;
    }

    for( int i = 0; i < Nx+1; i++ ){
        for( int j = 0; j < Ny; j++ ) Hx[ idx_Hx(i, j) ] = 0.0;
    }

    for( int i = 0; i < Nx; i++ ){
        for( int j = 0; j < Ny+1; j++ ) Hy[ idx_Hy(i, j) ] = 0.0;
    }

    /* Memory allocate (device) */
    /*float *Ez_d, *Hx_d, *Hy_d;
    cudaMalloc( (void**)&Ez_d, sizeof(float)*(Nx+1)*(Ny+1) );
    cudaMalloc( (void**)&Hx_d, sizeof(float)*(Nx+1)*Ny );
    cudaMalloc( (void**)&Hy_d, sizeof(float)*Nx*(Ny+1) );*/

    /* Copy to Device */
    /*cudaMemcpy( Ez_d, Ez, sizeof(float)*(Nx+1)*(Ny+1),  cudaMemcpyToDevice );
    cudaMemcpy( Hx_d, Hx, sizeof(float)*(Nx+1)*Ny,  cudaMemcpyToDevice );
    cudaMemcpy( Hy_d, Hy, sizeof(float)*Nx*(Ny+1),  cudaMemcpyToDevice );*/

    /* a + b = c */
    float *a = new float[ Nx ];
    float *b = new float[ Nx ];
    float *c = new float[ Nx ];

    for( int i = 0; i < Nx; i++ ){
        a[i] = (float)i;
        b[i] = 2.5*(float)i;
        c[i] = 0.0;
    }

    // memory allocate (device) //
    float *a_d, *b_d, *c_d;
    cudaMalloc( (void**)&a_d, sizeof(float)*Nx );
    cudaMalloc( (void**)&b_d, sizeof(float)*Nx );
    cudaMalloc( (void**)&c_d, sizeof(float)*Nx );

    // Copy to Device //
    cudaMemcpy( a_d, a, sizeof(float)*Nx,   cudaMemcpyToDevice );
    cudaMemcpy( b_d, b, sizeof(float)*Nx,   cudaMemcpyToDevice );
    cudaMemcpy( c_d, c, sizeof(float)*Nx,   cudaMemcpyToDevice );

    dim3 Dg(10,10,1), Db(10,10,1);

    add <<<Dg, Db>>> ( a, b, c );

    //int NT{ Tmax/Dt };

    /*for( int n = 0; n < NT; n++ ){

    }*/

}