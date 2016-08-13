---
layout: howto
title:  "Set SPARK_HOME and PYTHONPATH"
date:   2016-05-09 12:00:00 +0200
description: "Important if you want to use Spark on cluster"
tags: howto machinelearning master pyspark python shell
difficulty: easy
order: 40
---


Set `SPARK_HOME`

```shell
export SPARK_HOME=/home/farmer/spark
```

Set `PYTHONPATH`

```shell
PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.9-src.zip:$PYTHONPATH
export PYTHONPATH
```
