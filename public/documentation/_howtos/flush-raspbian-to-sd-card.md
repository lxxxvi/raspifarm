---
layout: howto
title:  "Flush Raspbian to SD card"
date:   2016-04-25 12:00:00 +0200
description: "Installing the operating system is really not that difficult, and exciting too!"
difficulty: medium
tags: setup master slave
order: 1
---

This document describes how to install the Raspberry Pis for the cluster.
There are two version of the operating system

* Raspbian Jessie
* Raspbian Jessie Lite

Jessie Lite is a light-weight version of Jessie, where it does not come with a GUI, so there's just the command line interface.
We are going to use Jessie for the Master-Node, and Jessie Lite for the Slave-Nodes.
The installation for both systems does not differ very much, there are just two different files that can be downloaded from the Raspberry Pi homepage.

For our cluster, we used following images:

**Jessie**  
2016-03-18-raspbian-jessie.img

**Jessie Lite**  
2016-03-18-raspbian-jessie-lite.img

## Flush the image to the card

Depending on your operating system there are different ways to flash the image to the card.
We followed the tutorial for Mac on this site:
[https://www.raspberrypi.org/documentation/installation/installing-images/]()

In a nutshell you have to do following steps

1. Download the image(s)
2. Insert an SD card (Suggested [minimal requirements](https://www.raspberrypi.org/documentation/installation/sd-cards.md): 4GB, Class 4)
3. Unmount the SD card's disk partition
4. Flash the image
5. Eject the SD card

The most thrilling part is step 4, which on the command line on OS X was this:

```shell
sudo dd bs=1m if=image.img of=/dev/rdisk<disk# from diskutil>
```

Behold `if=image.img`, this is where you specify the disk image, so choose either the image for Jessie or Jessie Lite there.
That `dd` operation will take some minutes, depending on the SD cards (writing speed) and the size of the disk image.

After that the SD card is ready to operate.

{% icon fa-linux fa-5x %}
