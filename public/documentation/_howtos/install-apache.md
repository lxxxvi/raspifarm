---
layout: howto
title:  "Install Apache"
date:   2016-04-25 12:00:00 +0200
description: "In case you want to run websites on your Raspberry Pi"
difficulty: medium
tags: setup master howto
order: 50
---

We want to have our own little intranet with a custom, local-only domain named _.raspifarm_. So for example, if a user who is connected to the cluster's network enters "http://home.raspifarm" in a browser, the user shall see a tiny little webpage.  
Thus, we're going to install an Apache webserver on the master node.  
For the home page demo, you will have to have a DNS server running, which is configured as described [here](/howto/install-dns-server)


## Install apache webserver

```shell
sudo apt-get install apache2
```

That's already it... installation-wise.

## Prepare a directory where a "home" page is stored

The web site or application for "http://home.raspifarm" has to be somewhere in a folder, usually one puts them within here `/var/www/`. Let's do this, well name the web site `home`:

```shell
sudo mkdir -p /var/www/home
sudo chown -R farmer:admin /var/www/home/ # assuming you have the farmer user
touch /var/www/home/index.html
```

Then paste a tiny bit of HTML code into `/var/www/home/index.html`

```html
<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Welcome to the raspifarm Network</title>
  </head>

  <body>
    This is the 'home' page
  </body>
</html>
```

So, our web page is almost ready. Now we have to tell Apache where to find it.


## Configure a default page for HTTP requests in apache

In Apache you can configure multiple websites, they call this "Virtual Hosts". There's also a default "Virtual Host", which will use for our "home" page.

The configuration files for sites are stored here `/etc/apache2/sites-available/`

Modify the preconfigured default configuration `/etc/apache2/sites-available/000-default.conf`, like so:

```xml
<VirtualHost *:80>
	DocumentRoot /var/www/home
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
Note that this is a super-basic configuration, there's much more you can do with Apache, we won't go into detail here though.

However, it's time to restart Apache:

```shell
sudo service apache2 restart
```

Then, make sure you're connected to the cluster's network (you should have an IP in `192.168.17.x`) and check if Apache and the DNS do their work correctly by opening `http://home.raspifarm`.

```shell
$ curl http://home.raspifarm
<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Welcome to the raspifarm Network</title>
  </head>

  <body>
    This is the 'home' page
  </body>
</html>
```

One last thing: Since the "home" page is our default page, so apache returns it if the URL ([something].raspifarm) does not match any other configured web pages. Go and try `curl http://go-and-try-this.url.raspifarm`. Nice, right?
