#!/bin/bash
#SBATCH --partition=cpsc424

# ONLY USE THE FOLLOWING LINE FOR TIMING RUNS
#SBATCH --exclusive

#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=6100mb
#SBATCH --job-name=MPI_TASK1
#SBATCH --time=1:00:00
#SBATCH --output=%x-%j.out

module load OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
pwd
echo $SLURM_JOB_NODELIST
echo $SLURM_NTASKS_PER_NODE

make serial
time ./serial
time ./serial
time ./serial
