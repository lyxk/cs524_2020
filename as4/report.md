# CPSC 524 Assignment 4

yl2335, Yangxiaokang Liu

## Environment

1. module load OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.3

2. module list

   > [cpsc424_yl2335@grace1 yl2335_ps4_cpsc424]$ module list
   >
   > Currently Loaded Modules:
   >   1) StdEnv                                           (S)
   >   2) GCCcore/7.3.0
   >   3) binutils/2.30-GCCcore-7.3.0
   >   4) icc/2018.3.222-GCC-7.3.0-2.30
   >   5) ifort/2018.3.222-GCC-7.3.0-2.30
   >   6) iccifort/2018.3.222-GCC-7.3.0-2.30
   >   7) zlib/1.2.11-GCCcore-7.3.0
   >   8) numactl/2.0.11-GCCcore-7.3.0
   >   9) XZ/5.2.4-GCCcore-7.3.0
   >  10) libxml2/2.9.8-GCCcore-7.3.0
   >  11) libpciaccess/0.14-GCCcore-7.3.0
   >  12) hwloc/1.11.10-GCCcore-7.3.0
   >  13) OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
   >
   >   Where:
   >    S:  Module is Sticky, requires --force to unload or purge
   >
   > 

## Running the program

1. sh submit.sh
2. Output files used for this report are stored in the output directory.

## Task 1: Serial Program

| Size | Time 1   | Time 2  | Time 3  | Avg Time |
| ---- | -------- | ------- | ------- | -------- |
| 1000 | 0.1543   | 0.154   | 0.1532  | 0.1538   |
| 2000 | 1.1898   | 1.1802  | 1.181   | 1.1837   |
| 4000 | 14.3322  | 14.2961 | 14.2572 | 14.2952  |
| 8000 | 121.2531 | 120.754 | 120.826 | 120.9444 |

As can be seen from the table, running time grows almost cubically with respect to N.

## Task2: Blocking MPI Parallel Program

### Part A

* 3 runs for each combination of $N \in \{1000, 2000, 4000, 8000\}$ and $p \in \{1, 2, 4, 8\}$
* The results are shown below

<div style="text-align:center; font-weight:bold"> size = 1000 </div>

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.1858 | 0.1849 | 0.1848 | 0.1852   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.1503 | 0.1486 | 0.15   | 0.1496   |
| p1      | 0.1503 | 0.1486 | 0.15   | 0.1496   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.1016 | 0.1033 | 0.1045 | 0.1031   |
| p1      | 0.0976 | 0.0992 | 0.1002 | 0.0990   |
| p2      | 0.1012 | 0.1029 | 0.1039 | 0.1027   |
| p3      | 0.1016 | 0.1035 | 0.1044 | 0.1032   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.077  | 0.0772 | 0.0781 | 0.0774   |
| p1      | 0.0731 | 0.0733 | 0.0739 | 0.0734   |
| p2      | 0.0737 | 0.0741 | 0.0742 | 0.0740   |
| p3      | 0.0741 | 0.0743 | 0.0756 | 0.0747   |
| p4      | 0.0753 | 0.0751 | 0.0759 | 0.0754   |
| p5      | 0.076  | 0.0767 | 0.0774 | 0.0767   |
| p6      | 0.0768 | 0.0769 | 0.0777 | 0.0771   |
| p7      | 0.0771 | 0.0771 | 0.0781 | 0.0774   |

<div style="text-align:center; font-weight:bold"> size = 2000 </div>

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 1.3105 | 1.3095 | 1.3091 | 1.3097   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.9545 | 0.9491 | 0.9542 | 0.9526   |
| p1      | 0.9586 | 0.953  | 0.9584 | 0.9567   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.6787 | 0.6802 | 0.6824 | 0.6804   |
| p1      | 0.633  | 0.6352 | 0.6355 | 0.6346   |
| p2      | 0.6807 | 0.6821 | 0.6844 | 0.6824   |
| p3      | 0.683  | 0.6846 | 0.687  | 0.6849   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.4164 | 0.4167 | 0.4151 | 0.4161   |
| p1      | 0.3777 | 0.3775 | 0.3773 | 0.3775   |
| p2      | 0.3827 | 0.3831 | 0.383  | 0.3829   |
| p3      | 0.4028 | 0.403  | 0.4019 | 0.4026   |
| p4      | 0.4076 | 0.4091 | 0.4076 | 0.4081   |
| p5      | 0.4142 | 0.4144 | 0.4132 | 0.4139   |
| p6      | 0.4199 | 0.4205 | 0.4189 | 0.4198   |
| p7      | 0.4211 | 0.4215 | 0.4199 | 0.4208   |

