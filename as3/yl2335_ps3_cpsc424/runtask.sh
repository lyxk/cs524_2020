#!/bin/bash
#SBATCH --partition=cpsc424
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --tasks-per-node=2
#SBATCH --mem-per-cpu=6100
#SBATCH --time=20:00
#SBATCH --job-name=MPI_all
#SBATCH --output=%x-%j.out

# Load necessary module files
module load OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
module list

# Print initial working directory
echo " "
echo " "
echo "Working Directory:"
pwd

echo " "
echo " "
echo "Making task1"
make clean
make task1

# Print the node list
echo " "
echo " "
echo "Node List:"
echo $SLURM_NODELIST
echo "ntasks-per-node = " $SLURM_NTASKS_PER_NODE

# Run the program 3 times
echo " "
echo " "
echo "Run 1"
time mpiexec -n 4 task1
echo " "
echo " "
echo "Run 2"
time mpiexec -n 4 task1
echo " "
echo " "
echo "Run 3"
time mpiexec -n 4 task1

echo " "
echo " "
echo "Making task2"
make task2

# Run the program 3 times
echo " "
echo " "
echo "Run 1"
time mpiexec -n 4 task2
echo " "
echo " "
echo "Run 2"
time mpiexec -n 4 task2
echo " "
echo " "
echo "Run 3"
time mpiexec -n 4 task2

echo " "
echo " "
echo "Making task3"
make task3

# Run the program 3 times
echo " "
echo " "
echo "Run 1"
time mpiexec -n 4 task3
echo " "
echo " "
echo "Run 2"
time mpiexec -n 4 task3
echo " "
echo " "
echo "Run 3"
time mpiexec -n 4 task3
