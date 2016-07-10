---
layout: howto
title:  "Static IP addresses for slave nodes"
description: "We need to know where our slaves are"
tags: setup howto slave
difficulty: easy
order: 50
---


At this point we have to think about which target STATIC address the new node is going to get. An IP address may not be used twice.

The 8 slave nodes we're going to setup will use STATIC IP addresses in the IP range between 11 and 18

```shell
192.168.17.11 -> Node 11  
192.168.17.12 -> Node 12  
192.168.17.13 -> Node 13  
...  
192.168.17.18 -> Node 18  
```

Let's assume we're installing "Node 11", thus 192.168.17.11, this has to be done:

Edit `/etc/network/interfaces`

Replace the line(s) for `eth0` with following:

```shell
auto eth0
allow-hotplug eth0
iface eth0 inet static
  address 192.168.17.11    # make sure this is the correct address!
  netmask 255.255.255.0
```

That was magic, let's restart the interface and see what happened.


```shell
sudo rm /var/lib/dhcp/*             # removes existing leases
sudo systemctl daemon-reload        # not always required, but whatever...
sudo service networking restart     
```

Check if it worked:

```shell
ifconfig eth0
```

...should display this on the second line

```shell
          inet addr:192.168.17.11  Bcast:192.168.17.255  Mask:255.255.255.0
```

Note, it can take a few seconds after `sudo service networking restart` until the IP address will appear in `ifconfig`, be patient.
