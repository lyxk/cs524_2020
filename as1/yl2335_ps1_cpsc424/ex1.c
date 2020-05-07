#include <stdio.h>
#include <math.h>
#include "timing.h"

int main() {
    int N = 1e9;
    double area = 0, xi = 1 / ((double) 2 * N), dx = 1 / (double) N;
    double wcTimeStart = 0, cpuTimeStart = 0, wcTimeEnd = 0, cpuTimeEnd = 0;
    timing(&wcTimeStart, &cpuTimeStart);
    for (int i = 0; i < N; i++) {
        area += dx / (1 + xi * xi);
        xi += dx;
    }
    timing(&wcTimeEnd, &cpuTimeEnd);
    double time = wcTimeEnd - wcTimeStart;
    double mflops = (double) 5 * N / (time * 1e6);
    printf("Approximation = %lf \n", 4 * area);
    printf("Sin(4 * area) = %lf \n", sin(4 * area));
    printf("Millions of flops: %lf \n", (double) 5 * N / 1e6);
    printf("Time consumed: %lf \n", time);
    printf("Millions of flops per second: %lf \n", mflops);
    return 0;
}
