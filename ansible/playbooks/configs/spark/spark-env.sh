#!/usr/bin/env bash

# SPARK_WORKER_MEMORY, to set how much total memory workers have to give executors (e.g. 1000m, 2g)
# Total amount of memory that can be used on one machine
SPARK_WORKER_MEMORY=480m
# SPARK_DAEMON_MEMORY, to allocate to the master, worker and history server themselves (default: 1g)
SPARK_DAEMON_MEMORY=128m
SPARK_MASTER_IP=192.168.17.1

# Although these are settings for running the cluster with the YARN resource manager
# these need to be set or otherwise the master throws an out-of-memory exception
SPARK_EXECUTOR_MEMORY=480m
SPARK_DRIVER_MEMORY=480m
