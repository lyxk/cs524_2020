#include <stdlib.h>
#include <omp.h>
#include "timing.h"

extern void dsrand(unsigned s);
extern double drand(void);

int main(int argc, char* argv[]) {
    // Initialization
    int N1 = 0, N0 = 0;
    double wcs = 0.0, wce = 0.0, cputime = 0.0;

    // Start time
    timing(&wcs, &cputime);

    // Iterate through each grid
    #pragma omp parallel default(none) shared(N0, N1)
    {
        // Set the seed
        dsrand(12345);

        #pragma omp single
        for (int y = 0; y < 1250; ++y) {
            #pragma omp task
            for (int x = -2000; x < 500; ++x) {
                {
                    double c_real = ( x + drand() ) / 1000;
                    double c_img = ( y + drand() ) / 1000;

                    int it = 0;

                    double z_real = c_real;
                    double z_img = c_img;

                    while (z_real * z_real + z_img * z_img <= 4.0 && it < 20000) {
                        double temp_real = z_real * z_real - z_img * z_img + c_real;
                        double temp_img = 2 * z_real * z_img + c_img;
                        z_real = temp_real;
                        z_img = temp_img;
                        it += 1;
                    }

                    if (it < 20000) {
                        #pragma omp critical
                        {
                            N0 += 1;
                        }
                    } else {
                        #pragma omp critical
                        {
                            N1 += 1;
                        }
                    }
                }
            }
        }
    }
    

    double area = 6.25 * N1 / (N0 + N1);

    // End time
    timing(&wce, &cputime);

    printf("Estimated area of the Manderbrolt Set: %lf\n", area);
    printf("Computing time: %lf seconds", wce - wcs);

    return 0;
}
