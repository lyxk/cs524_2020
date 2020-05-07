#define FP float

#include <stdio.h>
#include <cuda.h>
#include <stdlib.h>
#include <math.h>

__global__ void gpu_matrixmult(FP *a, FP *b, FP *c, int n, int p, int m, int TW, int NTB) {

  extern __shared__ FP bigarray[];
  FP *atile = &bigarray[0], *btile = &bigarray[TW * TW];
  int tx = threadIdx.x, ty = threadIdx.y, bx = blockIdx.x, by = blockIdx.y;

  int baseRow = by * blockDim.y, baseCol = bx * NTB * TW;
  // if (baseRow >= n || baseCol >= m) return;

  int row = ty + baseRow, col = tx + baseCol;

  int indexa, indexb;

  // Loop over tiles
  for (int t = 0; t < (p - 1) / TW + 1; t++) {
    // Reset col
    col = tx + baseCol;

    indexa = row * p + t * TW + tx;
    atile[ty * TW + tx] = (row >= n || t * TW + tx >= p ? 0 : a[indexa]); // Copy to shared memory

    // Loop over muti-tiles
    for (int t1 = 0; t1 < NTB; t1++, col += TW) {
      if (col >= m) break;
      
      indexb = (t * TW + ty) * m + col;
      btile[ty * TW + tx] = (t * TW + ty >= p ? 0 : b[indexb]); // Copy to shared memory
      __syncthreads();

      // Compute tile ctile = atile x btile (each thread computes one element)
      if (row < n && col < m) 
        for (int k = 0; k < TW; k++)
          c[row * m + col] += atile[ty * TW + k] * btile[k * TW + tx];
      __syncthreads();
    }

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
  int TW = 1;
  int NTB = 1;

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

  if (argc != 6) {
    printf("Usage: matmul <matrix dim n> <matrix dim m> <matrix dim p> <block dim> <tiles>\n");
    exit (-1);
  }

  n = atoi(argv[1]);
  m = atoi(argv[2]);
  p = atoi(argv[3]);
  NTB = atoi(argv[5]);

  TW = Block_Dim_x = Block_Dim_y = atoi(argv[4]); // Square block
  if (Block_Dim_x * Block_Dim_y > 1024) {
    printf("Error, too many threads in block\n");
    exit (-1);
  }

  // Grid_Dim_x = (m - 1) / Block_Dim_x + 1;
  Grid_Dim_x = (m - 1) / (NTB * TW) + 1;
  Grid_Dim_y = (n - 1) / Block_Dim_y + 1; 
  if (Grid_Dim_x * NTB * TW < m || Grid_Dim_y * Block_Dim_y < n) {
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

  memset(c, 0., sizeC);

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

  size_t Ns = 2 * TW * TW * sizeof(FP);
  gpu_matrixmult<<<Grid, Block, Ns>>>(dev_a, dev_b, dev_c, n, p, m, TW, NTB);

  cudaEventRecord(stop, 0); // instrument code to measure end time
  cudaEventSynchronize(stop);
  cudaEventElapsedTime(&elapsed_time_ms, start, stop);

  cudaMemcpy(c, dev_c, sizeC, cudaMemcpyDeviceToHost);

  printf("Time to calculate results on GPU: %f ms.\n", elapsed_time_ms); // exec. time

  // ------------- COMPUTATION DONE ON HOST CPU ----------------------------
  // DEBUGGING USE ONLY (AND FOR LIMITED NUMBERS OF TIMING RUNS)

  cudaEventRecord(start, 0); // use same timing
  // cudaEventSynchronize(start); // not needed


  cpu_matrixmult(a, b, c, n, p, m); // do calculation on host (NOTE: This computes the diff with GPU result.)

  cudaEventRecord(stop, 0); // instrument code to measue end time
  cudaEventSynchronize(stop);
  cudaEventElapsedTime(&elapsed_time_ms, start, stop);

  printf("Time to calculate results on CPU: %f ms.\n", elapsed_time_ms); // exec. time

// ------------------- check device creates correct results -----------------

  double error, suma, sumb, sumc, ai, bi, ci;
  suma = 0.; sumb = 0; sumc = 0;
  for (i = 0; i < n * p; i++) {
    ai = (double) a[i];
    suma += ai * ai;
  }
  for (i = 0; i < p * m; i++) {
    bi = (double) b[i];
    sumb += bi * bi;
  }
  for (i = 0; i < n * m; i++) {
    ci = (double) c[i];
    sumc += ci * ci;
  }
  suma = sqrt(suma);
  sumb = sqrt(sumb);
  sumc = sqrt(sumc);
  error =  sumc / (sqrt(n * m) * suma * sumb);
  printf("Scaled error between GPU and CPU: %e\n\n", error);

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