<div style="text-align:center; font-weight:bold"> size = 4000 </div>

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 14.7601 | 14.7728 | 14.7638 | 14.7656  |

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 10.7895 | 10.7378 | 10.7709 | 10.7661  |
| p1      | 10.8061 | 10.7546 | 10.7886 | 10.7831  |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 6.1392 | 6.1209 | 6.1357 | 6.1319   |
| p1      | 5.475  | 5.4208 | 5.4398 | 5.4452   |
| p2      | 6.147  | 6.1295 | 6.1437 | 6.1401   |
| p3      | 6.1567 | 6.1388 | 6.1537 | 6.1497   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 3.3554 | 3.3564 | 3.3491 | 3.3536   |
| p1      | 2.8991 | 2.8898 | 2.8901 | 2.8930   |
| p2      | 2.9442 | 2.9348 | 2.9343 | 2.9378   |
| p3      | 3.1447 | 3.1409 | 3.138  | 3.1412   |
| p4      | 3.2216 | 3.2206 | 3.2145 | 3.2189   |
| p5      | 3.2929 | 3.2925 | 3.288  | 3.2911   |
| p6      | 3.3684 | 3.3686 | 3.3618 | 3.3663   |
| p7      | 3.3724 | 3.3736 | 3.3663 | 3.3708   |

<div style="text-align:center; font-weight:bold"> size = 8000 </div>

| Process | Time 1   | Time 2  | Time 3   | Avg Time |
| ------- | -------- | ------- | -------- | -------- |
| p0      | 122.6584 | 122.701 | 122.7282 | 122.6959 |

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 88.834  | 88.7642 | 88.7727 | 88.7903  |
| p1      | 88.8998 | 88.8301 | 88.8391 | 88.8563  |

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 62.3269 | 60.748  | 60.8343 | 61.3031  |
| p1      | 55.7167 | 55.8437 | 55.8725 | 55.8110  |
| p2      | 62.3536 | 60.7752 | 60.8611 | 61.3300  |
| p3      | 62.3929 | 60.8145 | 60.9003 | 61.3692  |

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 34.0834 | 34.051  | 34.081  | 34.0718  |
| p1      | 29.7546 | 29.4313 | 29.8036 | 29.6632  |
| p2      | 30.3971 | 29.9597 | 30.4395 | 30.2654  |
| p3      | 32.388  | 32.2264 | 32.4179 | 32.3441  |
| p4      | 33.2962 | 33.2684 | 33.3329 | 33.2992  |
| p5      | 33.4583 | 33.4892 | 33.4889 | 33.4788  |
| p6      | 34.1307 | 34.0986 | 34.1282 | 34.1192  |
| p7      | 34.1498 | 34.1177 | 34.1478 | 34.1384  |

**Raw Performance**

To assess raw performance, one can measure the longest time taken by all the processes. In our case, the first/the last process almost always have the longest running time due to more communication/computational workload. We can see that the running time increases with as the size of the matrix increases and decreases as the number of processes increases.

**Scalability**

1. As N doubles,  running time tends to scale by 8. This is because the time complexity of triangular matrix multiplication is approximately $O(N^3)$.
2. As p doubles, performance scales from near 0.75 to near 0.5. This is because the largest computational workload is distributed to the last process. When p goes from 1 to 2, we cut the triangle into two parts and take the larger one. After that, we always cut the last trapezoid into two parts and take the larger one, gradually the ratio becomes closer to 0.5.

**Load Balance**

1. The overall time of processes are close to evenly distributed.
2. Computational wordload is not evenly distributed. Higher rank processes spend more time computing and less time communicating, this is because their blocks have more non-zero elements than lower rank processes. Process 0 has the highest communication time due to both setting up and performing the actual computation.

### Part B

* 3 runs for each combination of $n \in \{1, 2, 4\}$ and $p \in \{4, 8\}$ when $N = 8000$
* The results are shown below

