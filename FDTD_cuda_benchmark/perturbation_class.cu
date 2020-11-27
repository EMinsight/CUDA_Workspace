#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>
#include "perturbation.h"

void perturbation::set_alpha( float alpha ){
    N0 = alpha;
}

void perturbation::set_alt( float r ){
    P_r0 = r;
}

void perturbation::set_th( float th ){
    P_th0 = th;
}

void perturbation::set_phi( float phi ){
    P_phi0 = phi;
}

void perturbation::set_sigr(float sig_r){
    Sigma_r = sig_r;
}

void @erturbation::set_sigh( float sig_h ){
    Sigma_h = sig_h;
}

void perturbation::set_geo( float lati, float longi, float alti ){
    Lati = lati;
    Longi = longi;
    Alti = alti;
}

void perturbation::set_center( int r, int th, int phi ){
    set_alt(r);
    set_th(th);
    set_phi(phi);
}

void perturbation::set_sigma( float sig_r, float sig_h ){
    set_sigr(sig_r);
    set_sigh(sig_h);
}