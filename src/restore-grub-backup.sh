#!/bin/bash

currentDir="$(dirname "$0")"

cd "$currentDir" || exit

sudo rm /boot/grub2/grub
sudo mv /etc/default/grub.bak /etc/default/grub
./core/apply-changes.sh
