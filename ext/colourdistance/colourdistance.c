#include <ruby.h>
#include <stdio.h>
#include <math.h>
#include "colourdistance.h"


 
void Init_colourdistance() {
  VALUE rb_mColourdistance = rb_define_module("Colourdistance");
  rb_define_singleton_method(rb_mColourdistance, "cie76", ciede2000, 2);
  rb_define_singleton_method(rb_mColourdistance, "cie94", ciede2000, 2);
  rb_define_singleton_method(rb_mColourdistance, "ciede2000", ciede2000, 2);
}

static VALUE cie76(const VALUE self, VALUE color1, VALUE color2) {
  double pi = 3.1415927;
  double e = 2.7182818;
  double conversion = pi/180.0;
  static double lab1[3];
  static double lab2[3];

  rgb_to_lab(color1, lab1);

  double l1 = lab1[0];
  double a1 = lab1[1];
  double b1 = lab1[2];

  rgb_to_lab(color2, lab2);
  double l2 = lab2[0];
  double a2 = lab2[1];
  double b2 = lab2[2];

  double ldiff = l2 - l1;
  double adiff = a2 - a1;
  double bdiff = b2 - b1;

  double val = sqrt(ldiff*ldiff+adiff*adiff+bdiff*bdiff)/100.0;

  return DBL2NUM(val);
}

static VALUE cie94(const VALUE self, VALUE color1, VALUE color2) {
  double pi = 3.1415927;
  double e = 2.7182818;
  double conversion = pi/180.0;
  double kl = 2.0;
  double k1 = 0.048;
  double k2 = 0.014;

  static double lab1[3];
  static double lab2[3];

  rgb_to_lab(color1, lab1);

  double l1 = lab1[0];
  double a1 = lab1[1];
  double b1 = lab1[2];

  rgb_to_lab(color2, lab2);
  double l2 = lab2[0];
  double a2 = lab2[1];
  double b2 = lab2[2];

  double ldiff = l1 - l2;
  double adiff = a1 - a2;
  double bdiff = b1 - b2;

  double c1 = sqrt(a1*a1+b1*b1);
  double c2 = sqrt(a2*a2+b2*b2);
  double deltac = c1 - c2;

  double deltah = sqrt(adiff*adiff+bdiff*bdiff-deltac*deltac);

  double sc = 1 + k1*c1;
  double sh = 1 + k2*c1;

  double e1 = ldiff/kl;
  double e2 = deltac / (k1*sc);
  double e3 = deltah / (k2*sh);
  double val = sqrt(e1*e1+e2*e2+e3*e3)/100.0;

  return DBL2NUM(val);
}

static VALUE ciede2000(const VALUE self, VALUE color1, VALUE color2) {
  double pi = 3.1415927;
  double e = 2.7182818;
  double conversion = pi/180.0;
  static double lab1[3];
  static double lab2[3];

  rgb_to_lab(color1, lab1);

  double l1 = lab1[0];
  double a1 = lab1[1];
  double b1 = lab1[2];

  rgb_to_lab(color2, lab2);
  double l2 = lab2[0];
  double a2 = lab2[1];
  double b2 = lab2[2];

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

  double hdelta = 2.0 * sqrt(c1prime * c2prime) * sin(conversion*h/2.0);
  double hprime = (h1 + h2)/2.0;
  if (fabs(h1 - h2) > 180.0){
    hprime += 180.0;
  }
  if(c1prime == 0.0 || c2prime == 0.0){
    hprime *= 2.0;
  }

  double t = 1.0 - 0.17*cos(conversion*(hprime-30.0)) +
              0.24*cos(conversion*(2.0*hprime)) +
              0.32*cos(conversion*(3.0*hprime + 6.0)) -
              0.20*cos(conversion*(4.0*hprime-63.0));

  double sl = 1.0 + 0.015 * lbaradj/sqrt(20+lbaradj);
  double sc = 1.0 + 0.045*cprime;
  double sh = 1.0 + 0.015*cprime*t;

  if (hprime < 0.0){
    hprime += 360.0;
  }

  double rt = -2.0*cprimeadj*sin(conversion*60.0*pow(e,(hprime-275.0)*(hprime-275.0)/(-625.0)));

  double ldiff = (l1 - l2)/sl;
  double adiff = cprimedelta/sc;
  double bdiff = hdelta/sh;
  double rdiff = rt*adiff*bdiff;
  double val = sqrt(ldiff*ldiff+adiff*adiff+bdiff*bdiff+rdiff)/100.0;

  return DBL2NUM(val);
}


void rgb_to_lab(VALUE color, double *lab) {

  double r = NUM2DBL(rb_hash_aref(color, rb_str_intern(rb_str_new2("r"))))/255.0;
  double g = NUM2DBL(rb_hash_aref(color, rb_str_intern(rb_str_new2("g"))))/255.0;
  double b = NUM2DBL(rb_hash_aref(color, rb_str_intern(rb_str_new2("b"))))/255.0;

  r = ((r <= 0.04045) ? r / 12.92 : pow(((r + 0.055) / 1.055),2.4));
  g = ((g <= 0.04045) ? g / 12.92 : pow(((g + 0.055) / 1.055),2.4));
  b = ((b <= 0.04045) ? b / 12.92 : pow(((b + 0.055) / 1.055),2.4));

  double x = 0.412453 * r + 0.357580 * g + 0.180423 * b;
  double y = 0.212671 * r + 0.715160 * g + 0.072169 * b;
  double z = 0.019334 * r + 0.119193 * g + 0.950227 * b;

  double fx;
  double fy;
  double fz;

  if(x <= 0.008856){
    fx = 7.787 * x/0.95047 + 16.0/116.0;
  }else{
    fx = cbrt(x/0.95047);
  }

  if(y <= 0.008856){
    lab[0] = 903.3 * y;
    fy = (7.787 * y + 16.0/116.0);
  }else{
    lab[0] = 116.0 * cbrt(y) - 16.0;
    fy = cbrt(y);
  }

  if(z <= 0.008856){
    fz = 7.787 * z/1.08883 + 16.0/116.0;
  }else{
    fz = cbrt(z/1.08883);
  }

  lab[1] = 500.0 * (fx-fy);
  lab[2] = 200.0 * (fy-fz);
}