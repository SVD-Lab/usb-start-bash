#!/bin/bash
# RUN as "${USER}" (e.g. ubuntu)

# /usr/local/usb-mount-bash/scripts/usb-mount.bash

source /home/${USER}/.bashrc

mkdir -p /home/${USER}/mnt/

# loop (while find /dev/sda1)
while [ ! -e /dev/sda1 ]; do
    TIME=`date`
    echo "waiting for usb... (time: ${TIME})"
    sleep 2
done

sudo mount /dev/sda1 /home/${USER}/mnt/ -o umask=000
sudo chmod -R 755 /home/${USER}/mnt/

sudo bash /home/${USER}/mnt/update.bash
sudo bash /home/${USER}/mnt/usb.bash
wait
