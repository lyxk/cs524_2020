#!/bin/bash
#SBATCH --partition=cpsc424_gpu

# set number of cpus per MPI process
#SBATCH --cpus-per-task=5

# set memory per cpu
#SBATCH --mem-per-cpu=6100mb

# set gre-flags
#SBATCH --gres-flags=enforce-binding

# set number of gpus
#SBATCH --gres=gpu:1

#SBATCH --job-name=MATMUL_TASK1A

#SBATCH --time=1:00:00

#SBATCH --output=%x-%j.out

module load GCC CUDA

make task1a
echo ""

echo "n = 1024, m = 1024, p = 1024"
echo "-------------------------------------------"
./task1a 1024 1024 1024 2
./task1a 1024 1024 1024 4
./task1a 1024 1024 1024 8
./task1a 1024 1024 1024 16
./task1a 1024 1024 1024 32

echo "n = 8192, m = 8192, p = 8192"
echo "-------------------------------------------"
./task1a 8192 8192 8192 2
./task1a 8192 8192 8192 4
./task1a 8192 8192 8192 8
./task1a 8192 8192 8192 16
./task1a 8192 8192 8192 32

echo "n = 1024, m = 1024, p = 8192"
echo "-------------------------------------------"
./task1a 1024 1024 8192 2
./task1a 1024 1024 8192 4
./task1a 1024 1024 8192 8
./task1a 1024 1024 8192 16
./task1a 1024 1024 8192 32

echo "n = 8192, m = 8192, p = 1024"
echo "-------------------------------------------"
./task1a 8192 8192 1024 2
./task1a 8192 8192 1024 4
./task1a 8192 8192 1024 8
./task1a 8192 8192 1024 16
./task1a 8192 8192 1024 32

echo "n = 8192, m = 1024, p = 8192"
echo "-------------------------------------------"
./task1a 8192 1024 8192 2
./task1a 8192 1024 8192 4
./task1a 8192 1024 8192 8
./task1a 8192 1024 8192 16
./task1a 8192 1024 8192 32

