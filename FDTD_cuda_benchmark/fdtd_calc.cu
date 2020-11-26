#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>
#include <complex>
#include <fstream>
#include <string>
#include <chrono>

#include "fdtd3d.h"

const float R_r{ 100.0e3 };

const float delta_r = R_r/float(Nr);
const float delta_theta = 1.0e3/float(R0);
const float delta_phi = 1.0e3/float(R0);
const float Dt = float( 0.99/C0/std::sqrt(1.0/delta_r/delta_r
 + 1.0/R0/R0/delta_theta/delta_theta
 + 1.0/R0/R0/std::sin(THETA0)/std::sin(THETA0)/delta_phi/delta_phi) );
const float inv_Dt = 1.0/Dt;
const float sigma_t = 7*Dt;
const float t0 = 6.0*sigma_t;

// PML info //
const int L { 10 };
const float M {3.5 };
const float R { 1.0e-6 };

const float sigma_th_max = float( -(M + 1.0)*C0*std::log(R)/2.0/double(L)/delta_theta/R0 );
const float sigma_phi_max = float( -(M + 1.0)*C0*std::log(R)/2.0/double(L)/delta_phi/R0 );

// Ionosphere info //
constexpr float Alt_lower_ionosphere { 60.0e3 };
const int ion_L = int( (R_r - Alt_lower_ionosphere )/delta_r );
const float freq { 22.2e3 };
const float omega = 2.0*M_PI*freq;

// Geomagnetic info //
const float B_abs = float( 4.6468e-5 );
const float Dec = float( -7.0*M_PI/180.0 );
const float Inc = float( 49.0*M_PI/180.0 );
const float Azim = float( 61.0*M_PI/180.0 );

void fdtd_calc( )
{
    int t_step = 1800;
    float t;
    float J;
    int NEW;
    int OLD;
    std::complex <float> zj(0.0, 1.0);

    float* Hr, *Htheta, *Hphi;
    Hr = new float [ (Nr + 1)*Ntheta*(Nphi) ];
    Htheta = new float [ Nr*(Ntheta+1)*Nphi ];
    Hphi = new float [Nr*Ntheta*(Nphi+1) ];



}