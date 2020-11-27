#ifndef GEOCOORDINATE_H_
#define GEOCOORDINATE_H_

class geocoordinate{
private:
    float Lati, Longi, Alti;
    int Geo_I, Geo_J, Geo_K;
    int Obs_I, Obs_J, Obs_K;

public:
    void set_lati( float );
    void set_longi( float );
    void set_alt( float );
    void set_point( float, float, float );
    void geo_ijk( float, float, float );
    void set_obs( int, int, int );

    float lati(void){ return Lati; }
    float longi(void){ return Longi; }
    float alt(void){ return Alt; }
    int geo_i(void){ return Geo_I; }
    int geo_j(void){ return Geo_J; }
    int Geo_k(void){ return Geo_K; }
    int i(void){ return Obs_I; }
    int j(void){ return Obs_J; }
    int k(void){ return Obs_K; }

};

#endif /* GEOCOORDINATE_H_ */