---
layout: howto
title:  "Install a DHCP server"
date:   2016-04-25 12:00:00 +0200
description: "Make your Raspberry Pi the master of IP address assignment"
difficulty: medium
tags: setup master howto
order: 50
---


OUTDATED!




This manual can be very confusing for unexperienced users. We had to read many, many tutorials our own because if it doesn't work, you'll have no idea where to start to investigate. To make it as easy as possible we have split the tutorial in 4 parts. Three of which are very easy, but the last one can be challenging for some users.

* Part 1: Make the Raspberry Pi's IP address static
* Part 2: Install a DHCP server
* Part 3: Tell the DHCP server what interface(s) to work with
* Part 4: Configure the DHCP server

## Part 1: Make the Raspberry Pi's IP address static

Before we started, we have decided to use 192.168.17.0 as subnet on the ethernet interface.

That means, that the master is going to take over the role of assigning IP addresses to every participant/node in the same network.

So, the master node needs to have a static IP address `192.168.17.1`, let's do this quickly:

Edit `/etc/network/interfaces` and replace the settings for eth0 with this:

```shell
auto eth0
allow-hotplug eth0
iface eth0 inet static
  address 192.168.17.1
  netmask 255.255.255.0
```


## Part 2: Install a DHCP server

Now we need a DHCP software:

```shell
sudo apt-get install isc-dhcp-server
```

Note, that there are other software that can do DHCP. We've tried [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) and [udhcp](https://udhcp.busybox.net/), but for some reason [isc-dhcp-server](https://www.isc.org/downloads/dhcp/) worked best for us.


## Part 3: Tell the DHCP server what interface(s) to work with

Let's tell the DHCP server what interface to manage, open and edit `/etc/default/isc-dhcp-server`.
Change the last line to the following value:

```shell
INTERFACES="eth0"
```


## Part 4: Configure the DHCP server

OK, now we have to configure the DHCP server in `/etc/dhcp/dhcpd.conf`.
Here's a summary of all settings that worked for us:

```shell
ddns-update-style none;

option domain-name "raspifarm";
option domain-name-servers 8.8.8.8, 8.8.4.4; # Google DNS

default-lease-time 600;
max-lease-time 7200;

authoritative;

log-facility local7;

subnet 192.168.17.0 netmask 255.255.255.0 {
  range 192.168.17.50 192.168.17.99;
  option broadcast-address 192.168.17.254;
  option routers 192.168.17.1;
  option domain-name-servers  8.8.8.8, 8.8.4.4, 10.51.2.18, 10.51.3.25;
}
```

We are certainly not experts here, so there may be "unecessary" settings or settings we should add. However, we'd like to explain a few of the parameters:

`authoritative;`  
This tells that the Raspberry Pi is "the one and only" DHCP server in that subnet.

`  range 192.168.17.50 192.168.17.99;`  
Here we tell the server, to use give out IP-addresses in the range from 50 - 99. In total, there can be a maximum of 49 participans with DHCP.

`  option routers 192.168.17.1;`  
This is rather important, it tells the participants where requests to the "outside" have to be sent to. In our case, **this will be the the master too**. The master node also acts as router, but this will be configured/described in [how to do port forwarding](/configure-port-forwarding)


Finally, restart the dhcp service:

```shell
sudo service isc-dhcp-server restart
```

Also, it doesn't hurt to restart the interface

```shell
sudo ifdown eth0
sudo ifup eth0
```

Check if the Pi has got the correct IP address:

```shell
ifconfig eth0
```
