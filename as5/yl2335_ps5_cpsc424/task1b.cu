#define FP double

#include <stdio.h>
#include <cuda.h>
#include <stdlib.h>
#include <math.h>

__global__ void gpu_matrixmult(FP *a,FP *b, FP *c, int n, int p, int m) {

  int col = threadIdx.x + blockDim.x * blockIdx.x;
  int row = threadIdx.y + blockDim.y * blockIdx.y;

  int indexb = col;
  int index = row * m + col;
  
  if(col < m && row < n) {
    c[index] = 0.;
    for (int indexa = row * p; indexa < (row * p + p); indexa++, indexb += m) 
      c[index] += a[indexa] * b[indexb];
  }

}


void cpu_matrixmult(FP *a,FP *b, FP *c, int n, int p, int m) {

  int index;
  for (int k = 0; k < p; k++)
    for (int row = 0; row < n; row++) {
      index = row * m;
      for (int col = 0; col < m; col++, index++) {
        c[index] -= a[row * p + k] * b[k * m + col];
      }
    }
}


int main(int argc, char *argv[]) {

  int i, j; // loop counters

  int gpucount = 0; // Count of available GPUs
  int gpunum = 0; // Device number to use
  int Grid_Dim_x = 1, Grid_Dim_y = 1; //Grid dimension, x and y, square
  int Block_Dim_x = 1, Block_Dim_y = 1; //Block dimension, x and y, square

  int n, m, p; // matrix dimensions
  FP *a,*b,*c;
  FP *dev_a, *dev_b, *dev_c;
  int sizeA, sizeB, sizeC; // number of bytes in arrays

  cudaEvent_t start, stop; // using cuda events to measure time
  float elapsed_time_ms; // which is applicable for asynchronous code also
  cudaError_t errorcode;

  // --------------------SET PARAMETERS AND DATA -----------------------

  errorcode = cudaGetDeviceCount(&gpucount);
  if (errorcode == cudaErrorNoDevice) {
    printf("No GPUs are visible\n");
    exit(-1);
  }
  else {
     printf("Device count = %d\n",gpucount);
  }

  if (argc != 5) {
    printf("Usage: matmul <matrix dim n> <matrix dim m> <matrix dim p> <block dim>\n");
    exit (-1);
  }

  n = atoi(argv[1]);
  m = atoi(argv[2]);
  p = atoi(argv[3]);

  Block_Dim_x = Block_Dim_y = atoi(argv[4]); // Square block
  if (Block_Dim_x * Block_Dim_y > 1024) {
    printf("Error, too many threads in block\n");
    exit (-1);
  }

  Grid_Dim_x = (m - 1) / Block_Dim_x + 1;
  Grid_Dim_y = (n - 1) / Block_Dim_y + 1; 
  if (Grid_Dim_x * Block_Dim_x < m || Grid_Dim_y * Block_Dim_y < n) {
    printf("Error, number of threads in x/y dimensions less than number of array elements\n");
    exit (-1);
  }

  cudaSetDevice(gpunum);
  printf("Using device %d\n",gpunum);
  
  printf("Matrix Dimensions = %d, %d, %d\n", n, p, m);
  printf("Block_Dim = (%d, %d), Grid_Dim = (%d, %d), \n", Block_Dim_x, Block_Dim_y, Grid_Dim_x, Grid_Dim_y);

  dim3 Grid(Grid_Dim_x, Grid_Dim_y); //Grid structure
  dim3 Block(Block_Dim_x, Block_Dim_y); //Block structure

  sizeA = n * p * sizeof(FP);
  sizeB = p * m * sizeof(FP);
  sizeC = n * m * sizeof(FP);

  a = (FP*) malloc(sizeA); // dynamically allocated memory for arrays on host
  b = (FP*) malloc(sizeB);
  c = (FP*) malloc(sizeC); // results from GPU

  srand(12345);
  for(i = 0; i < n; i++)
    for(j = 0; j < p; j++) {
      a[i * p + j] = (FP) rand() / (FP) RAND_MAX;
      //      a[i * p + j] = (FP) i+j; // may be helpful for debugging
    }

  for(i = 0; i < p; i++)
    for(j = 0; j < m; j++) {
      b[i * m + j] = (FP) rand() / (FP) RAND_MAX;
      //      b[i * m + j] = (FP) i+j; // may be helpful for debugging
    }

  // ------------- COMPUTATION DONE ON GPU ----------------------------

  cudaMalloc((void**)&dev_a, sizeA); // allocate memory on device
  cudaMalloc((void**)&dev_b, sizeB);
  cudaMalloc((void**)&dev_c, sizeC);

  cudaMemcpy(dev_a, a , sizeA ,cudaMemcpyHostToDevice);
  cudaMemcpy(dev_b, b , sizeB ,cudaMemcpyHostToDevice);

  cudaEventCreate(&start); // instrument code to measure start time
  cudaEventCreate(&stop);
  
  cudaEventRecord(start, 0);
  // cudaEventSynchronize(start); // not needed

  gpu_matrixmult<<<Grid,Block>>>(dev_a, dev_b, dev_c, n, p, m);

  cudaEventRecord(stop, 0); // instrument code to measure end time
  cudaEventSynchronize(stop);
  cudaEventElapsedTime(&elapsed_time_ms, start, stop);

  cudaMemcpy(c, dev_c, sizeC, cudaMemcpyDeviceToHost);

  printf("Time to calculate results on GPU: %f ms.\n\n", elapsed_time_ms); // exec. time

// -------------- clean up ---------------------------------------

  free(a);
  free(b);
  free(c);
  cudaFree(dev_a);
  cudaFree(dev_b);
  cudaFree(dev_c);

  cudaEventDestroy(start);
  cudaEventDestroy(stop);

  return 0;
}
