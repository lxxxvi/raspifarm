---
layout: howto
title:  "Configure WiFi"
date:   2016-04-25 12:00:00 +0200
description: "Embed your Raspberry Pi into a wireless network"
tags: setup master howto
difficulty: easy
order: 50
---


This only applies if you use Raspberry Pi 3 or you have installed a Wifi dongle.
We used the officeial manual for WiFi configuration:

[https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md]()

The magic happens in the file `/etc/wpa_supplicant/wpa_supplicant.conf`, where you have to paste something like this:

```shell
network={
    ssid="your wifi network name"
    psk="your wifi network password"
}
```

Don't forget to restart the wireless interface, assuming you use `wlan0`:

```shell
sudo ifdown wlan0
sudo ifup wlan0
```

Verify the WiFi connection with `ifonfig wlan0`, you should see an IP address assigned.
