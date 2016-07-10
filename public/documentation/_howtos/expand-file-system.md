---
layout: howto
title:  "Expand the filesystem"
date:   2016-04-25 12:00:00 +0200
description: "The Raspbian image is delivered as a minimal image, in order to use the full size of your SD card, you need to expand the filesystem"
tags: setup master slave howto
difficulty: easy
order: 2
---

Raspbian is delivered with a limited partition size for the operating system. In order to use the full size of the SD card, it's required to expand the filesystem. So, log into your Raspberry Pi console as a sudoer and type this:

```
sudo raspi-config
```

Choose "Expand Filesystem" (it'll do it immediately, no confirmation!), then "OK", in the main menu "Finish" and restart the Pi.
