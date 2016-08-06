---
layout: howto
title:  "Install Ansible"
date:   2016-06-18 12:00:00 +0200
description: "Orchestrate your cluster with Ansible"
difficulty: medium
tags: setup master howto
order: 50
---

![Ansible logo]({{ site.baseurl }}/assets/images/ansible-logo.png)

[Ansible](https://ansible.com/) is a configuration management tool, that enables you to control your hosts remotely and easily deploy configuration over all nodes.


## Installation

You can install Ansible through `apt-get`, but on the Raspberry Pi you'll only get version 1.7. At the time of writing, Ansible 2.2 is the latest version. However, the "manual" installation is pretty simple too...

For other ways to install Ansible on your master host, please consider reading the official documentation at
[http://docs.ansible.com/ansible/intro_installation.html](http://docs.ansible.com/ansible/intro_installation.html).

Since, we wanted to use the latest version of Ansible, this is the way we've chosen to go to install it:

```shell
cd ~
git clone git://github.com/ansible/ansible.git --recursive
source ~/ansible/hacking/env-setup
```

Before we call it done, we want to include the `env-setup` thing in our `~/.profile` file, so that we don't loose the commands when we log out and log in again.
Put this line into your '~/.profile' (or equivalent) file:

```shell
source ~/ansible/hacking/env-setup -q   # -q makes it silent
```

### Updating Ansible

In the official documentation it's mentioned, that if you want to update Ansible you should not forget to update the submodules too, like so:

```shell
git pull --rebase
git submodule update --init --recursive
```

## Configuration

Next, we are going to let Ansible know which hosts we want to manage. Ansible calls this _inventory_ and is located by default here: `/etc/ansible/hosts`. You can also create your own _inventory_ file and put it anywhere you like.

However, in both cases you will have to put something like the following into the inventory (we did it in the default file):

```shell
[raspifarm-slaves]
192.168.17.[11:18]
```

With this configuration, Ansible knows that there's a "group of hosts" named "raspifarm-slaves" and they should be reachable in the range 11-18 within the subnet 192.168.17.xx .

That was pretty simple, right?

## Test it!

In order to test Ansible, run this command:

```shell
ansible raspifarm-slaves -m ping
```

We just told Ansible to ping all hosts in the "raspifarm-slaves" group. If you have your group defined in a seperate inventory file you can let Ansible know where it is:

```shell
ansible raspifarm-slaves -i <path-to-your-inventory-file> -m ping
```

Eventually, we received this answer from the command:

```shell
192.168.17.15 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
192.168.17.13 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh.",
    "unreachable": true
}
192.168.17.14 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh.",
    "unreachable": true
}
192.168.17.11 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh.",
    "unreachable": true
}
192.168.17.12 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh.",
    "unreachable": true
}
192.168.17.17 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
192.168.17.16 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
192.168.17.18 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

Note, that we have disconnected nodes 11 to 14 to demonstrate different results.


## Next steps

So, this is just the beginning. You can do a lot more with Ansible. Learn how to automate stuff by writing so called [Playbooks]({{ site.basurl }}/howtos/use-ansible-playbooks) ...
