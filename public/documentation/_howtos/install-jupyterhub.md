---
layout: howto
title:  "Install JupyterHub"
date:   2016-05-09 12:00:00 +0200
description: "Lets you run code via webbrowser. Attention: It's awesome!"
difficulty: medium
tags: setup master howto
order: 50
---

Here we're going to install [Jupyter](http://jupyter.org/) and [JupyterHub](https://github.com/jupyterhub/jupyterhub).  

Jupyter let's you write and execute code in a web browser. JupyterHub makes Jupyter available for groups, it's a thing you install on a server where multiple users can access Jupyter.

**Based on these two tutorials**

[https://arnesund.com/2015/09/21/spark-cluster-on-openstack-with-multi-user-jupyter-notebook/](https://arnesund.com/2015/09/21/spark-cluster-on-openstack-with-multi-user-jupyter-notebook/)  
[http://thepowerofdata.io/configuring-jupyteripython-notebook-to-work-with-pyspark-1-4-0/](http://thepowerofdata.io/configuring-jupyteripython-notebook-to-work-with-pyspark-1-4-0/)

## Install pip3 and other dependencies

Before we start, we need to have certain packages installed.

```
# pip3 package manager for python3 stuff
sudo apt-get -y install python3-pip

# other dependencies
sudo apt-get -y install python-dev python-setuptools
```


## Install JupyterHub and Jupyter Notebook

```
sudo pip3 install jupyterhub
sudo pip3 install jupyter
```

Test your installation by starting JupyterHub, like so:

```shell
sudo jupyterhub --no-ssl --port 8000
```

Next, open your browser and go to the website `http://192.168.17.1:8000` (assuming you have your [master node configured](/howtos/setup-master) with this IP address). For the login you can use the credentials for the `farmer` user (see [here](/howtos/setup-admin-group-and-users)). Alternatively, you should be able to login with any user that exists on the system.


## Make JupyterHub and Jupyter available on .raspifarm intranet

Wouldn't it be nice to have somethig like http://jupyterhub.raspifarm to access the JupyterHub on our intranet?  
We can configure that on the Apache server.

First thing, make sure you have an [Apache server installed](/howtows/install-apache) and running. Next, install 2 modules to for apache:

```shell
sudo a2enmod proxy
sudo a2enmod proxy_http
```

Now, amend the Apache configuration for the raspifarm virtual host file `/etc/apache2/sites-available/raspifarm.conf`.

Add this configuration at the bottom of the file:

```xml
<VirtualHost *:80>
  ServerName "jupyterhub.raspifarm"
  ProxyPreserveHost On
  ProxyRequests off

  ProxyPass /api/kernels/ ws://localhost:8000/api/kernels/
  ProxyPassReverse /api/kernels/ http://localhost:8000/api/kernels/

  ProxyPass / http://localhost:8000/
  ProxyPassReverse / http://localhost:8000/

  <Location ~ "/(user/[^/]*)/(api/kernels/[^/]+/channels|terminals/websocket)/?">
    ProxyPass ws://localhost:8000/
    ProxyPassReverse ws://localhost:8000/
  </Location>
</VirtualHost>
```

Re-start Apache with the new configuration.

```shell
sudo service apache2 restart
```

Finally, make sure you have JupyterHub running as indicated above (behold `--port` and `--no-ssl` option). If everything is running (Apache with the new configuration and JupyterHub on port 8000, no SSL) you should be able to see JupyterHub on `http://jupyterhub.raspifarm`.

There can be multiple reasons if it doesn' work. Here are a few points to consider while troubleshooting:

- Are you connected to the master node?
- Is the [DNS server](/howtos/setup-dns-server) running? (`sudo service dnsmasq status`)
- Is [Apache](/howtos/setup-apache) running? (`sudo service apache2 status`)
- Is JupyterHub running? (see above)
