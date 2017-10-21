---
layout: howto
title:  "Starting Spark and Jupyter"
date:   2016-07-18 14:00:00 +0200
description: Starting Spark and Jupyter with the cluster
tags: howto machinelearning master startup cluster spark jupyter
difficulty: advanced
order: 50
---


## Make /etc/rc.local executable with chmod

```shell
sudo chmod +x /etc/rc.local
```

## Edit /etc/rc.local

SPARK\_HOME and PYTHONPATH need to be set here or else Jupyter will not know where to look for these libraries!

Copy the following lines into `/etc/rc.local`:

```shell
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.

# Redirect output to /tmp/rc.local.log
exec 2> /tmp/rc.local.log      # send stderr from rc.local to a log file
exec 1>&2                      # send stdout to the same log file
set -x                         # tell sh to display commands before execution

# Execute the following lines as user farmer
su farmer <<'EOF'

# Set PATH
export PATH=$PATH:/home/farmer/spark/bin/

# Set Spark-Paths
export SPARK_HOME=/home/farmer/spark/
export PYTHONPATH=$PYTHONPATH:$SPARK_HOME/python/:$SPARK_HOME/python/lib/py4j-0.9-src.zip

# Start the jupyter-server
cd /home/farmer/
jupyter notebook --ip '*' &

# delay the start of spark to make sure the slave-nodes are all booted up and ready
sleep 20
~/spark/sbin/start-all.sh

EOF

exit 0
```
