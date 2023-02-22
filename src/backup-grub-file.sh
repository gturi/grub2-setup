#!/bin/bash

GRUB_FILE=/etc/default/grub

echo "creating a backup of the previous grub menu config"
sudo cp $GRUB_FILE $GRUB_FILE.bak
