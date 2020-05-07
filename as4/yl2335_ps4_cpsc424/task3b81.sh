#!/bin/bash
#SBATCH --partition=cpsc424

# ONLY USE THE FOLLOWING LINE FOR TIMING RUNS
#SBATCH --exclusive

# set total number of MPI processes
#SBATCH --ntasks=8

# set number of nodes
#SBATCH --ntasks-per-node=8

# set number of cpus per MPI process
#SBATCH --cpus-per-task=1

# set memory per cpu
#SBATCH --mem-per-cpu=6100mb

# set number of processes per socket
#SBATCH --ntasks-per-socket=4

#SBATCH --job-name=MPI_TASK3B81

#SBATCH --time=1:00:00

#SBATCH --output=%x-%j.out

module load OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
module list

pwd
# echo some environment variables
echo $SLURM_JOB_NODELIST
echo $SLURM_NTASKS_PER_NODE

# My MPI program is task3
make task3

# In this example, we've asked Slurm for 8 tasks, and we've asked mpirun for 8 MPI procs, which will go onto 1 node.
echo ""
echo "p = 8"
time mpirun -n 8 --map-by socket --rank-by socket ./task3 -b
time mpirun -n 8 --map-by socket --rank-by socket ./task3 -b
time mpirun -n 8 --map-by socket --rank-by socket ./task3 -b
