#!/bin/bash

function set_grub_property {
  local KEY="$1"
  local VALUE="$2"
  local GRUB_FILE=/etc/default/grub

  if grep -q "$KEY=" "$GRUB_FILE"
  then
    # replace every / with \/ and then . with \.
    VALUE_FOR_REGEX=$(echo "$VALUE" | sed 's/\//\\\//g' | sed 's/\./\\./g')
    sudo sed -i -e "/$KEY=/ s/=.*/=$VALUE_FOR_REGEX/" "$GRUB_FILE"
  else
    echo "$KEY=$VALUE" | sudo tee -a "$GRUB_FILE" > /dev/null
  fi
}
