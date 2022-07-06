#!/bin/bash
# COPY TO USB
SCRIPT_DIR=$(cd $(dirname $0); pwd)
_USER=${SCRIPT_DIR##*home/}
USER=${_USER%%/*}

/home/$USER/Micro-XRCE-DDS-Agent-dashing/build/MicroXRCEAgent udp4 -p 2000
wait
