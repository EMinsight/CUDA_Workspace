#ifndef PERTURBATION_H_
#define PERTURBATION_H_

class perturbation{
private:
    float Lati, Longi, Alti;
    int P_r0, P_th0, P_phi0;
    float N0;
    float Sigma_r;
    float Sigma_h;

public:
    void set_alpha(float);
    void set_alt(float);
    void set_th(float);
    void set_phi(float);
    void set_sigr(float);
    void set_sigh(float);
    void set_geo(float, float, float);
    void set_center(int, int, int);
    void set_sigma(float, float);

    float lati(void){ return Lati; }
    float longi(void){ return Longi; }
    float alti(void){ return Alti; }
    float r0(void){ return P_r0; }
    float th0(void){ return P_th0; }
    float phi0(void){ return P_phi0; }
    float alpha(void){ return N0; }
    float sig_r(void){ return Sigma_r; }
    float sig_h(void){ return Sigma_h; }
};
#endif /* PERTURBATION_H_ */