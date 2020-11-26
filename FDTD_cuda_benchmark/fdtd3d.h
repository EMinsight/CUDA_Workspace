#ifndef FDTD_H_
#define FDTD_H_

#define _USE_MATH_DEFINES
#include <cmath>

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


#endif  // FDTD_H_ //