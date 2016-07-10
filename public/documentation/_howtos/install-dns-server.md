---
layout: howto
title:  "Install a DNS server"
date:   2016-04-25 12:00:00 +0200
description: "Speed up the network traffic and have your own top-level Domain: http://whatever-you-like.raspifarm"
difficulty: medium
tags: setup master howto
order: 50
---

We wanted to have our own "intranet" with our own local-only domain. Therefore we have to make use of a DNS server that routes HTTP requests to an Apache server that runs in the same network.

## Installation

We'd chosen DNSmasq as DNS server that runs on our master node. Here's how to install it.

```shell
sudo apt-get install dnsmasq
```

## Configuration

Now we have to make some configuration on the server. We want to have our own local-only domain named ".raspifarm".  
The configuration file for the server is  `/etc/dnsmasq.conf`, we ended up with this configuration (rest is commented out)

```shell
domain-needed
bogus-priv
local=/raspifarm/
address=/raspifarm/192.168.17.1
expand-hosts
domain=raspifarm
```

In a nutshell, with this configuration all requests to [anything].raspifarm are redirected to 192.168.17.1 (to itself).

## Restart the server

```shell
sudo service dnsmasq restart
```

## Next step

In order to interpret the requests to [anything].raspifarm, we have [installed an Apache server](/howto/install-apache) that handles the requests and routes them to corresponding applications.
