#!/bin/bash

currentDir="$(dirname "$0")"

cd "$currentDir" || exit

./core/backup-grub-file.sh

./core/disable-auto-hide.sh

./core/change-grub-menu-font.sh

./core/apply-changes.sh
