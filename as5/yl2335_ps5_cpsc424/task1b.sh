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

#SBATCH --job-name=MATMUL_TASK1B

#SBATCH --time=1:00:00

#SBATCH --output=%x-%j.out

module load GCC CUDA

make task1b
echo ""

echo "n = 8192, m = 8192, p = 8192"
echo "-------------------------------------------"
./task1b 8192 8192 8192 2
./task1b 8192 8192 8192 4
./task1b 8192 8192 8192 8
./task1b 8192 8192 8192 16
./task1b 8192 8192 8192 32

