require "colourdistance/version"
require "inline"

module Colourdistance
  inline(:C) do |builder|
    builder.include '<stdio.h>'
    builder.include '<math.h>'

    builder.c_singleton 'VALUE ciede94(VALUE color1, VALUE color2) {
      double pi = 3.1415927;
      double e = 2.7182818;
      double l1;
      double l2;
      double a1;
      double a2;

      
      double r1 = NUM2DBL(rb_hash_aref(color1, rb_str_intern(rb_str_new2("r"))))/255.0;
      double g1 = NUM2DBL(rb_hash_aref(color1, rb_str_intern(rb_str_new2("g"))))/255.0;
      double b1 = NUM2DBL(rb_hash_aref(color1, rb_str_intern(rb_str_new2("b"))))/255.0;

      double r2 = NUM2DBL(rb_hash_aref(color2, rb_str_intern(rb_str_new2("r"))))/255.0;
      double g2 = NUM2DBL(rb_hash_aref(color2, rb_str_intern(rb_str_new2("g"))))/255.0;
      double b2 = NUM2DBL(rb_hash_aref(color2, rb_str_intern(rb_str_new2("b"))))/255.0;

      r1 = ((r1 <= 0.04045) ? r1 / 12.92 : pow(((r1 + 0.055) / 1.055),2.4));
      g1 = ((g1 <= 0.04045) ? g1 / 12.92 : pow(((g1 + 0.055) / 1.055),2.4));
      b1 = ((b1 <= 0.04045) ? b1 / 12.92 : pow(((b1 + 0.055) / 1.055),2.4));

      r2 = ((r2 <= 0.04045) ? r2 / 12.92 : pow(((r2 + 0.055) / 1.055),2.4));
      g2 = ((g2 <= 0.04045) ? g2 / 12.92 : pow(((g2 + 0.055) / 1.055),2.4));
      b2 = ((b2 <= 0.04045) ? b2 / 12.92 : pow(((b2 + 0.055) / 1.055),2.4));

      double x1 = 0.412453 * r1 + 0.357580 * g1 + 0.180423 * b1;
      double y1 = 0.212671 * r1 + 0.715160 * g1 + 0.072169 * b1;
      double z1 = 0.019334 * r1 + 0.119193 * g1 + 0.950227 * b1;

      double x2 = 0.412453 * r2 + 0.357580 * g2 + 0.180423 * b2;
      double y2 = 0.212671 * r2 + 0.715160 * g2 + 0.072169 * b2;
      double z2 = 0.019334 * r2 + 0.119193 * g2 + 0.950227 * b2;

      double fx;
      double fy;
      double fz;

      if(x1 <= 0.008856){
        fx = 7.787 * x1/0.95047 + 16.0/116.0;
      }else{
        fx = cbrt(x1/0.95047);
      }

      if(y1 <= 0.008856){
        l1 = 903.3 * y1;
        fy = (7.787 * y1 + 16.0/116.0);
      }else{
        l1 = 116.0 * cbrt(y1) - 16.0;
        fy = cbrt(y1);
      }

      if(z1 <= 0.008856){
        fz = 7.787 * z1/1.08883 + 16.0/116.0;
      }else{
        fz = cbrt(z1/1.08883);
      }

      a1 = 500.0 * (fx-fy);
      b1 = 200.0 * (fy-fz);


      if(x2 <= 0.008856){
        fx = (7.787 * x2/0.95047 + 16.0/116.0);
      }else{
        fx = cbrt(x2/0.95047);
      }

      if(y2 <= 0.008856){
        l2 = 903.3 * y2;
        fy = (7.787 * y2 + 16.0/116.0);
      }else{
        l2 = 116.0 * cbrt(y2) - 16.0;
        fy = cbrt(y2);
      }

      if(z2 <= 0.008856){
        fz = (7.787 * z2/1.08883 + 16.0/116.0);
      }else{
        fz = cbrt(z2/1.08883);
      }

      a2 = 500.0 * (fx-fy);
      b2 = 200.0 * (fy-fz);

      double kl = 2.0;
      double k1 = 0.048;
      double k2 = 0.014;

      double c1 = sqrt(a1*a1+b1*b1);
      double c2 = sqrt(a2*a2+b2*b2);
      double cdelta = c2 - c1;

      double sc = 1.0 + k1 * c1;
      double sh = 1.0 + k2 * c1;

      double habdelta = sqrt((a2-a1)*(a2-a1)+(b2-b1)*(b2-b1) - cdelta*cdelta);

      double ldiff = (l1 - l2)/kl;
      double adiff = cdelta/sc;
      double bdiff = habdelta/sh;

      return DBL2NUM(sqrt(ldiff*ldiff+adiff*adiff+bdiff*bdiff)/50.0);
    }'

    builder.c_singleton 'VALUE ciede2000(VALUE color1, VALUE color2) {
      double pi = 3.1415927;
      double e = 2.7182818;
      double l1;
      double l2;
      double a1;
      double a2;

      double r1 = NUM2DBL(rb_hash_aref(color1, rb_str_intern(rb_str_new2("r"))))/255.0;
      double g1 = NUM2DBL(rb_hash_aref(color1, rb_str_intern(rb_str_new2("g"))))/255.0;
      double b1 = NUM2DBL(rb_hash_aref(color1, rb_str_intern(rb_str_new2("b"))))/255.0;

      double r2 = NUM2DBL(rb_hash_aref(color2, rb_str_intern(rb_str_new2("r"))))/255.0;
      double g2 = NUM2DBL(rb_hash_aref(color2, rb_str_intern(rb_str_new2("g"))))/255.0;
      double b2 = NUM2DBL(rb_hash_aref(color2, rb_str_intern(rb_str_new2("b"))))/255.0;

      r1 = ((r1 <= 0.04045) ? r1 / 12.92 : pow(((r1 + 0.055) / 1.055),2.4));
      g1 = ((g1 <= 0.04045) ? g1 / 12.92 : pow(((g1 + 0.055) / 1.055),2.4));
      b1 = ((b1 <= 0.04045) ? b1 / 12.92 : pow(((b1 + 0.055) / 1.055),2.4));

      r2 = ((r2 <= 0.04045) ? r2 / 12.92 : pow(((r2 + 0.055) / 1.055),2.4));
      g2 = ((g2 <= 0.04045) ? g2 / 12.92 : pow(((g2 + 0.055) / 1.055),2.4));
      b2 = ((b2 <= 0.04045) ? b2 / 12.92 : pow(((b2 + 0.055) / 1.055),2.4));

      double x1 = 0.412453 * r1 + 0.357580 * g1 + 0.180423 * b1;
      double y1 = 0.212671 * r1 + 0.715160 * g1 + 0.072169 * b1;
      double z1 = 0.019334 * r1 + 0.119193 * g1 + 0.950227 * b1;

      double x2 = 0.412453 * r2 + 0.357580 * g2 + 0.180423 * b2;
      double y2 = 0.212671 * r2 + 0.715160 * g2 + 0.072169 * b2;
      double z2 = 0.019334 * r2 + 0.119193 * g2 + 0.950227 * b2;

      double fx;
      double fy;
      double fz;

      if(x1 <= 0.008856){
        fx = 7.787 * x1/0.95047 + 16.0/116.0;
      }else{
        fx = cbrt(x1/0.95047);
      }

      if(y1 <= 0.008856){
        l1 = 903.3 * y1;
        fy = (7.787 * y1 + 16.0/116.0);
      }else{
        l1 = 116.0 * cbrt(y1) - 16.0;
        fy = cbrt(y1);
      }

      if(z1 <= 0.008856){
        fz = 7.787 * z1/1.08883 + 16.0/116.0;
      }else{
        fz = cbrt(z1/1.08883);
      }

      a1 = 500.0 * (fx-fy);
      b1 = 200.0 * (fy-fz);


      if(x2 <= 0.008856){
        fx = (7.787 * x2/0.95047 + 16.0/116.0);
      }else{
        fx = cbrt(x2/0.95047);
      }

      if(y2 <= 0.008856){
        l2 = 903.3 * y2;
        fy = (7.787 * y2 + 16.0/116.0);
      }else{
        l2 = 116.0 * cbrt(y2) - 16.0;
        fy = cbrt(y2);
      }

      if(z2 <= 0.008856){
        fz = (7.787 * z2/1.08883 + 16.0/116.0);
      }else{
        fz = cbrt(z2/1.08883);
      }

      a2 = 500.0 * (fx-fy);
      b2 = 200.0 * (fy-fz);


      double c1 = sqrt(a1*a1+b1*b1);
      double c2 = sqrt(a2*a2+b2*b2);
      double cdelta = c2 - c1;

      double lbar = (l1 + l2)/2.0;
      double cbar = (c1 + c2)/2.0;

      double lbaradj = (lbar - 50.0)*(lbar - 50.0);
      double cbaradj = sqrt(pow(cbar,7)/(pow(cbar,7)+6103515625.0));

      double a1prime = a1 + (a1/2.0) * (1.0-cbaradj);
      double a2prime = a2 + (a2/2.0) * (1.0-cbaradj);

      double c1prime = sqrt(a1prime*a1prime+b1*b1);
      double c2prime = sqrt(a2prime*a2prime+b2*b2);
      double cprime = (c1prime + c2prime)/2.0;
      double cprimeadj = sqrt(pow(cprime,7)/(pow(cprime,7)+6103515625.0));
      double cprimedelta = c2prime - c1prime;

      double h1;
      double h2;
      if(c1 == 0.0){
        h1 = 0.0;
      }else{
        h1 = fmod(atan2(b1,a1prime)*180.0/pi,360.0);
      }
      if(c2 == 0.0){
        h2 = 0.0;
      }else{
        h2 = fmod(atan2(b2,a2prime)*180.0/pi,360.0);
      }

      double h;
      if (fabs(h2 - h1) <= 180.0){
        h = h2 - h1;
      }else if(h2 <= h1){
        h = h2 - h1 + 360.0;
      }else{
        h = h2 - h1 - 360.0;
      }

      double hdelta = 2.0 * sqrt(c1prime * c2prime) * sin(h/2.0);
      double hprime = (h1 + h2)/2.0;
      if (fabs(h1 - h2) > 180.0){
        hprime += 180.0;
      }
      if(c1prime == 0.0 || c2prime == 0.0){
        hprime *= 2.0;
      }

      double t = 1.0 - 0.17*cos(hprime-30.0) +
                  0.24*cos(2.0*hprime) +
                  0.32*cos(3.0*hprime + 6.0) -
                  0.20*cos(4.0*hprime-63.0);

      double sl = 1.0 + 0.015 * lbaradj/sqrt(20+lbaradj);
      double sc = 1.0 + 0.045*cprime;
      double sh = 1.0 + 0.015*cprime*t;

      double rt = -2.0*cprimeadj*sin(60.0*pow(e,(hdelta-275.0)*(hdelta-275.0)/(-625.0)));

      double ldiff = (l1 - l2)/(sl);
      double adiff = cprimedelta/sc;
      double bdiff = hdelta/sh;
      double rdiff = rt*adiff*bdiff;
      double val = sqrt(ldiff*ldiff+adiff*adiff+bdiff*bdiff+rdiff)/100.0;

      return DBL2NUM(val);
    }'
  end
end
