---
layout: howto
title:  "Do portforwarding"
date:   2016-04-25 12:00:00 +0200
description: "In case you want to use the raspberry as a router for network traffic"
difficulty: medium
tags: howto setup master
order: 50
---

The master node in our little network has a lot of tasks. One of them is to accept all requests that were performed over the network. Even the ones that were not meant for him (assuming the node is a man). These requests have to be forwarded, using so called _iptables_ or also "Firewall" settings.

## Settings

Remember, we are connected to the master node via cable (`eth0`) and the master node itself accesses the internet via wireless (`wlan0`).  
Let's assume that we open `http://google.com` on "our" laptop.
What the 3 magic lines below do, is to make sure that "our" HTTP request, which arrives at `eth0`, is forwarded to `wlan0`. Also, it forwards the responses (in this example from Google) back to us.


```
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
```

## Enable routing

Now, we want to make the settings effective right away

```
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
```

In order, that the settings are still effective after a system restart, we have to modify `/etc/sysctl.conf`. Make sure that following line is uncommented

```
net.ipv4.ip_forward=1
```

## Persist IP table settings

Also the IP table settings have to be persisted, otherwise it'll be reset after a system restart.
Luckily there's a package that does that

```
sudo apt-get install iptables-persistent
```

It will ask you to permanently save the current IP table settings for IPv4 and IPv6. Choose Yes for both.
The settings are stored in this directory:

```
/etc/iptables/
```
