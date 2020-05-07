#!/bin/bash

#SBATCH --partition=cpsc424
#SBATCH --cpus-per-task=20
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=6100
#SBATCH --job-name=Mandelbrot2-1
#SBATCH --output=%x-%j.out

module load intel

echo "Task 2 - Part 1"
echo ""

echo "Sequential Program"
echo ""

make mandseq

export OMP_NUM_THREADS=1
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandseq
time ./mandseq
time ./mandseq
echo ""

export OMP_NUM_THREADS=2
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandseq
time ./mandseq
time ./mandseq
echo ""

export OMP_NUM_THREADS=4
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandseq
time ./mandseq
time ./mandseq
echo ""

export OMP_NUM_THREADS=10
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandseq
time ./mandseq
time ./mandseq
echo ""

export OMP_NUM_THREADS=20
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandseq
time ./mandseq
time ./mandseq
echo ""


echo "Parallel For Loop (default schedule)"
echo ""

# default schedule

make mandomp-ts

export OMP_NUM_THREADS=1
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-ts
time ./mandomp-ts
time ./mandomp-ts
echo ""

export OMP_NUM_THREADS=2
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-ts
time ./mandomp-ts
time ./mandomp-ts
echo ""

export OMP_NUM_THREADS=4
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-ts
time ./mandomp-ts
time ./mandomp-ts
echo ""

export OMP_NUM_THREADS=10
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-ts
time ./mandomp-ts
time ./mandomp-ts
echo ""

export OMP_NUM_THREADS=20
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-ts
time ./mandomp-ts
time ./mandomp-ts
echo ""
