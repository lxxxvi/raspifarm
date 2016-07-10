---
layout: howto
title: "Configure Spark for Jupyter"
date:   2016-04-25 12:00:00 +0200
description: "Why do we do this?"
---



Add kernel definition for PySpark

```
sudo mkdir -p /usr/local/share/jupyter/kernels/pyspark/
cat <<EOF | sudo tee /usr/local/share/jupyter/kernels/pyspark/kernel.json
{
 "display_name": "PySpark",
 "language": "python",
 "argv": [
  "/usr/bin/python2",
  "-m",
  "ipykernel",
  "-f",
  "{connection_file}"
 ],
 "env": {
  "SPARK_HOME": "/home/farmer/spark/",
  "PYTHONPATH": "/home/farmer/spark/python:/home/farmer/spark/python/lib/py4j-0.9-src.zip",
  "PYTHONSTARTUP": "/home/farmer/spark/python/pyspark/shell.py",
  "PYSPARK_SUBMIT_ARGS": "--master spark://192.168.17.1:7077 pyspark-shell"
 }
}
EOF
```


Edit this file: /usr/local/share/jupyter/kernels/pyspark/kernel.json

**Important**: Set SPARK\_HOME, PYTHONPATH, PYTHONSTARTUP, PYSPARK\_SUBMIT\_ARGS according to your configuration!

## Testing if pyspark starts correctly

`ipython console --kernel pyspark`

then type `sc`

which should output something like:

```
In [1]: sc
Out[1]: <pyspark.context.SparkContext at 0x7f2b480f0e90>
```

## in jupyter web gui

run this script which uses the SparkContext 'sc' to calculate the number pi:

```
import random as ran
import time

start_time = time.time()

def sample(p):
    x, y = ran.random(), ran.random()
    return 1 if x*x + y*y < 1 else 0

NUM_SAMPLES = 1*1000*1000

print("Mapping...")
mappedOutput = sc.parallelize(xrange(0, NUM_SAMPLES)).map(sample)

print("Reducing...")
count = mappedOutput.reduce(lambda a, b: a + b)

print("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))
print("--- %s seconds ---" % (time.time() - start_time))
```

## SparkContext Infos

When a SparkContext is running it creates a webservice under [http://192.168.17.1:4040](http://192.168.17.1:4040/jobs/) where infos about the process can be accessed.


## The same with Jupyter (not JupyterHub)

Memory issues remain: **Only one Jupyter notebook with the pyspark-kernel can run at a time.**

```
jupyter notebook --ip '*'
```

## Disallow multiple SparkContexts

This doesn't solve the memory issue with multiple kernels being started.

```
sudo nano /home/farmer/spark/python/pyspark/shell.py
```

```
...
if os.environ.get("SPARK_EXECUTOR_URI"):
    SparkContext.setSystemProperty("spark.executor.uri", os.environ["SPARK_EXECUTOR_URI"])
    SparkContext.setSystemProperty("spark.driver.allowMultipleContexts", "false")
...
```