<div style="text-align:center; font-weight:bold"> p = 4, n = 1 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 51.6059  | 9.6972   | 61.3031  |
| p1      | 26.2234  | 29.5876  | 55.8110  |
| p2      | 20.9181  | 40.4119  | 61.3300  |
| p3      | 16.9910  | 44.3783  | 61.3693  |

<div style="text-align:center; font-weight:bold"> p = 4, n = 2 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 54.0109  | 7.4599   | 61.4707  |
| p1      | 29.7520  | 25.9881  | 55.7401  |
| p2      | 24.1578  | 37.2624  | 61.4202  |
| p3      | 14.8595  | 46.6112  | 61.4706  |

<div style="text-align:center; font-weight:bold"> p = 4, n = 4 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 50.3672  | 7.4629   | 57.8301  |
| p1      | 26.1281  | 25.9321  | 52.0602  |
| p2      | 20.4410  | 37.3382  | 57.7792  |
| p3      | 14.8620  | 42.9679  | 57.8300  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 1 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 31.7115  | 1.7576   | 33.4711  |
| p1      | 22.8718  | 4.7819   | 27.6461  |
| p2      | 18.4120  | 9.8790   | 28.3087  |
| p3      | 17.3118  | 13.7022  | 31.0150  |
| p4      | 14.8909  | 17.4310  | 32.3077  |
| p5      | 13.6668  | 19.3427  | 33.0190  |
| p6      | 10.5030  | 22.9410  | 33.4451  |
| p7      | 10.1326  | 23.3384  | 33.4710  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 2 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 31.7610  | 1.7558   | 33.5168  |
| p1      | 22.8316  | 4.7950   | 27.6266  |
| p2      | 18.3912  | 9.8929   | 28.2841  |
| p3      | 17.3204  | 13.6725  | 30.9929  |
| p4      | 14.8893  | 17.3912  | 32.2805  |
| p5      | 13.6589  | 19.3344  | 32.9933  |
| p6      | 10.4760  | 23.0150  | 33.4910  |
| p7      | 10.1900  | 23.3268  | 33.5168  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 4 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 30.1496  | 1.7558   | 31.9054  |
| p1      | 21.4063  | 4.7954   | 26.2017  |
| p2      | 18.1037  | 8.7636   | 26.8673  |
| p3      | 16.4451  | 12.9559  | 29.4010  |
| p4      | 14.1812  | 16.0455  | 30.2267  |
| p5      | 11.8814  | 19.2291  | 31.1105  |
| p6      | 11.8406  | 20.0389  | 31.8794  |
| p7      | 10.2558  | 21.6495  | 31.9053  |

**Raw Performance**

* For p = 4, the communication time goes up when n changes from 1 to 2 and drops when n changes from 2 to 4 . When n changes from 1 to 2, communication between nodes and within each node are both required, increasing the communication time. When n changes from 2 to 4, communication within each node are no longer required, which decreases the communication time. The computation time goes down when n changes from 1 to 2 and nearly stays the same when n changes from 2 to 4.  Computation time decreases because each socket only runs one process, there's less competition for resources such as cache and bandwidth. Computation time stays the same because resources are not the bottleneck any more.

* For p = 8, the communication and computation time nearly stays the same when n changes from 1 to 2 and drops when n changes from 2 to 4. When n changes from 1 to 2, communication between nodes and within each node are both required, therefore the communication time increases slightly. There are multiple processes on one sockets, they may compete for resources such as bandwidth, L3 cache, therefore the computation time nearly stays the same. When n changes from 2 to 4, each process occupy a single socket, the computation time and communication time decreases.

* It can be seen that the change of time for p = 8 are less obvious than p = 4 because the chunk size are smaller when p = 8.

**Load Balance**

* As in Part A, total time is almost evenly distributed.

* As in Part A, higher rank processes spend more time computing and less time communicating. lower rank processes spend more time communicating and less time computing.

### Possible improvements

1. Dividing blocks according to the number of elements rather than the number of rows/cols.
   * This would lead to a more evenly distributed workload, resulting in reduced computing time and communication time, improving the overall performance.
2. Using non-blocking communication for ring-pass communications.
   1. This can improve the performance since send/recv operations can be overlapped with computation.
   2. Load balance would basically stays the same since computational work distribution is the same. Scaling factor would also stay the same.



## Task3: Non-Blocking MPI Parallel Program

