#!/bin/bash
source ~/.bashrc

mkdir -p /home/ubuntu/mnt/
mount /dev/sda1 /home/ubuntu/mnt/
chmod 777 /home/ubuntu/mnt/
bash /home/ubuntu/mnt/usb.bash
wait