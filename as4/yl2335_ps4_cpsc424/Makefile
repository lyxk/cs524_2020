# NOTE: This Makefile presumes that the following command has been executed:

#                module load  OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30 

TIMINGDIR = /home/cpsc424_ahs3/utils/timing
CC = mpicc
CFLAGS = -g -O3 -xHost -fno-alias -std=c99 -I$(TIMINGDIR)
EXECUTABLES = serial task2 task3 task4 task5

serial:	serial.o matmul.o $(TIMINGDIR)/timing.o
	$(CC) -o $@ $(CFLAGS) $^

task2: task2.o matmul.o $(TIMINGDIR)/timing.o
	$(CC) -o $@ $(CFLAGS) $^

task3: task3.o matmul.o $(TIMINGDIR)/timing.o
	$(CC) -o $@ $(CFLAGS) $^

task4: task4.o matmul.o $(TIMINGDIR)/timing.o
	$(CC) -o $@ $(CFLAGS) $^
	
task5: task5.o matmul.o $(TIMINGDIR)/timing.o
	$(CC) -o $@ $(CFLAGS) $^
	
.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(EXECUTABLES) *.o