### Part A

* 3 runs for each combination of $N \in \{1000, 2000, 4000, 8000\}$ and $p \in \{1, 2, 4, 8\}$
* The results are shown below

<div style="text-align:center; font-weight:bold"> size = 1000 </div>

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.1859 | 0.1857 | 0.1858 | 0.1858   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.153  | 0.1509 | 0.1517 | 0.1519   |
| p1      | 0.153  | 0.1509 | 0.1517 | 0.1519   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.1106 | 0.109  | 0.1102 | 0.1099   |
| p1      | 0.093  | 0.0912 | 0.0921 | 0.0921   |
| p2      | 0.1102 | 0.108  | 0.1091 | 0.1091   |
| p3      | 0.1107 | 0.1091 | 0.1102 | 0.1100   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.0743 | 0.0742 | 0.0743 | 0.0743   |
| p1      | 0.0682 | 0.0683 | 0.0684 | 0.0683   |
| p2      | 0.0687 | 0.0689 | 0.0686 | 0.0687   |
| p3      | 0.0691 | 0.0691 | 0.0693 | 0.0692   |
| p4      | 0.0707 | 0.0706 | 0.0707 | 0.0707   |
| p5      | 0.0737 | 0.0735 | 0.0737 | 0.0736   |
| p6      | 0.0738 | 0.0737 | 0.0739 | 0.0738   |
| p7      | 0.0744 | 0.0743 | 0.0744 | 0.0744   |

<div style="text-align:center; font-weight:bold"> size = 2000 </div>

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 1.3093 | 1.3089 | 1.3087 | 1.3090   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.9589 | 0.9534 | 0.9542 | 0.9555   |
| p1      | 0.9633 | 0.9576 | 0.9579 | 0.9596   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.6736 | 0.6753 | 0.6748 | 0.6746   |
| p1      | 0.5591 | 0.562  | 0.5618 | 0.5610   |
| p2      | 0.6752 | 0.6784 | 0.6779 | 0.6772   |
| p3      | 0.678  | 0.6803 | 0.6798 | 0.6794   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 0.4042 | 0.4039 | 0.4088 | 0.4056   |
| p1      | 0.3572 | 0.3574 | 0.3613 | 0.3586   |
| p2      | 0.3581 | 0.3582 | 0.3626 | 0.3596   |
| p3      | 0.3594 | 0.3596 | 0.3636 | 0.3609   |
| p4      | 0.3757 | 0.3734 | 0.3784 | 0.3758   |
| p5      | 0.4066 | 0.4062 | 0.4112 | 0.4080   |
| p6      | 0.4078 | 0.4076 | 0.4125 | 0.4093   |
| p7      | 0.4087 | 0.4084 | 0.4134 | 0.4102   |

<div style="text-align:center; font-weight:bold"> size = 4000 </div>

| Process | Time 1  | Time 2 | Time 3  | Avg Time |
| ------- | ------- | ------ | ------- | -------- |
| p0      | 14.7512 | 14.72  | 14.7688 | 14.7467  |

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 10.7812 | 10.7975 | 10.7765 | 10.7851  |
| p1      | 10.7985 | 10.8145 | 10.7934 | 10.8021  |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 6.1836 | 6.204  | 6.1601 | 6.1826   |
| p1      | 5.0442 | 5.0772 | 5.0553 | 5.0589   |
| p2      | 6.191  | 6.2119 | 6.1679 | 6.1903   |
| p3      | 6.2005 | 6.2219 | 6.1778 | 6.2001   |

| Process | Time 1 | Time 2 | Time 3 | Avg Time |
| ------- | ------ | ------ | ------ | -------- |
| p0      | 3.1922 | 3.1952 | 3.2157 | 3.2010   |
| p1      | 2.7012 | 2.7058 | 2.7256 | 2.7109   |
| p2      | 2.7055 | 2.7105 | 2.7299 | 2.7153   |
| p3      | 2.7105 | 2.715  | 2.7344 | 2.7200   |
| p4      | 2.9159 | 2.9075 | 2.9358 | 2.9197   |
| p5      | 3.2004 | 3.2032 | 3.2237 | 3.2091   |
| p6      | 3.2043 | 3.2071 | 3.2279 | 3.2131   |
| p7      | 3.2095 | 3.2125 | 3.2329 | 3.2183   |

