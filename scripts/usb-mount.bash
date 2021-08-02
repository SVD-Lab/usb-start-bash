#!/bin/bash
source /home/$USER/.bashrc

mkdir -p /home/$USER/mnt/
mount /dev/sda1 /home/$USER/mnt/
chmod 777 /home/$USER/mnt/
bash /home/$USER/mnt/usb.bash
wait
