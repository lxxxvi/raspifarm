---
layout: howto
title:  "Setup an admin group and add user(s)"
date:   2016-04-25 12:00:00 +0200
description: "One user has to do it all: Farmer!"
difficulty: easy
tags: setup master slave
order: 3
---

In order to have invidual logins, we have decided to create an admin group with sudo privileges and create users for each of us and put them into the admin group.

### Create a group and grant sudo

```shell
sudo addgroup admin
```

```shell
sudo visudo
```

Add the following `%admin` line

```shell
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL
%admin  ALL=(ALL) NOPASSWD: ALL
```

This allows "admin"-users to run sudo commands without providing a password. Please remember:

> With great power comes great responsibility


### Create the "farmer" user

Note, you will have to set a password during this action

```shell
sudo adduser --ingroup admin <the-user-name>
```

We've decided to create a user called "farmer" that will be created on any node. So we did:

```shell
sudo adduser --ingroup admin farmer
```
