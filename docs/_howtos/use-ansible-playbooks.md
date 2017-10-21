---
layout: howto
title:  "Use Ansible Playbooks"
date:   2016-07-31 12:00:00 +0200
description: "Execute playbooks"
difficulty: medium
tags: setup master slaves howto
order: 50
---

Once you have [Ansible installed]({{ site.baseurl }}/howtos/install-ansible), you are able to run Ansible playbooks. You can also write our own playbooks. But first things first...

## What can Ansible do?

Ansible lets you execute playbooks on remote hosts, automatically. For example, if you want to install a package with `apt` you can do so with this shell command:

```shell
ansible 192.168.17.11 -m apt -a "name=vim state=present"
```

Above command would install the `vim package on host 192.168.17.11. All Ansible needs is a user that it can logon to on the remote host.

On our cluster, we should have the [farmer user]({{ site.baseurl }}/howtos/setup-admin-group-and-users) and the corresponding [SSH keys installed on the slave nodes]({{ site.baseurl }}/howtos/install-ssh-key-on-slave). That means, that Ansible should have no issues logging into our hosts using the farmer user, and execute stuff with this user.

Next, we want to install the `vim` package on all hosts automatically.
We need to tell Ansible which hosts it should run the installation command on. This can be achieved through a so called "inventory file"

## Inventory files

An inventory file in Ansible is a simple text file, where you can list hosts and group them if you want to. In our case, we only have one group, the group of slave nodes, so all we need to write is

```shell
[raspifarm-slaves]
192.168.17.11
192.168.17.12
192.168.17.13
192.168.17.14
192.168.17.15
192.168.17.16
192.168.17.17
192.168.17.18
```

You can save this either in the default hosts-file `/etc/ansible/hosts` or anywhere you want.
Assuming you have this setting in the default hosts-file, you can make use of the group name "raspifarm-slaves" in the ansible command.

```shell
ansible raspifarm-slaves -m apt -a "name=vim state=present"

# (if you have the hosts in a seperate file)
ansible -i [/path/to/your/inventory/file] -m apt -a "name=vim state=present"
``` 

This will install `vim` on every host that the package is not present yet.
Isn't this neat? 

Let's talk about playbooks now...

## Playbooks

A playbook is a file that Ansible uses as a "recipe". It contains a list of tasks, that have to be executed on each target host. A playbook could look like `this:

```yml`
---
- hosts: raspifarm-slaves
  remote_user: farmer
  become: yes
  serial: 8
  tasks:
    - name: Install sysbench
      apt: 
        name: sysbench
        state: present

    - name: Sysbench stresstest (60s / CPU)
      command: sysbench --max-time=60 --test=cpu --cpu-max-prime=200000 --num-threads=8 run 
```

This playbook does two things: First it installs a package named `sysbench`, if it is not present yet. Secondly, it runs a "stresstest" on the host 60 seconds long using a specific `sysbench` command.  
You can read more about playbooks on the official Ansible documentation at [http://docs.ansible.com/ansible/index.html](http://docs.ansible.com/ansible/index.html). 


## Predefined Playbooks

For the Raspberry Pi Cluster we have written several Playbooks. It automates stuff regarding deplyoment and setup of the master and slave-nodes.  
That's why some how-to descriptions here are also available as part of predefined playbooks.

The predefined playbooks can be found in the raspifarm's GitHub Repository here [https://github.com/lxxxvi/raspifarm/tree/master/ansible/playbooks](https://github.com/lxxxvi/raspifarm/tree/master/ansible/playbooks).

Here, however is an overview of playbooks we have prepared with a short description. 

{:.table}
|-----------------------------------|----------------------------------------------------------------------|
| Playbook                          | Description                                                          |
|-----------------------------------|----------------------------------------------------------------------|
| `apache-spark-master.yml`         | Installs and configures Spark on the Master Node                     |
| `deploy-spark-to-slaves.yml`      | Copies the Spark folder to all Slave Nodes                           |
| `distribute-mldata-to-slaves.yml` | Copies the content of folder /home/farmer/mldata/ to all Slave Nodes |
| `raspifarm-master-essentials.yml` | Installs and configures the Master Node from scratch                 |
| `raspifarm-slaves-essentials.yml` | Installs and configures the Slave Nodes from scratch                 |
| `raspifarm-slaves-stresstest.yml` | Runs a CPU stress test on slaves                                     |
|-----------------------------------|----------------------------------------------------------------------|


