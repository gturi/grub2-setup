#!/bin/bash

currentDir="$(dirname "$0")"

cd "$currentDir" || exit

./core/backup-grub-file.sh

./core/disable-auto-hide.sh

./core/change-font.sh

./core/remember-last-choice.sh

./core/apply-changes.sh
