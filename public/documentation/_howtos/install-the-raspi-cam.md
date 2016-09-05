---
layout: howto
title:  "Install the Raspi Cam"
date:   2016-06-18 12:00:00 +0200
description: "Take pictures with the camera"
difficulty: easy
tags: master howto machinelearning
order: 50
---

Our idea for the machine learning project was to take a picture of a handwritten digit from the Raspberry Pi camera and let a machine learning guess the digit.
Therefore we need 2 things. A camera and software to take and process pictures.

## Camera

We used the Raspberry Pi "NoIR" camera board, that we [installed according to the instructions](https://www.raspberrypi.org/documentation/usage/camera/README.md) from the official Raspberry Pi documentation page. In a nutshell, you have to connect the camera correctly, and then...

```shell
sudo raspi-config   
```

... select "Enable camera", then hit Enter.

### Allow farmer user to use the camera

Because we're operating with the [farmer](/howtos/setup-admin-group-and-users) user, we'll have to add `farmer` to a group named `video`. 

```shell
sudo usermod -a -G video farmer
```

Then restart the Pi. 

### Test the camera

With the camera connected, enabled and the right privileges you should be able to run this:

```shell
raspistill -o ~/cam.jpg
```

(it can take several seconds)

After you should see an image (or at least an image file) in your home directory named "cam.jpg".


## Software

For the software, we're going to need two things: 

1. `python-picamera`: A library that enables us to control the camera board.  
2. `scikit-image`: A library to process the images we record. 


### Python-Picamera library

In order to take pictures we're going to use the "python-picamera" package.

```shell
sudo apt-get update
sudo apt-get install python-picamera
```

### Install the scikit-image library



```shell
sudo apt-get update
sudo apt-get install python-matplotlib python-numpy python-pil python-scipy
sudo apt-get install build-essential cython
pip3 install -U scikit-image
```







