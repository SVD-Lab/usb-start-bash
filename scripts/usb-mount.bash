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
gpio_number_umounted=21
echo "${gpio_number_umounted}" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio${gpio_number_umounted}/direction
echo "0" > /sys/class/gpio/gpio${gpio_number_umounted}/value
# ================================================================

# (mount-OK: 20) ========================================================
gpio_number_mounted=20
echo "${gpio_number_mounted}" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio${gpio_number_mounted}/direction
echo "0" > /sys/class/gpio/gpio${gpio_number_mounted}/value
# ================================================================

# loop (while find /dev/sda1)
while [ ! -e /dev/sda1 ]; do
    TIME=`date`
    echo "waiting for usb... (time: ${TIME})"
    sleep 2
done

sudo mount /dev/sda1 /home/${USER}/mnt/ -o umask=000

if [ $? -eq 0 ]; then
    echo "usb mounted"
    echo "1" > /sys/class/gpio/gpio${gpio_number_mounted}/value
    echo "0" > /sys/class/gpio/gpio${gpio_number_umounted}/value
else
    echo "usb mount failed"
    echo "0" > /sys/class/gpio/gpio${gpio_number_mounted}/value
    echo "1" > /sys/class/gpio/gpio${gpio_number_umounted}/value
fi

sudo chmod -R 755 /home/${USER}/mnt/

sudo bash /home/${USER}/mnt/update.bash
sudo bash /home/${USER}/mnt/usb.bash
wait
