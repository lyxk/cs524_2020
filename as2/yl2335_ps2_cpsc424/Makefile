# This makes both a sequential and parallel program to display the Mandelbrot Set
# Use module load intel

CC = icc

CFLAGS_OMP = -g -O3 -xHost -fno-alias -std=c99 -qopenmp
CFLAGS_SERIAL = -g -O3 -xHost -fno-alias -std=c99

EXECUTABLES = mandseq mandseq-col mandomp mandomp-ts mandomp-distinct-ts mandomp-collapse mandomp-tasks mandomp-single-row-tasks mandomp-row-tasks

TIMING = /home/cpsc424_ahs3/utils/timing/timing.o 

all: $(EXECUTABLES)

mandseq: mandseq.o drand.o $(TIMING)  
	$(CC) $(CFLAGS_SERIAL) -o $@ $^ -lm

mandseq-col: mandseq-col.o drand.o $(TIMING)
	$(CC) $(CFLGAS_SERIAL) -o $@ $^ -lm

mandomp: mandomp.o drand.o $(TIMING)
	$(CC) $(CFLAGS_OMP) -o $@ $^ -lm

mandomp-ts: mandomp.o drand-ts.o $(TIMING)
	$(CC) $(CFLAGS_OMP) -o $@ $^ -lm

mandomp-distinct-ts: mandomp.o drand-distinct-ts.o $(TIMING)
	$(CC) $(CFLAGS_OMP) -o $@ $^ -lm

mandomp-collapse: mandomp-collapse.o drand-ts.o $(TIMING)
	$(CC) $(CFLAGS_OMP) -o $@ $^ -lm

mandomp-tasks: mandomp-tasks.o drand-ts.o $(TIMING)
	$(CC) $(CFLAGS_OMP) -o $@ $^ -lm

mandomp-single-row-tasks: mandomp-single-row-tasks.o drand-ts.o $(TIMING)
	$(CC) $(CFLAGS_OMP) -o $@ $^ -lm

mandomp-row-tasks: mandomp-row-tasks.o drand-ts.o $(TIMING)
	$(CC) $(CFLAGS_OMP) -o $@ $^ -lm

mandseq.o: mandseq.c
	$(CC) $(CFLAGS_SERIAL) -c -o $@ $^

mandseq-col.o: mandseq-col.c
	$(CC) $(CFLGAS_SERIAL) -c -o $@ $^

.c.o:
	$(CC) $(CFLAGS_OMP) -c $<

clean:
	rm -f $(EXECUTABLES) *.o
