#ifndef FDTD_H_
#define FDTD_H_

#define _USE_MATH_DEFINES
#include <cmath>
#include "pml.h"
#include "geocoordinate.h"
#include "perturbation.h"
#include "date.h"

const float C0 {3.0e8};
const float MU0 {4.0*M_PI*1.0e-7};
const float EPS0 {1.0/MU0/C0/C0};
const float EPSR {10.0};
const float Z0 {std::sqrt(MU0/EPS0)};
const float R0 {6370e3};
const float THETA0 {float( M_PI*0.5 - std::atan(50e3/R0) )};
const float E_Q {1.6e-19};
const float E_M {9.11e-31};
const float SIGMA_PEC { 1.0e7 };
const float SIGMA_SEA { 1.0 };
const float SIGMA_WET_GROUND { 1.0e-2 };
const float SIGMA_DRY_GROUND { 1.0e-3 };
const float SIGMA_VERY_DRY_GROUND { 1.0e-4 };
const float SIGMA_FRESH_WATER_ICE { 1.0e-5 };

const int Nr { 100 };
const int Ntheta { 100 };
const int Nphi { 1000 };

extern const float R_r;

// Delte info //
extern const float delta_r;
extern const float delta_theta;
extern const float delta_phi;
extern const float Dt;
extern const float inv_Dt;
extern const float sigma_t;
extern const float t0;

// PML info //
extern const int L;
extern const float M;
extern const float R;
extern const float sigma_th_max;
extern const float sigma_phi_max;

// Ionosphere info //
extern const float Alt_lower_ionosphere;
extern const int ion_L;
extern const float freq;
extern const float omega;

// Geomagnetic info //
extern const float B_abs;
extern const float Dec;
extern const float Inc;
extern const float Azim;

// Center Point //
const int i_0 = Nr/2;
const int j_0 = Ntheta/2;
const int k_0 = Nphi/2;

// Source Point //
const int i_s { 1 };
const int j_s { 50 };
const int k_s { 100 };

// Receive Point //
const int i_r { 1 };
const int j_r { 50 };
const int k_r { Nphi - 50 };

void array_initialize( float* array, int size );

void PML_field_initialize( 
    float* Dr_theta1, float* Dr_theta2, float* Dr_phi,
    float* Dtheta_phi, float* D_theta_r,
    float* Dphi_r, float* Dphi_thetea,
    float* Hr_theta1, float* Hr_theta2, float* Hr_phi,
    float* Htheta_phi, float* H_theta_r,
    float* Hphi_r, float* Hphi_thetea
);



void geo_mag( float* geo_B, float *sph_B );

void Ne_allocate( float* Electron_Density, float* Electron_in_spherical );
void ny_allocate( date, geocoordinate, float* Geomagnetic_in_spherical );

inline double dist(double i){return R0 + i*delta_r;};
inline double th(double j){return THETA0 + j*delta_theta;};
inline double ph(double k){return k*delta_phi;};

inline double C_1(double sig){return ((inv_Dt - sig/2.0)/(inv_Dt + sig/2.0));};
inline double C_2(double r, double sig){return 1.0/r/delta_theta/(inv_Dt + sig/2.0);};
inline double C_3(double r, double theta){return Dt*std::cos(theta)/std::sin(theta)/2.0/r;};
inline double C_4(double r, double theta, double sig){return 1.0/r/std::sin(theta)/delta_phi/(inv_Dt + sig/2.0);};
inline double C_5(double r){return Dt/r/delta_r;};
inline double C_6(double r, double sig){return 1.0/(inv_Dt + sig/2.0)/r/delta_theta;};


#endif  // FDTD_H_ //