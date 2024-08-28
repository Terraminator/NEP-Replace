#!/bin/bash
NETWORK_NAME="CHANGEME"
NETWORK_PASS="CHANGEME"

sudo nmcli device disconnect wlan0 > /root/dis.log
sudo create_ap -n wlan0 $NETWORK_NAME $NETWORK_PASS > /root/ap.log
