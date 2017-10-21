---
layout: page
title: Hardware
sub-title: What do I need?
icon: fa-plug
---

Our cluster consists of 9 Raspberry Pis, 8 of which are slave nodes and 1 unit is the master node.

## Order list

Here's a short version of our order list.

{:.table}
| Item                                | Quantity | 
|-------------------------------------|---------:|
| Raspberry Pi 3                      |        9 |
| Kingston microSDHC Card 16GB        |        9 |
| Edimax ES-3308P V8 (Switch)         |        2 |
| Anker 5-Port Desktop USB Charger    |        2 |
| USB Cables (short ones)             |        9 |
| Ethernet Cables (short ones)        |       10 |


## Power

It all starts with 9 Raspberry Pi 3, that all need to be powered.  
The power comes from the 9 USB cables, that are connected to Raspberry Pi on one side, and to the Anker USB charger on the other side.  


## Network

We have 10 ethernet cables. Each Raspberry Pi needs to be connected to one ethernet cable.  
We used the remaining cable to connect the two switches to build a "bridge" between the two devices.  
Otherwise not all Raspberry Pis could communicate in the cluster.  
Behold:

```
            _________          _________
[RPI]======|         |        |         |======[RPI]
[RPI]======|         |        |         |======[RPI]
[RPI]======| Switch  |========| Switch  |======[RPI]
[RPI]======|         |        |         |======[RPI]
[RPI]======|         |        |         |
            ‾‾‾‾‾‾‾‾‾          ‾‾‾‾‾‾‾‾‾
```
As you already figured out, `======` are ethernet cables. Yay, ASCII!

## Assembling / Design

May be for your disappointment, we are *not* going to describe here  we designed the and assembled our cluster. We suggest you come up with your own layout, creativity has no limits. {% icon fa-smile-o %}


## Result

Here's how one half of our cluster looks like in the end:

![Picture of the assembled cluster]({{ site.baseurl }}/assets/images/raspifarm-cluster.jpg)

