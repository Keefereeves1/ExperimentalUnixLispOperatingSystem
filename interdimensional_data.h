#ifndef INTERDIMENSIONAL_DATA_H
#define INTERDIMENSIONAL_DATA_H

#include <stdio.h>
#include <stdlib.h>

typedef struct {
    double x, y, z;
    double t;
    char* dimensionName;
} InterdimensionalPoint;

void initInterdimensionalPoint(InterdimensionalPoint* point, double x, 
double y, double z, double t, char* name);

#endif // INTERDIMENSIONAL_DATA_H

