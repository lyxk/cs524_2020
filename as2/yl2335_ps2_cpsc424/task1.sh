#!/bin/bash

#SBATCH --partition=cpsc424
#SBATCH --cpus-per-task=20
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=6100
#SBATCH --job-name=Mandelbrot1-1
#SBATCH --output=%x-%j.out

module load intel

echo "Task 1"

echo ""
echo ""
echo "Serial version"
echo ""

make mandseq

time ./mandseq
time ./mandseq
time ./mandseq