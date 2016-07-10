---
layout: howto
title:  "Install and run sysbench on cluster"
date:   2016-05-09 12:00:00 +0200
description: "What is this used for?"
order: 50
---

How to install and run sysbench on cluster

First login to master-node of the cluster via SSH.

```
# farmer@raspifarm-master:~/cluster $ bin/cluster run all "sudo apt-get -y install sysbench"
```

```
# farmer@raspifarm-master:~/cluster $ bin/cluster run all "nohup sysbench --test=cpu --cpu-max-prime=200000 --num-threads=8 run </dev/null &>/dev/null &"
```

`</dev/null &>/dev/null &` runs the command silently in the background.
