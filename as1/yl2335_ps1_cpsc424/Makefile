#-----------------------------------------------------------
# Macro definitions
CC = icc
CFLAGS1 = -g -O0 -fno-alias -std=c99
CFLAGS2 = -g -O3 -no-vec -no-simd -fno-alias -std=c99
CFLAGS3 = -g -O3 -xHost -fno-alias -std=c99
#-----------------------------------------------------------
# Rules
all: ex1 ex2

ex1: ex1.c timing.o
	${CC} ${CFLAGS1} -o ex1a ex1.c timing.o
	${CC} ${CFLAGS2} -o ex1b ex1.c timing.o
	${CC} ${CFLAGS3} -o ex1c ex1.c timing.o

ex2: ex2.c timing.o
	${CC} ${CFLAGS3} -o ex2 ex2.c dummy.c timing.o
	
clean:
	rm ex1a ex1b ex1c ex2
