#!/bin/bash

function set_grub_property {
  local KEY=$1
  local VALUE=$2
  local GRUB_FILE=/etc/default/grub

  if grep -q "$KEY=" $GRUB_FILE
  then
    sudo sed -i -e "/$KEY=/ s/=.*/=$VALUE/" $GRUB_FILE
  else
    echo "$KEY=$VALUE" | sudo tee -a $GRUB_FILE > /dev/null
  fi
}
