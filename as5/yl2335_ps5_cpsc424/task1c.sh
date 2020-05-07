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

#SBATCH --job-name=MATMUL_TASK1C

#SBATCH --time=1:00:00

#SBATCH --output=%x-%j.out

module load GCC CUDA

make task1c
echo ""

echo "n = 23080, m = 23080, p = 23080"
echo "-------------------------------------------"
./task1c 23080 23080 23080 32

