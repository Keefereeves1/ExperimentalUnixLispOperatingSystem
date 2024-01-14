#include "interdimensional_data.h"

void initInterdimensionalPoint(InterdimensionalPoint* point, double x, 
double y, double z, double t, char* name) {
    point->x = x;
    point->y = y;
    point->z = z;
    point->t = t;
    point->dimensionName = name;
}

