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

#SBATCH --job-name=MATMUL_TASK3

#SBATCH --time=1:00:00

#SBATCH --output=%x-%j.out

module load GCC CUDA

make task3
echo ""

echo "n = 8192, m = 8192, p = 8192"
echo "-------------------------------------------"
./task3 8192 8192 8192 32 1
./task3 8192 8192 8192 32 2
./task3 8192 8192 8192 32 3
./task3 8192 8192 8192 32 4
./task3 8192 8192 8192 32 5
./task3 8192 8192 8192 32 6
./task3 8192 8192 8192 32 7
./task3 8192 8192 8192 32 8
./task3 8192 8192 8192 32 9
./task3 8192 8192 8192 32 10
./task3 8192 8192 8192 32 11
./task3 8192 8192 8192 32 12
./task3 8192 8192 8192 32 13
./task3 8192 8192 8192 32 14
./task3 8192 8192 8192 32 15
./task3 8192 8192 8192 32 16
./task3 8192 8192 8192 32 17

