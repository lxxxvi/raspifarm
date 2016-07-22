---
layout: howto
title:  "Install Apache Spark"
date:   2016-07-19 15:00:00 +0200
description: How to install Apache Spark on the cluster
tags: howto machinelearning master slave spark apache cluster installation
difficulty: advanced
order: 50
---

## Prerequisites

- Raspbian needs to be installed on the master and all the slave-nodes
- Master and slave nodes need static ip addresses
- A computer with an internet connection
- Installed ansible on the master-node

## Download Apache Spark

Go to this website: [http://spark.apache.org/downloads.html](http://spark.apache.org/downloads.html)

Choose the latest stable release of Apache Spark. At the time of writing this was version 1.6.2.

Choose as package type "Pre-built for Hadoop 2.x".

This will download a file named something like "spark-1.6.2-bin-hadoop2.6.tgz".

Use scp to copy this file to the master node:

```shell
scp spark-1.6.2-bin-hadoop2.6.tgz farmer@192.168.17.1
```

Extract the contents of the package with:

```shell
tar xvfz spark-1.6.2-bin-hadoop2.6.tgz
```

This will create a new directory named "spark-1.6.2-bin-hadoop2.6"

Rename this directory to "spark":

```shell
mv spark-1.6.1-bin-hadoop2.6 spark
```

While still on the master-node you need to edit two files:

In **~/spark/conf/slaves** we define which IPs belong to the spark-cluster. This file only needs to exist on the master but it doesn't hurt if it is also on the slave-nodes.

Content of **~/spark/conf/slaves**:

```shell
# A Spark Worker will be started on each of the machines listed below.
farmer@192.168.17.11
farmer@192.168.17.12
farmer@192.168.17.13
farmer@192.168.17.14
farmer@192.168.17.15
farmer@192.168.17.16
farmer@192.168.17.17
farmer@192.168.17.18
```

In **~/spark/conf/spark-env.sh** we define the properties of our cluster (like the amount of RAM available to each node). 

Content of **~/spark/conf/spark-env.sh** on the **master-node**:

```shell
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
```

Copy the spark-directory to each node using ansible (this may take a while because the copy-command is really slow):

```shell
ansible raspifarm-slaves -m copy -a "src=/home/farmer/spark dest=/home/farmer/" -f 8
```

**IMPORTENT**: The spark-directory needs to be in the same directory on the master and the slave-nodes!

## Make all files inside the spark-folder executable.

On the master-node:

```shell
chmod -R +x spark
```

On the slave-nodes (automated with ansible): 

```shell
ansible raspifarm-slaves -a "chmod -R +x spark" -f 8
```
  
## Adjust log-level for spark

**On the master-node:**

Open `~/spark/conf/log4j.properties` with your favourite text-editor and change the following line:

```shell
log4j.rootCategory=INFO, console
```
  
to:

```shell
log4j.rootCategory=WARN, console
```

## Starting the spark-cluster manually

Before starting the spark-cluster we need to set some PATHs:

```shell
export PATH=$PATH:/home/farmer/spark/bin/

export SPARK_HOME=/home/farmer/spark/
export PYTHONPATH=$PYTHONPATH:$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.9-src.zip
```

Start the cluster from the master-node:

```shell
~/spark/sbin/start-all.sh
``` 

## Using the cluster via shell

Python-shell:

```shell
~/spark/bin/pyspark --master spark://192.168.17.1:7077
``` 

Scala-shell:

```shell
~/spark/bin/spark-shell --master spark://192.168.17.1:7077
``` 

