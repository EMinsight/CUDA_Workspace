#define _USE_MATH_DEFINES
#include <iostream>
#include <chrono>
#include <fstream>
#include <cmath>
#include "main.h"

int main( void ){

  double total_time;
    double **Ez, **Hx, **Hy;

    Ez = new double* [ Nx + 1 ];
    for( int i = 0; i < Nx + 1; i++ ){
        Ez[i] = new double[ Ny + 1];
        for( int j = 0; j < Ny + 1; j++ ){
            Ez[i][j] = 0.0;
        }
    }

    Hx = new double* [Nx + 1];
    for( int i = 0; i < Nx + 1; i++ ){
        Hx[i] = new double[ Ny + 1 ];
        for( int j = 0; j < Ny; j++ ){
            Hx[i][j] = 0.0;
        }
    }

    Hy = new double* [Nx];
    for( int i = 0; i < Nx; i++ ){
        Hy[i] = new double[ Ny + 1 ];
        for( int j = 0; j < Ny + 1; j++ ){
            Hy[i][j] = 0.0;
        }
    }

    int NT{ int(Tmax/Dt) };

    std::chrono::system_clock::time_point start
      = std::chrono::system_clock::now();

    for( int n = 0; n < NT; n++ ){

      /*  add Jz */
        double t = ( double(n) - 0.5 )*Dt;

        Ez[i_s][j_s] = Ez[i_s][j_s]
          - Dt/EPS0 * std::exp( -(t - t0)*(t - t0) / 2.0/ sig / sig );

        update_Ez( Ez, Hx, Hy );

        update_Hx( Hx, Ez );

        update_Hy( Hy, Ez );

        std::string filename = "./result/ez_" + std::to_string(n) + ".dat";
        std::ofstream ofs(filename.c_str() );

        for( int i = 0; i < Nx + 1; i++ ){
          for( int j = 0; j < Ny + 1; j++ ){
            ofs << i << " " << j << " " << Ez[i][j] << "\n";
          }
          ofs << "\n";
        }

        ofs.close();
    }

    std::chrono::system_clock::time_point end
      = std::chrono::system_clock::now();

    total_time = std::chrono::duration_cast <std::chrono::milliseconds>
      (end - start).count();

    std::cout << Ez[i_s][j_s] << "\n";

    std::cout << "elapsed time : " << total_time*1.0e-3 << " [s]" << "\n"; 

    return 0;
}





