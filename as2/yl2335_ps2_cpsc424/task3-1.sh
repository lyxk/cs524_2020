#!/bin/bash

#SBATCH --partition=cpsc424
#SBATCH --cpus-per-task=20
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=6100
#SBATCH --job-name=Mandelbrot3-1
#SBATCH --output=%x-%j.out

module load intel

echo "Task 3 - Part 1"

make mandomp-tasks

echo ""
echo ""
echo "Performance runs for thread-safe OpenMP with cell tasks"
echo ""


export OMP_NUM_THREADS=1
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-tasks
time ./mandomp-tasks
time ./mandomp-tasks
echo ""

export OMP_NUM_THREADS=2
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-tasks
time ./mandomp-tasks
time ./mandomp-tasks
echo ""

export OMP_NUM_THREADS=4
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-tasks
time ./mandomp-tasks
time ./mandomp-tasks
echo ""

export OMP_NUM_THREADS=10
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-tasks
time ./mandomp-tasks
time ./mandomp-tasks
echo ""

export OMP_NUM_THREADS=20
echo "Number of threads = " $OMP_NUM_THREADS
echo "OMP_SCHEDULE = " $OMP_SCHEDULE
time ./mandomp-tasks
time ./mandomp-tasks
time ./mandomp-tasks
echo ""