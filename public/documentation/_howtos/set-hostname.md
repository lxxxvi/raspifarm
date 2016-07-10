---
layout: howto
title:  "Set the hostname"
date:   2016-04-25 12:00:00 +0200
description: "Like humans, computer wants to have names too"
tags: setup howto master slave
difficulty: easy
order: 50
---

For the master, we used __raspifarm-master__ as hostname.

For the slave nodes, we used a pattern, for example:
Node 11 on address 192.168.17.11 is going to be named "raspifarm-slave-11".
So, the hostname pattern for the slave nodes looks like this: __raspifarm-slave-(the-node-nr)__

Anyway, here's how to do that:

Note that hostnames may **only** contain letters a - z, numbers 0 - 9 and hyphens "-".

Edit `/etc/hostname`

```shell
<the-hostname>
```

Edit `/etc/hosts`, write the hostname next to 127.0.**1.1**

```shell
127.0.1.1   <the-hostname>
```

