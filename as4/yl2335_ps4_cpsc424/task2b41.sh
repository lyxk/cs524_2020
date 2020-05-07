#!/bin/bash
#SBATCH --partition=cpsc424

# ONLY USE THE FOLLOWING LINE FOR TIMING RUNS
#SBATCH --exclusive

# set total number of MPI processes
#SBATCH --ntasks=4

# set number of MPI processes per node
# (number of nodes is calculated by Slurm)
#SBATCH --ntasks-per-node=4

# set number of cpus per MPI process
#SBATCH --cpus-per-task=1

# set memory per cpu
#SBATCH --mem-per-cpu=6100mb

# set number of processes per socket
#SBATCH --ntasks-per-socket=2

#SBATCH --job-name=MPI_TASK2B41

#SBATCH --time=1:00:00

#SBATCH --output=%x-%j.out

module load OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
module list

pwd
# echo some environment variables
echo $SLURM_JOB_NODELIST
echo $SLURM_NTASKS_PER_NODE

# My MPI program is task2
make task2

# In this example, we've asked Slurm for 4 tasks, and we've asked mpirun for 4 procs, which will go onto 1 node.
echo ""
echo "p = 4"
time mpirun -n 4 --map-by socket --rank-by socket ./task2 -b
time mpirun -n 4 --map-by socket --rank-by socket ./task2 -b
time mpirun -n 4 --map-by socket --rank-by socket ./task2 -b
