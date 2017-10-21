---
layout: howto
title: "Install the farmer's SSH key on a slave"
description: "Easy access on the slave nodes for the farmer user"
difficulty: easy
tags: howto setup slave
order: 50
---

Now, we're going to log into the slave node from the master node, using the "farmer". In order that the farmer doesn't always have to enter the password we install the SSH key on the slave nodes.

Before you can proceed with this tutorial, make sure you have a [SSH key generated on the master node](/howtos/generate-ssh-key).

Execute this on the **farmer** node, make sure you replace the IP address with the slave's IP address you want to install the SSH key on.

```
cat ~/.ssh/id_rsa.pub | ssh farmer@192.168.17.xx 'mkdir -p .ssh; cat >> .ssh/authorized_keys'
```

Check if it worked, try to log into the slave node from the master node. It should not ask you for a password now ...

```
ssh farmer@192.168.17.xx
```