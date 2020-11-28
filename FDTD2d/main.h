#define _USE_MATH_DEFINES
#include <cmath>

const double C0 { 3.0e8 };
const double MU0 { 4.0e-7 * M_PI };
const double EPS0 { 1.0/MU0/C0/C0 };

const int Nx { 100 };
const int Ny { 100 };
const int i_s { Nx/2 };
const int j_s { Ny/2 };

const double Dx { 1.0e3 };
const double Dy { 1.0e3 };
const double Tmax {  0.5e-3 };
const double Dt { 0.999/C0/std::sqrt( 1.0/Dx/Dx + 1.0/Dy/Dy ) };
const double sig { 10.0*Dt };
const double t0 { 5.0*sig };

const double CEz1 { Dt/EPS0/Dx };
const double CEz2 { Dt/EPS0/Dy };
const double CHx { Dt/MU0/Dy };
const double CHy { Dt/MU0/Dx };

void update_Ez( double **Ez, double **Hx, double **Hy );
void update_Hx( double **Hx, double **Ez );
void update_Hy( double **Hy, double **Ez );
