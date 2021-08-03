#!/bin/bash
source $HOME/.bashrc

mkdir -p $HOME/mnt/
mount /dev/sda1 $HOME/mnt/
chmod 777 $HOME/mnt/
chown -R $USER:$USER $HOME/mnt/
bash $HOME/mnt/usb.bash
wait
