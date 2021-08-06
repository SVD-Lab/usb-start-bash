#!/bin/bash
# RUN as "$USER" (e.g. ubuntu)
source /home/$USER/.bashrc

mkdir -p /home/$USER/mnt/
sudo mount /dev/sda1 /home/$USER/mnt/
sudo chmod 777 /home/$USER/mnt/
sudo bash /home/$USER/mnt/usb.bash
wait