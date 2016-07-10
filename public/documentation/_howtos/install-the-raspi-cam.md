# Install the Raspi Cam

## Connect the camera

https://www.raspberrypi.org/documentation/usage/camera/README.md

In a nutshell:

Connect the camera, then

```shell
sudo raspi-config   
```
... select "Enable camera", then hit Enter.
Because we're operating with the [farmer](/howtos/setup-admin-group-and-user) user, we'll have to add `farmer` to a group named `video`. Do this:

```shell
sudo usermod -a -G video farmer
```

Then restart the Pi. 


## Test the camera

With the camera connected, enabled and the right privileges (all above), you should be able to run this:

```shell
raspistill -o ~/cam.jpg
```

(it can take several seconds)

After you should see an image (or at least an image file) in your home directory named "cam.jpg".


## Install the python library to control the camera

```shell
sudo apt-get update
sudo apt-get install python-picamera
```

### Install the scikit-image library



```shell
pip3 install -U scikit-image
```







