#!/bin/bash

# How to execute (Install) 
# sudo bash ./install.bash install

# How to execute (Uninstall)
# sudo bash ./install.bash uninstall

## PACKAGE DIRS
DIR_NAME=$(cd $(dirname $0); pwd)
BASE_NAME=$(basename $DIR_NAME)

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


# if [ $# -ne 1 ]; then

## UNINSTALL =============================================

if [ "uninstall" = $1 ]; then
    echo "uninstall ..."
    for service_file in $INSTALL_DIR/$BASE_NAME/scripts/*.service ; do

        ## SETTING SERVICE BASE NAME
        FILE=`basename $service_file`

        ## DISPLAY UNINSTALL MESSAGE
        echo "uninstall" $FILE"..."

        ## REMOVE SERVICE
        systemctl stop $FILE
        systemctl disable $FILE
        rm $SYSTEM/$FILE

    done

    ## RELOAD SYSTEMD
    systemctl daemon-reload
    ## REMOVE FOLDERS
    rm -rf $INSTALL_DIR/$BASE_NAME

    echo "uninstalled"
    exit 0

## INSTALL =============================================

elif [ "install" = $1 ]; then
    ## COPY FILES
    cp -r $DIR_NAME/ $INSTALL_DIR/$BASE_NAME

    for service_file in $INSTALL_DIR/$BASE_NAME/scripts/*.service ; do

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

## ERROR =============================================

else
    ## ERROR MESSAGE
    echo "options failed ('sudo bash ./install.bash install' or 'sudo bash ./install.bash uninstall')"
    exit 1
fi

