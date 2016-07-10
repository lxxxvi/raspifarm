# raspifarm

This repository contains scripts, configuration files and services for the raspi.farm project (Cluster with Raspberry Pi). You can find more information about the project on http://raspi.farm.

## Contents

* Configuration files for
  * dnsmasq
  * Apache (vhosts)
  * snmpd
* Ansible playbooks
* Welcome page
* Documentation as [Jekyll](https://jekyllrb.com/) Project (source for http://raspi.farm)
* Raspidog (Monitoring Tools)


## Prerequisites

[Ansible](http://raspi.farm/howtos/install-ansible/) for the Ansible stuff (Installing Master and Slaves)

## Download this repo to your master node

Login as [farmer](http://raspi.farm/howtos/setup-admin-group-and-users/), change to the home directory and clone this project:

```shell
cd ~
git clone https://github.com/lxxxvi/raspifarm.git ~/raspifarm/
```

It's important that the checked out content goes into `~/raspifarm` !


### Ansible Playbooks

#### Install master node

Login with [farmer](http://raspi.farm/howtos/setup-admin-group-and-users/) user, run the **master** playbook

```shell
ansible-playbook -i ~/raspifarm/ansible/raspifarm-inventory ~/raspifarm/ansible/playbooks/raspifarm-master-essentials.yml
```

This will install and/or configure

* RubyGems
* dnsmasq
* Apache HTTPD
* nodejs
  * npm (package manager for node.js)
  * pm2 (process manager for node.js, used for raspidog)
* Raspidog


#### Install slave nodes

Login with [farmer](http://raspi.farm/howtos/setup-admin-group-and-users/) user, run the **slaves** playbook

```shell
ansible-playbook -i ~/raspifarm/ansible/raspifarm-inventory ~/raspifarm/ansible/playbooks/raspifarm-slaves-essentials.yml
```

This will install and/or configure on all slave nodes

* SNMPD 


### Intranet

In order to use the Intranet you have to use `192.168.17.1` as your DNS-server. 

Find all webservices on http://start.raspifarm

| Service    | URL                  | Address without URL |
|------------|----------------------|---------------------|
| Startpage  | *.raspifarm          | __none__            |
| Raspidog   | dog.raspifarm        | 192.168.17.1:3002   |
| JupyterHub | jupyterhub.raspifarm | 192.168.17.1:8000   |


#### dog.raspifarm

For the monitoring tool, SNMPD has to be installed on the slaves (see "Install slave nodes" above).  
Basically, the URL `http://dog.raspifarm` should be available after installing the master-essentials with Ansible (see above). `pm2` is supposed to start the node server automatically. If the URL does not work, try the following:

```shell
cd ~/raspifarm/public/raspidog/
node ./raspidog.js
```

Then open `192.168.17.1:3002`. If this works, abort the process and check if raspidog-server is running in `pm2`:

```shell
pm2 status
```

If not, try start it with:

```shell
pm2 start ~/raspifarm/public/raspidog/raspidog.js
```


#### JupyterHub

JupyterHub has to started manually in a seperate console:

```shell
sudo jupyterhub --no-ssl --port 8000
```

After that it should be reachable at `192.168.17.1:8000` or `http://jupyterhub.raspifarm`


