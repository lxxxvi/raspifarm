---
layout: howto
title:  "Install DNSmasq"
description: "DHCP and DNS in one package"
difficulty: medium
tags: setup master howto
order: 50
---

{% include ansible-icon.html %} Available in a [Ansible Playbook]({{ site.baseurl }}/howtos/use-ansible-playbooks) `raspifarm-master-essentials.yml`

---

A cluster is a network of computers. Our master node has the responsibility over the IP addresses that are assigned to the participating hosts within the network. Therefore, we're going to need an DHCP server running on the master node.

Also, we wanted to have our own "intranet" with our own local-only domain. That's why we're going  to make use of a DNS server that routes HTTP requests to an webserver (which also runs on the same host).

In this tutorial, we show how to install `dnsmasq` that provides the functionality of a DHCP server and a DNS server. 

## Installation

We'd chosen DNSmasq as DNS server that runs on our master node. Here's how to install it.

```shell
sudo apt-get install dnsmasq
```

## Configuration

Next, we have to configure the DHCP and DNS.

### DHCP 

DHCP is going to assign IP addresses to hosts that join the network without a static IP address. The IP addresses will be in the range of 50 - 99 in our subnet. The corresponding directives in the configuration file are:

* `interface=`
* `dhcp-range=`
* `dhcp-option=`
* `dhcp-authoritative`

### DNS

We also want to have our own local-only domain named ".raspifarm". This, among others, can be achieved with a DNS server. The directives for the DNS servers are:

* `domain-needed`
* `bogus-priv`
* `local=`
* `address=`
* `expand-hosts`
* `domain=`

### Summary of dnsmasq configuration file

The configuration file for dnsmasq is here: `/etc/dnsmasq.conf`. 
We ended up with this configuration:

```shell
domain-needed
bogus-priv
local=/raspifarm/
address=/raspifarm/192.168.17.1
interface=eth0
expand-hosts
domain=raspifarm
dhcp-range=192.168.17.50,192.168.17.99,12h
dhcp-option=option:router,192.168.17.1
dhcp-authoritative
```


## Restart the server

```shell
sudo service dnsmasq restart
```

## Next step

In order to interpret the requests to `http://[anything].raspifarm`, we have [installed an Apache server](/howto/install-apache) that handles the requests and routes them to corresponding applications.
