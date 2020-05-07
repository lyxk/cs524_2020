#!/bin/bash

#SBATCH --partition=cpsc424
#SBATCH --cpus-per-task=20
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=6100
#SBATCH --job-name=Mandelbrot4
#SBATCH --output=%x-%j.out

module load intel

echo "Task 4"

make mandomp-distinct-ts

echo ""
echo ""
echo "Performance runs for thread-safe OpenMP with distinct random numbers and loops"
echo ""


# default schedule

echo "default schedule"

export OMP_NUM_THREADS=20
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
echo ""

# schedule(static, 1)

echo "schedule(static, 1)"
echo ""

export OMP_NUM_THREADS=20
export OMP_SCHEDULE="static,1"
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
echo ""


# schedule(static, 10)

echo "schedule(static, 10)"
echo ""

export OMP_NUM_THREADS=20
export OMP_SCHEDULE="static,10"
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
echo ""


# schedule(dynamic)

echo "schedule(dynamic)"
echo ""

export OMP_NUM_THREADS=20
export OMP_SCHEDULE="dynamic"
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
echo ""

# schedule(guided)

echo "schedule(guided)"
echo ""

export OMP_NUM_THREADS=20
export OMP_SCHEDULE="guided"
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
time ./mandomp-distinct-ts
echo ""