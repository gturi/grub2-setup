#!/bin/bash

function get_grub_property {
  local KEY="$1"
  local GRUB_FILE=/etc/default/grub
  grep "$KEY" "$GRUB_FILE" | cut -d'=' -f2
}
