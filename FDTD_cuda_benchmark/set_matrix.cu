#define _USE_MATH_DEFINES
#include <cmath>
#include <complex>
#include <Eigen/Core>
#include <Eigen/Dense>

#include "fdtd3d.h"

void set_matrix(
    std::complex <float> zj, float *Cmat, float *Fmat,
    float *Nh, float *Ny ){
    
    float omg_c = E_Q*B_abs/E_M;

    for(int ir = Nr - ion_L; ir < Nr; ir++ ){
        int i = ir - (Nr - ion_L);

        for( int j = 0; j < Ntheta; j++ ){
            for( int k = 0; k < Nphi; k++ ){
                float omg_p = E_Q*std::sqrt( Nh[i*(Ntheta*Nphi) + j*Nphi + k]/E_M/EPS0 );
                std::complex <float> omg = omega -zj * Ny[i];
                std::complex <float> diag_comp = omg/(omg_c*omg_c - omg*omg);
                std::complex <float> offd_comp = zj * omg_c / (omg_c*omg_c - omg*omg);
                std::complex <float> coef = zj * EPS0 * omg_p*omg_p;

                Eigen::Matrix3d Sigma = Eigen::Matrix3d::Zero(3, 3);
                Sigma(0, 0) = real( coef*diag_comp );
                Sigma(1, 1) = real( coef*diag_comp );
                Sigma(0, 1) = real( coef*offd_comp );
                Sigma(1, 0) = real( -1.0*coef*offd_comp );
                Sigma(2, 2) = real( -1.0*coef/omg );

                Eigen::Matrix3d A =
                                EPS0/Dt*Eigen::Matrix3d::Identity(3, 3) + 0.5*Sigma;
                Eigen::Matrix3d B =
                                EPS0/Dt*Eigen::Matrix3d::Identity(3, 3) - 0.5*Sigma;
                Eigen::Matrix3d C = A.inverse()*B;
                Eigen::Matrix3d F = 1.0/Dt*A.inverse();

                for( int m = 0; m < 3; m++ ){
                    for( int n = 0; n < 3; n++ ){
                        int idx = i*(Ntheta*Nphi*3*3) + j*(Nphi*3*3) + k*(3*3)
                                            + m*3 + n;
                        Cmat[ idx ] = C(m, n);
                        Fmat[ idx ] = F(m, n);
                    }
                }

            }
        }

    }
}