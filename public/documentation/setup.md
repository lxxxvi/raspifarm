---
layout: page
title:  "Setup"
sub-title: "Installation and configuration"
icon: fa-gears
---

In the following sub chapters, we describe what software we are using for our cluster.  
Basically, there's a difference in the software stack between master node and the slave nodes. 
The slave nodes are setup quite quickly, although you'll have to do the same procedure again and again on every node. 
The installation of the master node is a bit trickier, but it should be doable if you are a little experience working on the command line.

## "The Farm"

For unknown reasons, we started to call the cluster "*the farm*". We thought, the master node is like the main building on a farm, where everything is orchestrated from. The slave nodes can be seen as sheds, where the animals (=CPUs ;-)) live in and do the work. 

There's also a *farmer*, who can access all "buildings" and knows how to keep the farm running. On the cluster, the *farmer* is a user with root privileges, that will have to be created on every node on the *farm*.

Enough farm-talking, let's get started...

---

{% include list-of-master-setup-howtos.html %}

---

{% include list-of-slave-setup-howtos.html %}
