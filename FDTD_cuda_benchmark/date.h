#ifndef DATE_H_
#define DATE_H_

class date{
private:
    int Year, Month, Day;
    int MD;
    float Hour;

public:
    void set_y( int y );
    void set_m( int m );
    void set_d( int d );
    void set_h( float h );
    void set_ymd( int y, int m, int d );

    int iy(void){ return Year; }
    int im(void){ return Month; }
    int id(void){ return Day; }
    int imd(void){ return MD; }
    float ih(void){ return Hour; }
};

#endif