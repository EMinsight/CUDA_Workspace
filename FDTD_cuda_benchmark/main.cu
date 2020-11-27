#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>
#include <fstream>
#include <string>
#include <cuda.h>
#include <cuda_runtime.h>

#include "main.h"

constepr int Num_Individual { 1 };

int main( void ){

    std::ofstream ofs;

    ofs.open("./result/Magnitude.dat");

    perturbation *P_info = new perturbation[Num_Individual];
    for( int i = 0; i < Num_Individual; i++ ){
        P_info[i].set_alpha( 10.0 );
        P_info[i].set_center( 74.0, Nr/2, Nphi/2 );
        P_info[i].set_sigma( 2.0e3, 60.0e3 );
    }

    /* Set Y(Year)M(Month)D(Date) */
    date ymd;
    ymd.set_ymd( 2016, 3, 1 );
    ymd.set_h( 9.0 );

    /* Set geocoordinate points */
    geocoordinate lla_info;
    lla_info.set_point( 32.0, 135.0, (Alt_lower_ionosphere/1.0e3) );

    /* Observation Points on propagation path */
    int Num_obs = ( Nphi -2*L ) - k_s + 1;

    geocoordinate *obs_p = new geocoordinate[Num_obs];
    for( int k = 0; k < Num_obs; k++ ){
        obs_p[k].set_obs( 0, 50, k + k_s );
    }

    /* Magnitude */
    float *Magnitude = new float[ Num_Individual*Num_obs ];

    return 0;
}