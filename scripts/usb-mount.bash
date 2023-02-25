#!/bin/bash
# RUN as "${USER}" (e.g. ubuntu)
# /usr/local/usb-mount-bash/scripts/usb-mount.bash

######## usb-mount.bash ########
## 1. create ~/mnt/
## 2. find /dev/sda1 (if not found, echo unixtime)
## 3. mount /dev/sda1 ~/mnt/
## 4. run ~/mnt/update.bash
## 5. run ~/mnt/usb.bash
## 6. wait while (5) is running
################################

source /home/${USER}/.bashrc

mkdir -p /home/${USER}/mnt/

# (mount-NG: 21) ========================================================
sudo sh -c 'GPIO_NUM=21 && echo "${GPIO_NUM}" > /sys/class/gpio/export'
sudo sh -c 'GPIO_NUM=21 && echo "out" > /sys/class/gpio/gpio${GPIO_NUM}/direction'
sudo sh -c 'GPIO_NUM=21 && echo "1" > /sys/class/gpio/gpio${GPIO_NUM}/value'
# ================================================================

# (mount-OK: 20) ========================================================
sudo sh -c 'GPIO_NUM=20 && echo "${GPIO_NUM}" > /sys/class/gpio/export'
sudo sh -c 'GPIO_NUM=20 && echo "out" > /sys/class/gpio/gpio${GPIO_NUM}/direction'
sudo sh -c 'GPIO_NUM=20 && echo "0" > /sys/class/gpio/gpio${GPIO_NUM}/value'
# ================================================================

# loop (while find /dev/sda1)
TIME=`date`
echo "waiting for usb... (time: ${TIME})"
while [ ! -e /dev/sda1 ]; do
    sleep 2
done

sudo mount /dev/sda1 /home/${USER}/mnt/ -o umask=000

if [ $? -eq 0 ]; then
    echo "usb mounted"
    sudo sh -c 'GPIO_NUM=20 && echo "1" > /sys/class/gpio/gpio${GPIO_NUM}/value'
    sudo sh -c 'GPIO_NUM=21 && echo "0" > /sys/class/gpio/gpio${GPIO_NUM}/value'
else
    echo "usb mount failed"
    sudo sh -c 'GPIO_NUM=20 && echo "0" > /sys/class/gpio/gpio${GPIO_NUM}/value'
    sudo sh -c 'GPIO_NUM=21 && echo "1" > /sys/class/gpio/gpio${GPIO_NUM}/value'
fi

sudo chmod -R 755 /home/${USER}/mnt/

sudo bash /home/${USER}/mnt/update.bash
sudo bash /home/${USER}/mnt/usb.bash
wait
