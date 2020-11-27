#define _USE_MATH_DEFINES
#include <cmath>
#include "fdtd3d.h"

//GEOCOORDINATE class//
void geocoordinate::set_lati(float lati){
    Lati = lati;
}

void geocoordinate::set_longi(float longi){
    Longi = longi;
}

void geocoordinate::set_alt(float alt){
    Alt = alt;
}

void geocoordinate::set_point(float lati, float longi, float alt){
    set_lati(lati);
    set_longi(longi);
    set_alt(alt);
}

void geocoordinate::geo_ijk(float lati, float longi, float alti){
    //float unit_lati = (2.0 * M_PI * R0 / 1000.0) * (lati - 135.0)/360.0;    /* 緯度1°の距離 (えびの起点) */

    //I = ;
    //J = ;
    Geo_K = alti/1.0e3;
}

void geocoordinate::set_obs(int i, int j, int k){
    Obs_I = i;
    Obs_J = j;
    Obs_K = k;
}