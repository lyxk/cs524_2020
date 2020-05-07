#
# This Makefile assumes that the following module files are loaded:
#
#    OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
#
# Set the compiler command
CC = mpicc

# Set the compiler options
CFLAGS = -g -O3 -xHost -fno-alias -std=c99

all: task1 task2 task3

task1: task1.o timing.o rwork.o
	$(CC) -o $@ $(CFLAGS) $^

task2: task2.o timing.o rwork.o
	$(CC) -o $@ $(CFLAGS) $^

task3: task3.o timing.o rwork.o
	$(CC) -o $@ $(CFLAGS) $^
	
.c.o:
	$(CC) $(CFLAGS) -c $<

# Be careful not ot remove rwork.o and timing.o
clean:
	rm -f task1 task1.o 
	rm -f task2 task2.o
	rm -f task3 task3.o
