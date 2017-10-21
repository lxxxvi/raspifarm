---
layout: howto
title:  "Install MPI on the cluster"
date:   2016-05-09 12:00:00 +0200
description: "What's that used for?"
---

How to install MPI on the cluster

Run `sudo apt-get install -y python-mpi4py` on all nodes.

Test the installation: `mpiexec -n 5 python -m mpi4py helloworld`

Create **machinefile** in `~/` with the ip-addresses of the nodes:

```
farmer@192.168.17.11
farmer@192.168.17.12
farmer@192.168.17.13
farmer@192.168.17.14
farmer@192.168.17.15
farmer@192.168.17.16
farmer@192.168.17.17
farmer@192.168.17.18
```

Run:
```
mpiexec -n 4 -machinefile ~/machinefile python -m mpi4py helloworld
```

Output should be:

```
Hello, World! I am process 0 of 4 on raspifarm-slave-11.
Hello, World! I am process 1 of 4 on raspifarm-slave-12.
Hello, World! I am process 2 of 4 on raspifarm-slave-13.
Hello, World! I am process 3 of 4 on raspifarm-slave-14.
```

# Running a Jupyter-notebook on the cluster

Tutorial: https://ipython.org/ipython-doc/3/parallel/parallel_mpi.html

1. Convert .ipynb to .py

```
jupyter nbconvert mpi-cluster-script.ipynb --to python
```

2. Install IPython on all the nodes

```
sudo apt-get -y install python3-pip npm nodejs-legacy
```

3. Start the controller and engines
```
ipcluster start -n 4 --engines=MPIEngineSetLauncher
``
3. Run the python-script

```
mpiexec -n 4 -machinefile ~/machinefile python mpi-world.py
```
```python
# mpi-world.py
from mpi4py import MPI

comm=MPI.COMM_WORLD

rank=comm.rank
size=comm.size

i=1
for j  in range(400):
    data=j*j
    comm.send(data,dest=(rank+1)%size)
    data1=comm.recv(source=(rank-1)%size)
    print data1
    print

```

# Running your own python scripts on the cluster

```
mpiexec -n 4 -machinefile /path/to/machinefile python example_script.py
```

```
# example_script.py
from mpi4py import MPI
rank = MPI.COMM_WORLD.Get_rank()

a = 6.0
b = 3.0
if rank == 0:
    print a + b
if rank == 1:
    print a * b
if rank == 2:
    print max(a,b)
if rank == 3:
    print min(a,b)
```
