#!/bin/bash
#SBATCH --partition=cpsc424

# ONLY USE THE FOLLOWING LINE FOR TIMING RUNS
#SBATCH --exclusive

# set total number of MPI processes
#SBATCH --ntasks=8

# set number of MPI processes per node
# (number of nodes is calculated by Slurm)
#SBATCH --ntasks-per-node=8

# set number of cpus per MPI process
#SBATCH --cpus-per-task=1

# set memory per cpu
#SBATCH --mem-per-cpu=6100mb

#SBATCH --job-name=MPI_TASK2A

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

# The following mpirun command will pick up required info on nodes and cpus from Slurm. 
# You can use mpirun's -n option to reduce the number of MPI processes started on the cpus. (At most 1 MPI proc per Slurm task.)
# You can use mpirun options to control the layout of MPI processes---e.g., to spread processes out onto multiple nodes
# In this example, we've asked Slurm for 8 tasks (8 each on 1 node), but we've asked mpirun for 1, 2, 4, 8 MPI procs, which will go onto 1 node.
# (If "-n 2" is omitted, you'll get 8 MPI procs (1 per Slurm task)

echo ""
echo "p = 1"
time mpirun -n 1 ./task2 -a
time mpirun -n 1 ./task2 -a
time mpirun -n 1 ./task2 -a

echo ""
echo "p = 2"
time mpirun -n 2 ./task2 -a
time mpirun -n 2 ./task2 -a
time mpirun -n 2 ./task2 -a

echo ""
echo "p = 4"
time mpirun -n 4 ./task2 -a
time mpirun -n 4 ./task2 -a
time mpirun -n 4 ./task2 -a

echo ""
echo "p = 8"
time mpirun -n 8 ./task2 -a
time mpirun -n 8 ./task2 -a
time mpirun -n 8 ./task2 -a
