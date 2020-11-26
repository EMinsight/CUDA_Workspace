#include <iostream>
#include <cmath>
#include <fstream>
#include <string>
#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>

constexpr float C0 { 3.0e8 };
constexpr float MU0 { 4.0e-7 * M_PI };
constexpr float EPS0 { 1.0/MU0/C0/C0 };

constexpr int Nx { 100 };
constexpr int Ny { 100 };
constexpr float Dx { 1.0e3 };
constexpr float Dy { 1.0e3 };
constexpr float Tmax { .5e-3 };

int idx_ez(int i, int j){
  return i*(Ny+1) + j;
  //return i + j*(Nx+1);
}

int idx_hx(int i, int j){
  return i*Ny + j;
  //return i + j*(Nx + 1);
}

int idx_hy(int i, int j){
  return i*(Ny+1) + j;
  //return i + j*Nx;
}

__global__ void update_Ez(float *Ez_d, float *Hx_d, float *Hy_d,
int Nx, int Ny, float CEz1, float CEz2){

  int i = blockDim.x * blockIdx.x + threadIdx.x;
  int j = blockDim.y * blockIdx.y + threadIdx.y;

  if ( (i > 0) && (i < Nx) && (j > 0) && (j < Ny) ){
    Ez_d[i*(Ny+1)+j] = Ez_d[i*(Ny+1)+j]
    + CEz1 * (Hy_d[i*(Ny+1) + j] - Hy_d[(i-1)*(Ny+1) + j])
    - CEz2 * (Hx_d[i*Ny + j]     - Hx_d[i*Ny + j-1]);
  }
  /*if( (i > 0) && (i < Nx) && (j > 0) && (j < Ny)){
        Ez_d[i + j*(Nx + 1)] = Ez_d[i + j*(Nx + 1)]
                            + CEz1 * (Hy_d[i + j*Nx] - Hy_d[(i-1) + j*Nx])
                            - CEz2 * (Hx_d[i + j*(Nx + 1)] - Hx_d[i + (j-1)*(Nx + 1)]);
  }*/
}

__global__ void update_Hx(float *Hx_d, float *Ez_d,
int Nx, int Ny, float CHx){
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  int j = blockDim.y * blockIdx.y + threadIdx.y;

  if ( (i > 0) && (i < Nx) && (j >= 0) && (j < Ny) ){
    Hx_d[i*Ny + j] = Hx_d[i*Ny + j]
    - CHx * (Ez_d[i*(Ny+1) + j+1] - Ez_d[i*(Ny+1) + j]);
  }
  /*if( (i > 0) && ( i < Nx) && ( j >= 0) && ( j < Ny) ){
        Hx_d[i + j*(Nx+1)] = Hx_d[i + j*(Nx+1)]
         - CHx * ( Ez_d[i + (j+1)*(Nx+1)] - Ez_d[i + j*(Nx+1)] );
  }*/
}

__global__ void update_Hy(float *Hy_d, float *Ez_d,
int Nx, int Ny, float CHy){
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  int j = blockDim.y * blockIdx.y + threadIdx.y;

  if ( (i >= 0) && (i < Nx) && (j > 0) && (j < Ny) ){
    Hy_d[i*(Ny+1) + j] = Hy_d[i*(Ny+1) + j]
    + CHy * (Ez_d[(i+1)*(Ny+1) + j] - Ez_d[i*(Ny+1) + j]);
  }
  /*if( (i >= 0) && (i < Nx) && (j > 0) && (j < Ny) ){
        Hy_d[i + j*Nx] = Hy_d[i + j*Nx]
                + CHy*( Ez_d[(i + 1) + j*(Nx+1)] - Ez_d[i + j*(Nx+1)] );
  }*/
}

