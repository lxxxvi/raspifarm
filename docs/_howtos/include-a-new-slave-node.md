---
layout: howto
title: "Include a new slave node into the cluster"
description: "New nodes have to be 'discovered' and registered"
tags: howto setup slave
difficulty: medium
order: 1
---

Here's the situation:
You want to include a Raspberry Pi as a slave node into the cluster.

Before continuing, you have to answer every statement with yes:

* The designated slave has [Raspbian Jessie Lite installed](/howtos/flush-raspbian-to-sd-card)
* The designated slave is connected to the network and is powered
* The master node is properly installed (particularily [DHCP Server](/howtos/install-dnsmasq))
* The master node has [nmap](/howtos/install-utility-packages) installed. 

Good, you made it to this point, you're ready to start. Here's an ovierview of tasks you'll need to accomplish:

1. Log into the master node
2. Search for the designated slave in the network
3. Log into the slave node
4. Assign a static IP address to the slave node
5. Install the SSH key on the slave


## Log into the master node

```shell
ssh farmer@192.168.17.1
```


## Search for the designated slave in the network

Our DHCP server is configured that "guests" in the networ will get IP addresses in the range of 192.168.17.50 - 99. 
Our designed slave is a guest when connecting for the first time. 
We have to find our guest, and make it a node with a static IP address.

Precondition: nmap is installed

```shell
sudo nmap -sP 192.168.17.50-99 | grep Raspberry
```

Possible output

```shell
MAC Address: A1:11:BB:22:33:CC (Raspberry Pi Foundation)
```

This is the MAC address of the Raspberry Pi, now we have to find the corresponding IP address like so:

```shell
arp -a | grep -i "A1:11:BB:22:33:CC"
```

Possible output

```shell
? (192.168.17.55) at a1:11:bb:22:33:cc [ether] on eth0
```

That tells us we can connect to 192.168.17.55 using "pi", since we expect the Pi to be a freshly installed operating system.


## Log into the slave node

```shell
ssh pi@192.168.17.55
```

## Assign a static IP address to the slave node

Now it's time to asssign an IP address to the new node. Be aware, that an IP address may not be assigned twice. 
Follow the instructions on [how to set a static ip address for slave](/howtos/static-ip-addresses-for-slaves).

## Finish the installation

Now continue with the tasks for the [slave node setup](/setup.html).
