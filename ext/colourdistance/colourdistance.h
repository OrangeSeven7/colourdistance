#ifndef __colourdistance_h__
#define __colourdistance_h__

static VALUE ciee76(VALUE,VALUE,VALUE);
static VALUE cie94(VALUE,VALUE,VALUE);
static VALUE ciede2000(VALUE,VALUE,VALUE);
void rgb_to_lab(VALUE, double *);

#endif