<div style="text-align:center; font-weight:bold"> size = 8000 </div>

| Process | Time 1   | Time 2   | Time 3   | Avg Time |
| ------- | -------- | -------- | -------- | -------- |
| p0      | 122.4523 | 122.5093 | 122.6978 | 122.5531 |

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 88.8197 | 88.7429 | 88.8293 | 88.7973  |
| p1      | 88.8848 | 88.8079 | 88.8954 | 88.8627  |

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 59.533  | 59.6788 | 59.6117 | 59.6078  |
| p1      | 46.9258 | 46.894  | 46.8683 | 46.8960  |
| p2      | 59.56   | 59.7057 | 59.6383 | 59.6347  |
| p3      | 59.599  | 59.7448 | 59.6773 | 59.6737  |

| Process | Time 1  | Time 2  | Time 3  | Avg Time |
| ------- | ------- | ------- | ------- | -------- |
| p0      | 31.3002 | 31.3095 | 31.6114 | 31.4070  |
| p1      | 26.0875 | 26.0962 | 26.3774 | 26.1870  |
| p2      | 26.1074 | 26.1159 | 26.3961 | 26.2065  |
| p3      | 26.128  | 26.1363 | 26.4171 | 26.2271  |
| p4      | 27.7984 | 27.7428 | 28.0051 | 27.8488  |
| p5      | 31.3286 | 31.3378 | 31.6387 | 31.4350  |
| p6      | 31.3475 | 31.3568 | 31.6579 | 31.4541  |
| p7      | 31.3665 | 31.3757 | 31.6772 | 31.4731  |

**Raw Performance**

Comparing Task 3 to Task 2, the raw performance in Task 3 is slightly better when N is large and p is large. Because communication plays a bigger role with large N and p.

**Scalability**

Task 3 has similar characteristics to Task 2.

**Load Balance**

Task 3 has similar load balances to Task 2. Higher rank processes spend more time computing and less time communicating.

### Part B

* 3 runs for each combination of $n \in \{1, 2, 4\}$ and $p \in \{4, 8\}$ when $N = 8000$
* The results are shown below

<div style="text-align:center; font-weight:bold"> p = 4, n = 1 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 50.1049  | 9.5030   | 59.6078  |
| p1      | 18.1434  | 28.7526  | 46.8960  |
| p2      | 20.9575  | 38.6771  | 59.6346  |
| p3      | 14.8510  | 44.8227  | 59.6737  |

<div style="text-align:center; font-weight:bold"> p = 4, n = 2 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 53.8241  | 7.4506   | 61.2747  |
| p1      | 24.0216  | 26.2075  | 50.2291  |
| p2      | 23.6636  | 37.5605  | 61.2241  |
| p3      | 14.8499  | 46.4248  | 61.2747  |

<div style="text-align:center; font-weight:bold"> p = 4, n = 4 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 50.1650  | 7.4514   | 57.6165  |
| p1      | 20.4401  | 25.9392  | 46.3793  |
| p2      | 19.8513  | 37.7143  | 57.5655  |
| p3      | 14.9167  | 42.6996  | 57.6163  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 1 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 29.3939  | 2.0158   | 31.4070  |
| p1      | 18.0568  | 8.1428   | 26.1870  |
| p2      | 13.7390  | 12.4486  | 26.2064  |
| p3      | 9.2230   | 17.0287  | 26.2271  |
| p4      | 8.7843   | 19.0358  | 27.8487  |
| p5      | 9.8471   | 21.6298  | 31.4350  |
| p6      | 8.9306   | 22.4836  | 31.4541  |
| p7      | 7.5428   | 23.9797  | 31.4731  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 2 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 29.7246  | 1.7637   | 31.4883  |
| p1      | 20.1438  | 4.8394   | 24.9832  |
| p2      | 14.7210  | 10.2886  | 25.0097  |
| p3      | 12.2976  | 13.8793  | 26.1769  |
| p4      | 9.8587   | 17.6108  | 27.4695  |
| p5      | 11.8918  | 19.5447  | 31.4365  |
| p6      | 8.4308   | 23.0314  | 31.4622  |
| p7      | 8.1426   | 23.3457  | 31.4883  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 4 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 28.4366  | 1.7494   | 30.1860  |
| p1      | 18.4818  | 4.7763   | 23.2580  |
| p2      | 14.5799  | 8.7031   | 23.2830  |
| p3      | 14.1170  | 12.9514  | 27.0684  |
| p4      | 11.8440  | 16.0761  | 27.9202  |
| p5      | 10.9573  | 19.1769  | 30.1342  |
| p6      | 10.1049  | 20.0552  | 30.1602  |
| p7      | 8.5720   | 21.6140  | 30.1860  |

