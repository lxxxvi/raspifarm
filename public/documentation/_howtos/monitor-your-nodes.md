---
layout: howto
title:  "Monitor your nodes"
description: "See what your nodes are doing"
tags: master howto
difficulty: medium
order: 50
---

Sometimes you want to see how your nodes in your cluster are doing. 
We made therefore a tiny web application that displays the CPU and memory usage of all nodes.

![Raspidog overview]({{ site.baseurl }}/assets/images/raspidog-overview.png)

You can either install raspidog on your own, or install it via Ansible (see bottom of the page)... the choice is yours.

## Manual installation

### Things we need 

Raspidog requries several things to be installed

* Node.js
* pm2
* raspidog

Also it requires [Apache](/howtos/install-apache) to be installed and running. We need to configure raspidog too. 

#### Node.js

Node.js is a server-side JavaScript environment, we need it to run the raspidog server.

```shell
sudo apt-get install nodejs
```

#### pm2

pm2 is a process manager for Node applications. With pm2 you can start and stop Node webapplications in the background.

```shell
npm install -g pm2
```

#### raspidog

"raspidog", the monitoring tool for the cluster, is available on the ["raspifarm" repository](https://github.com/lxxxvi/raspifarm) on GitHub. 
Clone the repository into the farmers home directory, if it's not there already.

```shell
## make sure you are logged in as the farmer user
clone https://github.com/lxxxvi/raspifarm.git ~/raspifarm
```

After that, you have to install the dependent packages for raspidog, it's as easy as

```shell
npm install -g /home/farmer/raspifarm/public/raspidog/
```

That's it for the installation part.

### Configuration and start the application


#### Configure Apache

Apache has to know where to route requests for "http://dog.raspifarm" to. Add a new virtual host to `/etc/apache2/sites-available/raspifarm.conf`:

```shell
# raspidog
<VirtualHost *:80>
  ServerName "dog.raspifarm"
  ServerAlias "raspidog.raspifarm"
  ServerAdmin webmaster@localhost

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined

  ProxyPass / http://localhost:3002/
</VirtualHost>
```

#### Start the server

Now, we should be able to start the server via pm2

```shell
pm2 start /home/farmer/raspifarm/public/raspidog/raspidog.js
```

If you have to restart it, do

```shell
pm2 restart raspidog
```

#### Test it

Now you should be able to see the monitoring tool at this URL:

```shell
http://dog.raspifarm
```

Alternatively, you should see it here:

```shell
http://192.168.17.1:3002
```


## Installation via Ansible

Instead of doing all the fancy stuff above by your own, you could have [Ansible](/howtos/install-ansible) install the entire thing for you.  
Simply install Ansible according the instructions, and execute the `raspifarm-master-essentials.yml` playbook from the "raspifarm" Repository, like so:

```shell
cd ~/raspifarm/ansible
ansible-playbook -i ./raspifarm-inventory ./playbooks/raspifarm-master-essentials.yml
```