__global__ void add_Jz(float *Ez_d, int i_s, int j_s,
float t, float Dt, float EPS0, float sig, float t0){
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  int j = blockDim.y * blockIdx.y + threadIdx.y;

  if ( (i == i_s) && (j == j_s) ){
    Ez_d[i*(Ny+1)+j] = Ez_d[i*(Ny+1)+j]
    - Dt/EPS0 * exp( - (t - t0)*(t - t0) / 2.0 / sig/sig );

  }
  /*if( (i == i_s) && (j == j_s) ){
        Ez_d[i + j*(Nx + 1)] = Ez_d[i + j*(Nx + 1)]
         - Dt/EPS0 * std::exp( -(t - t0)*(t - t0) / 2.0 / sig / sig );
  }*/
}

int main(void){
  const float Dt { float(0.999/C0/std::sqrt(1./Dx/Dx + 1./Dy/Dy)) };
  const int NT { int(Tmax/Dt) };
  std::cout << Dt << ", " << NT << std::endl;

  const float sig { 10*Dt };

  const float CEz1 { Dt/EPS0/Dx };
  const float CEz2 { Dt/EPS0/Dy };
  const float CHx { Dt/MU0/Dy };
  const float CHy { Dt/MU0/Dx };

  float *Ez = new float [ (Nx+1)*(Ny+1) ];
  float *Hx = new float [ (Nx+1)*Ny     ];
  float *Hy = new float [ Nx    *(Ny+1) ];
  for(int i = 0; i <= Nx; i++){
    for(int j = 0; j <= Ny; j++){
      Ez[idx_ez(i,j)] = 0.0;
    }
  }
  for(int i = 0; i <= Nx; i++){
    for(int j = 0; j < Ny; j++){
      Hx[idx_hx(i,j)] = 0.0;
    }
  }
  for(int i = 0; i < Nx; i++){
    for(int j = 0; j <= Ny; j++){
      Hy[idx_hy(i,j)] = 0.0;
    }
  }


  float *Ez_d, *Hx_d, *Hy_d;
  cudaMalloc( (void**)&Ez_d, sizeof(float)*(Nx+1)*(Ny+1) );
  cudaMalloc( (void**)&Hx_d, sizeof(float)*(Nx+1)*Ny );
  cudaMalloc( (void**)&Hy_d, sizeof(float)*Nx*(Ny+1) );

  cudaMemcpy(Ez_d, Ez, sizeof(float)*(Nx+1)*(Ny+1), cudaMemcpyHostToDevice);
  cudaMemcpy(Hx_d, Hx, sizeof(float)*(Nx+1)*Ny,     cudaMemcpyHostToDevice);
  cudaMemcpy(Hy_d, Hy, sizeof(float)*Nx*(Ny+1),     cudaMemcpyHostToDevice);

  dim3 Dg(10,10,1), Db(10,10,1);

  for(int n = 0; n < NT; n++){

    update_Ez <<<Dg, Db>>> (Ez_d, Hx_d, Hy_d, Nx, Ny, CEz1, CEz2);
    add_Jz <<<Dg, Db>>> (Ez_d, Nx/2, Ny/2, (n-0.5)*Dt, Dt, EPS0, sig, 5.0*sig);
    cudaDeviceSynchronize();

    update_Hx <<<Dg, Db>>> (Hx_d, Ez_d, Nx, Ny, CHx);
    update_Hy <<<Dg, Db>>> (Hy_d, Ez_d, Nx, Ny, CHy);

    cudaMemcpy(Ez, Ez_d, sizeof(float)*(Nx+1)*(Ny+1), cudaMemcpyDeviceToHost);
    std::string filename("ez_" + std::to_string(n) + ".dat");
    std::ofstream ofs(filename.c_str());
    for(int i = 0; i <= Nx; i++){
      for(int j = 0; j <= Ny; j++){
        ofs << i << " " << j << " "
        << Ez[idx_ez(i,j)] << "\n";
      }
      ofs << "\n";
    }
    ofs.close();

    cudaDeviceSynchronize();
  }

  std::cout << Ez[idx_ez(25, 25)] << std::endl;

  cudaFree(Ez_d);
  cudaFree(Hx_d);
  cudaFree(Hy_d);
}
