#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi
export SHELLOPTS


currentDir="$(dirname "$0")"

cd "$currentDir" || exit

./core/backup-grub-file.sh

./core/disable-auto-hide.sh

./core/change-font.sh

./core/remember-last-choice.sh

./core/apply-changes.sh
