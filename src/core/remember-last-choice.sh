#!/bin/bash

currentDir="$(dirname "$0")"

cd "$currentDir" || exit

source ../utils/set-grub-property.sh


echo "setting grub properties to remember last chosen entry"

set_grub_property "GRUB_DEFAULT" "saved"
set_grub_property "GRUB_SAVEDEFAULT" "true"
