---
layout: howto
title:  "Generate SSH key"
date:   2016-04-25 12:00:00 +0200
description: Required to login on the slave nodes without a password
tags: setup howto master
difficulty: easy
order: 50
---

Log in as farmer and run this

```shell
ssh-keygen -t rsa -C farmer@raspifarm-master
```

This will create a directory `~/.ssh/`, add your personal SSH keys into `~/.ssh/authorized_keys`, you may have to create the file first.