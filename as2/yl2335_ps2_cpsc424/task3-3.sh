#!/bin/bash

#SBATCH --partition=cpsc424
#SBATCH --cpus-per-task=20
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=6100
#SBATCH --job-name=Mandelbrot3-3
#SBATCH --output=%x-%j.out

module load intel

echo "Task 3 - Part 3"

make mandomp-row-tasks

echo ""
echo ""
echo "Performance runs for thread-safe OpenMP with multiple threads creating row tasks"
echo ""


export OMP_NUM_THREADS=1
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-row-tasks
time ./mandomp-row-tasks
time ./mandomp-row-tasks
echo ""

export OMP_NUM_THREADS=2
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-row-tasks
time ./mandomp-row-tasks
time ./mandomp-row-tasks
echo ""

export OMP_NUM_THREADS=4
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-row-tasks
time ./mandomp-row-tasks
time ./mandomp-row-tasks
echo ""

export OMP_NUM_THREADS=10
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-row-tasks
time ./mandomp-row-tasks
time ./mandomp-row-tasks

export OMP_NUM_THREADS=20
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-row-tasks
time ./mandomp-row-tasks
time ./mandomp-row-tasks