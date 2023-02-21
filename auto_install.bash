#!/bin/bash

# How to execute (Install) 
# sudo bash ./install.bash install

# How to execute (Uninstall)
# sudo bash ./install.bash uninstall

## PACKAGE DIRS
SCRIPT_DIR=$(cd $(dirname $0); pwd)
_USER=${SCRIPT_DIR##*home/}
USER=${_USER%%/*}

BASE_NAME=$(basename $SCRIPT_DIR)

## INSTALL DIRS
INSTALL_DIR='/usr/local'
BIN='/usr/local/bin'
SYSTEM='/etc/systemd/system'


## Check superuser ======================================
if [ $(id -u) -ne 0 ]; then

    ## ERROR MESSAGE
    echo "You must execute this command as a superuser."
    echo "'sudo bash ./install.bash install' or 'sudo bash ./install.bash uninstall'"
    exit 1
fi


## INSTALL =============================================
# COPY FILES
cp -r $SCRIPT_DIR/ $INSTALL_DIR/$BASE_NAME

# $INSTALL_DIR/$BASE_NAME/scripts/*.service
FILE_LIST=`ls $INSTALL_DIR/$BASE_NAME/scripts/*.service`

for service_file in $FILE_LIST ; do
    ## SETTING SERVICE BASE NAME
    FILE=`basename $service_file`

    ## DISPLAY INSTALL MESSAGE
    echo "setting "$FILE"..."

    ## SETTING SERVICE
    cp $service_file $SYSTEM/
    echo "User=$USER" >> $SYSTEM/$FILE
    systemctl enable $FILE
done

## RELOAD SYSTEMD
systemctl daemon-reload
    
echo "installed"
exit 0
