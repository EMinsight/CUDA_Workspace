#define _USE_MATH_DEFINES
#include <cmath>
#include <complex>
#include "fdtd3d.h"

std::complex <float> surface_impe( std::complex <float> zj )
{
    float conduct = SIGMA_VERY_DRY_GROUND;

    std::complex <float> z = Z0/std::sqrt(EPSR - (zj*conduct/EPS0/omega) );

    return z;
}