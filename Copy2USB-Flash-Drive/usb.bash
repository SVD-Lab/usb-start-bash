#!/bin/bash

sudo pm-powersave false

HOME_DIR=$HOME
FILE_DIR=$(cd $(dirname $0); pwd)

cp $HOME_DIR/mnt/99-manual.yaml /etc/netplan/
netplan apply

source $HOME_DIR/at2-ws/setup.bash foxy
for i in *.launch.py; do
    [ -f "$i" ] | ros2 launch $i &
done

MicroXRCEAgent udp -p 2000
# MicroXRCEAgent udp -p 2001
# MicroXRCEAgent udp -p 2002
# MicroXRCEAgent udp -p 2003

wait
