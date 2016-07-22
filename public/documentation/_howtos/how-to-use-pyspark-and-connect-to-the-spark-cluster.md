---
layout: howto
title:  "Using pyspark"
date:   2016-07-18 14:00:00 +0200
description: Using pyspark and working with the python-shell
tags: howto machinelearning master pyspark python shell
difficulty: advanced
order: 50
---

## Prerequisites

- Spark needs to be installed in `/home/farmer/spark`
- Make sure the SPARK_HOME and PYTHONPATH are set to include the correct directories!
- Make sure the Spark-Cluster is running!

## Starting the pyspark-shell

```shell
~/spark/bin/pyspark --master spark://192.168.17.1:7077
```

## Connecting to the cluster from the python-shell

### Open a python-shell from the command line on the master node

On the command line:

```shell
python 
```

### Setup the SparkContext inside the python-shell

Inside the python-shell:

```python
from pyspark import SparkConf
from pyspark import SparkContext

conf = SparkConf()
conf.setMaster('spark://192.168.17.1:7077')
conf.setAppName('THE_NAME_OF_YOUR_APP')
sc = SparkContext(conf=conf)
```

**Now you can use the variable 'sc' to calculate tasks on the cluster**

