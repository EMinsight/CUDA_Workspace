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

void fdtd_calc(perturbation P_info, date ymd, geocoordinate lla_info, 
                            int Num_obs, geocoordinate* obs_p, float* Magnitude )
{
    int t_step = 1800;
    float t;
    float J;
    int NEW;
    int OLD;
    std::complex <float> zj(0.0, 1.0);

    float* Hr, *Htheta, *Hphi;
    Hr = new float [ (Nr + 1)*Ntheta*Nphi ];
    Htheta = new float [ Nr*(Ntheta + 1)*Nphi ];
    Hphi = new float [ Nr*Ntheta*(Nphi + 1) ];
    array_initialize( Hr, (Nr + 1)*Ntheta*(Nphi) );
    array_initialize( Htheta, Nr*(Ntheta + 1)*Nphi );
    array_initialize( Hphi, Nr*Ntheta*(Nphi + 1) )

    float* Er, *Etheta, *Ephi;
    Er = new float[ 2*Nr*(Ntheta + 1)*(Nphi + 1)　];
    Etheta = new float[ 2*(Nr + 1)*Ntheta*(Nphi + 1) ];
    Ephi = new float[ 2*(Nr + 1)*(Ntheta + 1)*Nphi ];
    array_initialize( Er, 2*Nr*(Ntheta + 1)*(Nphi + 1) );
    array_initialize( Etheta, 2*(Nr + 1)*Ntheta*(Nphi + 1) );
    array_initialize( Ephi, 2*(Nr + 1)*(Ntheta + 1)*Nphi );

    float* Dr, *Dtheta, *Dphi;
    Dr = new float[ 2*Nr*(Ntheta + 1)*(Nphi + 1)　];
    Dtheta = new float[ 2*(Nr + 1)*Ntheta*(Nphi + 1) ];
    Dphi = new float[ 2*(Nr + 1)*(Ntheta + 1)*Nphi ];
    array_initialize( Dr, 2*Nr*(Ntheta + 1)*(Nphi + 1) );
    array_initialize( Dtheta, 2*(Nr + 1)*Ntheta*(Nphi + 1) );
    array_initialize( Dphi, 2*(Nr + 1)*(Ntheta + 1)*Nphi );

    float *Dr_theta1, *Dr_theta2, *Dr_phi;
    float *Dtheta_phi, *Dtheta_r;
    float *Dphi_r, *Dphi_theta;

    float *Hr_theta1, *Hr_theta2, *Hr_phi;
    float *Htheta_phi, *Htheta_r;
    float *Hphi_r, *Hphi_theta;

    /////////////////////////////////////////////////
    ////////////////ここをどうするか/////////////////
    /////////////////////////////////////////////////

    pml* idx_Dr = new pml[4];
    pml* idx_Dth = new pml[4];
    pml* idx_Dphi = new pml[4];
    pml* idx_Hr = new pml[4];
    pml* idx_Hth = new pml[4];
    pml* idx_Hphi = new pml[4];

    pml_idx_initialize(
        idx_Dr, idx_Dth, idx_Dphi,
        idx_Hr, idx_Hth, idx_Hphi
    );

    float *sigma_theta, *sigma_phi, *sigma_thetea_h, *sigma_phi_h;
    sigma_theta = new float[ Ntheta + 1 ];
    sigma_phi = new float[ Nphi + 1 ];
    sigma_theta_h = new float[ Ntheta + 1 ];
    sigma_phi_h = new float[ Nphi + 1 ];

    float *geo_B = new float[3];
    float *sph_B = new float[3];

    geo_mag( geo_B, sph_B );

    // Ne, nyu //
    float *Nh = new float[ion_L];
    //float *noise_Nh = new float[(ion_L + 1)*(Ntheta + 1)*(Nphi + 1)];
    float *noise_Nh = new float[ion_L*Ntheta*Nphi];
    float *ny = new float[ion_L + 1];
    float *Re = new float[ion_L + 1]; 

    Ne_allocate(Nh, Re);
    ny_allocate(ymd, lla_info, ny, Re);

    float *Cmat = new float[ion_L*Ntheta*Nphi*3*3];
    float *Fmat = new float[ion_L*Ntheta*Nphi*3*3];

    set_perturbation( P_info, noise_Nh, Nh );
    set_matrix( zj, Cmat, Fmat, noise_Nh, ny );

    // calculate surface impedance //
    std::complex <float> Z(0.0, 0.0);
    float Z_real, Z_imag;

    Z = surface_impe(zj);

    Z_real = Z.real();
    Z_imag = Z.imag()/omega;

    t = Dt*0.0;

    // fourie //
    std::complex <float>* E_famp = new std::complex <float> [Num_obs];

}