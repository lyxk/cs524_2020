#!/bin/bash

#SBATCH --partition=cpsc424
#SBATCH --cpus-per-task=20
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=6100
#SBATCH --job-name=Mandelbrot3-2
#SBATCH --output=%x-%j.out

module load intel

echo "Task 3 - Part 2"

make mandomp-single-row-tasks

echo ""
echo ""
echo "Performance runs for thread-safe OpenMP with single thread creating row tasks"
echo ""


# default schedule

export OMP_NUM_THREADS=1
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
echo ""

export OMP_NUM_THREADS=2
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
echo ""

export OMP_NUM_THREADS=4
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
echo ""

export OMP_NUM_THREADS=10
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
echo ""

export OMP_NUM_THREADS=20
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
time ./mandomp-single-row-tasks
echo ""