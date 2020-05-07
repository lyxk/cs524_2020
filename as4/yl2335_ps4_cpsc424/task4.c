#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stddef.h>
#include <unistd.h>
#include <math.h>
#include <mpi.h>
#include <stdbool.h>

double matmul(int, double*, double*, double*);
double matmulBlock(int, int, int, int, int, double*, double*, double*);
int calcRoot(double n, double p, double i) {
  return (int) sqrt(i*n*n/p + i*n/p + 0.25) - 0.5;
}

int main(int argc, char **argv) {
  int N, i, run, rank, numProcs, blockSize, *blocks, type = 99, *countsAB, *displsAB, *countsC, *displsC;   
  double *A, *B, *C, *blockA, *blockB, *blockC, *recvB, *sendB, *Ctrue, *cpTimes, *toTimes;
  long sizeAB, sizeC, blockSizeA, blockSizeB, blockSizeC;

  int runStart, runEnd;
  if (argc != 2) {
    printf("Usage ./task3 [-a|-b]\n");
    exit(1);
  } else if (strncmp(argv[1], "-a", 2) == 0) {
    runStart = 0;
    runEnd = 4;
  } else if (strncmp(argv[1], "-b", 2) == 0) {
    runStart = 3;
    runEnd = 4;
  } else {
    printf("Usage ./task3 [-a|-b]\n");
    exit(1);
  }

  // This array contains the sizes of the test cases
  int sizes[4]={1000,2000,4000,8000};

  // This array contains the file names for the true answers
  char files[4][55]={"/home/cpsc424_ahs3/assignments/assignment4/C-1000.dat",\
                     "/home/cpsc424_ahs3/assignments/assignment4/C-2000.dat",\
                     "/home/cpsc424_ahs3/assignments/assignment4/C-4000.dat",\
                     "/home/cpsc424_ahs3/assignments/assignment4/C-8000.dat"};

  double time, cpTime, toTime, Fnorm;

  FILE *fptr;

  MPI_Status status;
  MPI_Request reqs[2];
  MPI_Status stats[2];

  MPI_Init(&argc, &argv); // Required MPI initialization call

  MPI_Comm_size(MPI_COMM_WORLD, &numProcs); // Get no. of processes
  MPI_Comm_rank(MPI_COMM_WORLD, &rank); // Which process am I?

  
  if (rank == 0) {
    // Print a table heading
    printf("\nMatrix multiplication times:\n   N          COMM (secs)            COMP (secs)             TIME (secs)        F-norm of Error\n-------  ---------------------  ----------------------  ---------------------  ------------------\n");
  }

  blocks = (int *) calloc(numProcs + 1, sizeof(int)); 
  countsAB = (int *) calloc(numProcs, sizeof(int));
  displsAB = (int *) calloc(numProcs, sizeof(int));
  countsC = (int *) calloc(numProcs, sizeof(int));
  displsC = (int *) calloc(numProcs, sizeof(int));
  cpTimes = (double *) calloc(numProcs, sizeof(double));
  toTimes = (double *) calloc(numProcs, sizeof(double));

  // Run the four test cases
  for (run = runStart; run < runEnd; run++) {
    // Measure total time
    double startTime = MPI_Wtime();
    
    N = sizes[run];
    // Reset computing time for each run
    cpTime = 0;
    // Reset total computing time for each run
    toTime = 0;

    // Initialize matrices in root process
    if (rank == 0) {
      sizeAB = N * (N + 1) / 2;
      sizeC = N * N; // All of C will be nonzero, in general!

      A = (double *) calloc(sizeAB, sizeof(double));
      B = (double *) calloc(sizeAB, sizeof(double));
      C = (double *) calloc(sizeC, sizeof(double));


      srand(12345); // Use a standard seed value for reproducibility

      // This assumes A is stored by rows, and B is stored by columns. Other storage schemes are permitted
      for (i = 0; i < sizeAB; i++)
        A[i] = ( (double) rand() / (double) RAND_MAX );
      
      for (i = 0; i < sizeAB; i++)
        B[i] = ( (double) rand() / (double) RAND_MAX );

      // Distribute work to processes
      int start, end;
      for (i = 1; i <= numProcs; i++) {
        start = blocks[i - 1];
        end = (i == numProcs ? N : calcRoot(N, numProcs, i));
        // Block i includes rows/columns from [start, end)
        blocks[i] = end; 
        // Number of elements to send to process i
        countsAB[i - 1] = (start + end + 1) * (end - start) / 2; 
        // Displacement from which to take the outgoing data to process i
        displsAB[i] = displsAB[i - 1] + countsAB[i - 1];
        // Number of elements to send to process i
        countsC[i - 1] = (end - start) * N; 
        // Displacement from which to take the outgoing data to process i
        displsC[i] = displsC[i - 1] + countsC[i - 1];
      } 

      blocks[numProcs] = N;
    }


    // Broadcast countsAB, countsC, blocks for message passing between processes
    MPI_Bcast(countsAB, numProcs, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(countsC, numProcs, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(blocks, numProcs + 1, MPI_INT, 0, MPI_COMM_WORLD);


    // Calculate memory size needed to store elements of A. In this case, blocksizeB is countsAB[rank] 
    blockSizeA = countsAB[rank];
    // Calculate momory size needed to store elemets of B. In this case, blockSizeB is countsAB[numProcs - 1]
    blockSizeB = countsAB[numProcs - 1];
    // Calculate momory size needed to store elements of C
    blockSizeC = countsC[rank];
    // Allocate space for A, B, C, recvB, sendB
    blockA = (double *) calloc(blockSizeA, sizeof(double));
    blockB = (double *) calloc(blockSizeB, sizeof(double));
    blockC = (double *) calloc(blockSizeC, sizeof(double));
    recvB = (double *) calloc(blockSizeB, sizeof(double));
    sendB = (double *) calloc(blockSizeB, sizeof(double));

    
    MPI_Scatterv(A, countsAB, displsAB, MPI_DOUBLE, blockA, blockSizeA, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Scatterv(B, countsAB, displsAB, MPI_DOUBLE, blockB, blockSizeB, MPI_DOUBLE, 0, MPI_COMM_WORLD);


    const int prev = (rank - 1 + numProcs) % numProcs, cur = rank, next = (rank + 1) % numProcs;
    int prevPtr = prev, curPtr = cur;


    
    for (i = 0; i < numProcs - 1; i++) { 
      memcpy(sendB, blockB, countsAB[curPtr] * sizeof(double));
      MPI_Isend(sendB, countsAB[curPtr], MPI_DOUBLE, next, type, MPI_COMM_WORLD, &reqs[0]);
      MPI_Irecv(recvB, countsAB[prevPtr], MPI_DOUBLE, prev, type, MPI_COMM_WORLD, &reqs[1]);

      // Add computing time
      time = MPI_Wtime();
      matmulBlock(N, blocks[cur], blocks[cur + 1], blocks[curPtr], blocks[curPtr + 1], blockA, blockB, blockC);
      cpTime += MPI_Wtime() - time;
      
      for (int j = 0; j < 2; j++)
        MPI_Wait(&reqs[j], &stats[j]);
      memcpy(blockB, recvB, countsAB[prevPtr] * sizeof(double));

      curPtr = prevPtr;
      prevPtr = (prevPtr - 1 + numProcs) % numProcs;
    }

    // Add computing time
    time = MPI_Wtime();
    matmulBlock(N, blocks[cur], blocks[cur + 1], blocks[curPtr], blocks[curPtr + 1], blockA, blockB, blockC);
    cpTime += MPI_Wtime() - time;

    MPI_Gatherv(blockC, blockSizeC, MPI_DOUBLE, C, countsC, displsC, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    toTime += MPI_Wtime() - startTime;

    MPI_Gather(&cpTime, 1, MPI_DOUBLE, cpTimes, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Gather(&toTime, 1, MPI_DOUBLE, toTimes, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);


    // Check the result against the correct answer (read into Ctrue)
    if (rank == 0) {
      Ctrue = (double *) calloc(sizeC, sizeof(double));
      fptr = fopen(files[run], "rb");
      fread(Ctrue, sizeof(double), sizeC, fptr);
      fclose(fptr);

      // Compute the Frobenius norm of Ctrue - C
      Fnorm = 0.;
      for (i = 0; i < sizeC; i++)
        Fnorm += (Ctrue[i] - C[i]) * (Ctrue[i] - C[i]);
      Fnorm = sqrt(Fnorm);

      // Print one table row for each process
      for (i = 0; i < numProcs; i++) 
        printf (" %5d         %9.4f              %9.4f               %9.4f          %15.10f\n", N, toTimes[i] - cpTimes[i], cpTimes[i], toTimes[i], Fnorm);

      free(A);
      free(B);
      free(C);
      free(Ctrue);
    } else {
      free(blockA);
      free(blockB);
      free(blockC);
      free(recvB);
      free(sendB);
    }
  }

  free(blocks);
  free(countsAB);
  free(displsAB);
  free(countsC);
  free(displsC);
  free(cpTimes);
  free(toTimes);

  MPI_Finalize();

  return 0;
}
