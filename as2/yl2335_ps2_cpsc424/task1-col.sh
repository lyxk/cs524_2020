#!/bin/bash

#SBATCH --partition=cpsc424
#SBATCH --cpus-per-task=20
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=6100
#SBATCH --job-name=Mandelbrot1-2
#SBATCH --output=%x-%j.out

module load intel

echo "Task 1 column order"

echo ""
echo ""
echo "Serial version with column order"
echo ""

make mandseq-col

time ./mandseq-col
time ./mandseq-col
time ./mandseq-col