**Raw Performance**

* The trends when p = 4 and p = 8 are similar to task 2. When n changes from 1 to 2, communication time almost stays the same or even goes up, computation time decreases. When n changes from 2 to 4, communication time drops and computation time almost stays the same.
* The reasoning for task 2 still applies to task 3. However, since non-blocking  send/recv leads to overlapping between computation and communication, the communication time decreases and the overall performance increases.

**Load Balance**

* The characteristics of load balance are similar to task 2.

* The workload is slightly less evenly distributed than task 2. Probably because of the overlapped send/recv time. (Before overlapping, process with lower ranks spends less time sending blocks in the ring-pass stage, which helps decrease the gap in communication time between processes. With overlapping, this proportion of time may have been overlapped with computation time, the gap in communication time may become larger between processes.)

## Task 4: Load Balance

* 3 runs for each combination of $n \in \{1, 2, 4\}$ and $p \in \{4, 8\}$ when $N = 8000$
* The results are shown below

<div style="text-align:center; font-weight:bold"> p = 4, n = 1 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 2.3823   | 37.3345  | 39.7168  |
| p1      | 7.0158   | 32.7363  | 39.7521  |
| p2      | 10.9595  | 28.8163  | 39.7758  |
| p3      | 14.4756  | 25.3072  | 39.7829  |

<div style="text-align:center; font-weight:bold"> p = 4, n = 2 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 2.4085   | 33.3280  | 35.7365  |
| p1      | 4.4883   | 31.1879  | 35.6761  |
| p2      | 8.7645   | 26.9442  | 35.7086  |
| p3      | 10.8953  | 24.8412  | 35.7364  |

<div style="text-align:center; font-weight:bold"> p = 4, n = 4 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 3.2647   | 33.3132  | 36.5779  |
| p1      | 5.4125   | 31.1038  | 36.5163  |
| p2      | 9.6028   | 26.9469  | 36.5497  |
| p3      | 12.7095  | 23.8683  | 36.5778  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 1 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 2.6415   | 21.2666  | 23.8950  |
| p1      | 2.9313   | 20.8615  | 23.7948  |
| p2      | 4.6447   | 19.1557  | 23.8162  |
| p3      | 5.9905   | 17.8352  | 23.8343  |
| p4      | 7.8999   | 15.9342  | 23.8518  |
| p5      | 8.8332   | 15.0247  | 23.8677  |
| p6      | 9.7420   | 14.1421  | 23.8820  |
| p7      | 10.8657  | 13.0228  | 23.8950  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 2</div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 3.6021   | 16.7886  | 16.7886  |
| p1      | 3.1970   | 17.0896  | 20.6916  |
| p2      | 3.6359   | 16.6741  | 19.8711  |
| p3      | 4.4584   | 15.8711  | 19.5069  |
| p4      | 5.6005   | 14.7456  | 19.2040  |
| p5      | 6.4158   | 13.9465  | 19.5470  |
| p6      | 7.2472   | 13.1293  | 19.5451  |
| p7      | 7.9569   | 12.4337  | 19.6809  |

<div style="text-align:center; font-weight:bold"> p = 8, n = 4 </div>

| Process | Avg Comm | Avg Comp | Avg Time |
| ------- | -------- | -------- | -------- |
| p0      | 2.9419   | 14.0011  | 16.9430  |
| p1      | 2.7367   | 14.1020  | 16.8387  |
| p2      | 3.4384   | 13.4226  | 16.8610  |
| p3      | 3.8172   | 13.0641  | 16.8813  |
| p4      | 4.7141   | 12.1840  | 16.8982  |
| p5      | 5.1164   | 11.7983  | 16.9147  |
| p6      | 6.0215   | 10.9074  | 16.9289  |
| p7      | 6.4188   | 10.5241  | 16.9429  |

**Raw Performance**:

