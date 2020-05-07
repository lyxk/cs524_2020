#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <omp.h>

static uint64_t seed;
#pragma omp threadprivate(seed)

void dsrand(unsigned s)
{
    seed = s-1;
    if ( omp_in_parallel() ) {
        int thread_id = omp_get_thread_num();
        seed = (seed & 0xFFFFFFFFFFFFFFE0) | thread_id;
    }
    printf("Seed = %lu. RAND_MAX = %d.\n",seed,RAND_MAX);
}

double drand(void)
{
    seed = 6364136223846793005ULL*seed + 1;
    return((double)(seed>>33)/(double)RAND_MAX);
}
