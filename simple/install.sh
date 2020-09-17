#!/bin/bash



# Script installing Simple ShutDownButton
# TOP Change PIN for shutdown change variable gpio_pin
#   
#

gpio_pin = 5;


BOOTCMD=/boot/cmdline.txt
CONFIG=/boot/config.txt
dtoverlay = gpio-shutdown,gpio_pin=$gpio_pin,active_low=1,gpio_pull=up

add_dtoverlay() {
    if grep -q "^dtoverlay=$1" $CONFIG; then
        echo -e "\n$1 overlay already active"
    elif grep -q "^#dtoverlay=$1" $CONFIG; then
        sudo sed -i "/^#dtoverlay=$1$/ s|#||" $CONFIG
        echo -e "\nAdding $1 overlay to $CONFIG"
        ASK_TO_REBOOT=true
    else
        echo "dtoverlay=$1" | sudo tee -a $CONFIG &> /dev/null
        echo -e "\nAdding $1 overlay to $CONFIG"
        ASK_TO_REBOOT=true
    fi
}


add_dtoverlay dtoverlay;


