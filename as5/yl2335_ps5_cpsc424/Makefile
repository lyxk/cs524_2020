# This Makefile assumes the following module files are loaded:
#
# GCC
# CUDA
#
# This Makefile will only work if executed on a GPU node.
#

NVCC = nvcc

NVCCFLAGS = -O3

LFLAGS = -lm

# Compiler-specific flags (by default, we always use sm_37)
GENCODE_SM37 = -gencode=arch=compute_37,code=\"sm_37,compute_37\"
GENCODE = $(GENCODE_SM37)

.SUFFIXES : .cu .ptx

BINARIES = matmul task1a task1b task1c task2a task2b task3 task4

matmul: matmul.o
	$(NVCC) $(GENCODE) $(LFLAGS) -o $@ $<

task1a: task1a.o
	$(NVCC) $(GENCODE) $(LFLAGS) -o $@ $<
	
task1b: task1b.o
	$(NVCC) $(GENCODE) $(LFLAGS) -o $@ $<
	
task1c: task1c.o
	$(NVCC) $(GENCODE) $(LFLAGS) -o $@ $<
	
task2a: task2a.o
	$(NVCC) $(GENCODE) $(LFLAGS) -o $@ $<
	
task2b: task2b.o
	$(NVCC) $(GENCODE) $(LFLAGS) -o $@ $<
	
task3: task3.o
	$(NVCC) $(GENCODE) $(LFLAGS) -o $@ $<

task4: task4.o
	$(NVCC) $(GENCODE) $(LFLAGS) -o $@ $<
	
.cu.o:
	$(NVCC) $(GENCODE) $(NVCCFLAGS) -o $@ -c $<

clean:	
	rm -f *.o $(BINARIES)