* Higher rank processes spend more time communicating and less time computing, which is the opposite as that in task 2 and task 3. This may be caused by the fact that higher rank processes have fewer number of rows/cols than lower rank processes in order for the total number of elements to be the same.

**Load Balance**

* Load balance is better than task 3. Computational work is more close to evenly distributed. However, it's still far from an even distribution, part of this may be due to different number of rows/cols each processe possesses.
* Higher rank processes spend less time computing and more time communicating.

## Task 5: Generalization

* 3 runs for $n = 4$ and $p = 4$ when $N = 7633$
* The results are shown below

> Currently Loaded Modules:
>   1) StdEnv                                           (S)
>   2) GCCcore/7.3.0
>   3) binutils/2.30-GCCcore-7.3.0
>   4) icc/2018.3.222-GCC-7.3.0-2.30
>   5) ifort/2018.3.222-GCC-7.3.0-2.30
>   6) iccifort/2018.3.222-GCC-7.3.0-2.30
>   7) zlib/1.2.11-GCCcore-7.3.0
>   8) numactl/2.0.11-GCCcore-7.3.0
>   9) XZ/5.2.4-GCCcore-7.3.0
>  10) libxml2/2.9.8-GCCcore-7.3.0
>  11) libpciaccess/0.14-GCCcore-7.3.0
>  12) hwloc/1.11.10-GCCcore-7.3.0
>  13) OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
>
>   Where:
>    S:  Module is Sticky, requires --force to unload or purge
>
>  
>
> /home/cpsc424_yl2335/project/yl2335_ps4_cpsc424
> c03n[09,11-12],c04n02
> 2
> mpicc -g -O3 -xHost -fno-alias -std=c99 -I/home/cpsc424_ahs3/utils/timing -c task5.c
> mpicc -o task5 -g -O3 -xHost -fno-alias -std=c99 -I/home/cpsc424_ahs3/utils/timing task5.o matmul.o /home/cpsc424_ahs3/utils/timing/timing.o
>
> p = 7
>
> Matrix multiplication times:
>    N          COMM (secs)            COMP (secs)             TIME (secs)        F-norm of Error
>
> -------  ---------------------  ----------------------  ---------------------  ------------------
>
>   7633            2.6383                13.9591                 16.5975             0.0000000008
>   7633            2.4790                14.0254                 16.5044             0.0000000008
>   7633            3.1477                13.3787                 16.5265             0.0000000008
>   7633            3.6457                12.9008                 16.5465             0.0000000008
>   7633            4.6544                11.9128                 16.5672             0.0000000008
>   7633            5.2152                11.3682                 16.5835             0.0000000008
>   7633            6.1581                10.4393                 16.5974             0.0000000008
>
> real	0m17.440s
> user	0m32.821s
> sys	0m0.933s
>
> Matrix multiplication times:
>    N          COMM (secs)            COMP (secs)             TIME (secs)        F-norm of Error
>
> -------  ---------------------  ----------------------  ---------------------  ------------------
>
>   7633            2.6478                13.9418                 16.5896             0.0000000008
>   7633            2.4926                14.0041                 16.4967             0.0000000008
>   7633            3.1345                13.3844                 16.5189             0.0000000008
>   7633            3.6560                12.8825                 16.5386             0.0000000008
>   7633            4.7001                11.8595                 16.5596             0.0000000008
>   7633            5.1944                11.3814                 16.5758             0.0000000008
>   7633            6.1559                10.4337                 16.5896             0.0000000008
>
> real	0m17.378s
> user	0m32.817s
> sys	0m0.919s
>
> Matrix multiplication times:
>    N          COMM (secs)            COMP (secs)             TIME (secs)        F-norm of Error
>
> -------  ---------------------  ----------------------  ---------------------  ------------------
>
>   7633            2.5964                13.9703                 16.5667             0.0000000008
>   7633            2.4767                13.9985                 16.4752             0.0000000008
>   7633            3.1588                13.3382                 16.4970             0.0000000008
>   7633            3.6311                12.8855                 16.5165             0.0000000008
>   7633            4.7280                11.8088                 16.5368             0.0000000008
>   7633            5.1427                11.4103                 16.5530             0.0000000008
>   7633            6.1359                10.4306                 16.5666             0.0000000008
>
> real	0m17.319s
> user	0m32.778s
> sys	0m0.913s

