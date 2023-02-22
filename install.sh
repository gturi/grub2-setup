#!/bin/bash

currentDir="$(dirname "$0")"

cd "$currentDir" || exit

./src/backup-grub-file.sh

./src/disable-auto-hide.sh

./src/change-grub-menu-font.sh

./src/apply-changes.sh
