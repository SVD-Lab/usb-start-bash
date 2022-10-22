#!/bin/bash
# RUN as "${USER}" (e.g. ubuntu)
source /home/${USER}/.bashrc

mkdir -p /home/${USER}/mnt/
sudo mount /dev/sda1 /home/${USER}/mnt/ -o umask=000
sudo chmod -R 755 /home/${USER}/mnt/
bash /home/${USER}/mnt/usb.bash
wait
