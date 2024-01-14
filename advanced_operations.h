// advanced_operations.h

#ifndef ADVANCED_OPERATIONS_H
#define ADVANCED_OPERATIONS_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// A sample structure
typedef struct {
    int id;
    char name[50];
} CustomData;

// Another structure
typedef struct {
    double x;
    double y;
} Point;

// Function declarations
void printCustomData(const CustomData *data);
int computeAdvancedOperation(int a, int b);
double computeDistance(const Point *p1, const Point *p2);
void initializePoint(Point *p, double x, double y);
bool comparePoints(const Point *p1, const Point *p2);
void swapPoints(Point *p1, Point *p2);
void logCustomData(const CustomData *data, const char* filename);
void transformPoint(Point *p, double (*transformFunc)(double));
double square(double x);
double cube(double x);
bool isPointOrigin(const Point *p);
void sortCustomDataArray(CustomData *array, int size, int 
(*compareFunc)(const CustomData*, const CustomData*));
int defaultCompare(const CustomData *data1, const CustomData *data2);
void applyToAllPoints(Point *array, int size, void (*applyFunc)(Point*));
void printPoint(const Point *p);
void shiftPoint(Point *p, double xShift, double yShift);
CustomData createCustomData(int id, const char *name);

// Macro definitions
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define ABS(x) ((x) < 0 ? -(x) : (x))
#define SQUARE(x) ((x) * (x))

#endif // ADVANCED_OPERATIONS_H

