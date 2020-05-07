#include "dummy.h"
#include "timing.h"
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double* initDouble(int N) {
    double* dbArr = (double *) malloc(N * sizeof(double));
    srand((unsigned) time(NULL));
    double drand_max = 100.0 / (double) RAND_MAX;
    for (int i = 0; i < N; i++) {
        dbArr[i] = rand() * drand_max;
    }
    return dbArr;
}

int main() {
    printf("N\tTime\tMflops\n");
    for (int k = 3; k < 26; k++) {
        int N = floor(pow(2.1, k));
        double *a = (double *) malloc(N * sizeof(double)), *b = initDouble(N), *c = initDouble(N), *d = initDouble(N);
        int repeat = 1;
        double runtime = 0.0, wcs = 0.0, wce = 0.0, ct = 0.0;
        while (runtime < 1.0) {
            timing(&wcs, &ct);
            for (int r = 0; r < repeat; r++) {
                for (int i = 0; i < N; i++) {
                    a[i] = b[i] + c[i] * d[i];
                }
                if (a[N >> 1] < 0) dummy();   
            }
            timing(&wce, &ct);
            runtime = wce - wcs;
            repeat *= 2;
        }
        repeat /= 2;
        double mflops = (double) 2 *  repeat * N  / (runtime * 1e6);
        printf("%d\t%lf\t%lf\n", N, runtime, mflops);
        free(a); a = NULL;
        free(b); b = NULL;
        free(c); c = NULL;
        free(d); d = NULL;
    }
   return 0;
}
