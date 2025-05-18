#!/bin/bash

set -o errexit

echo "applying changes"

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

echo "changes applied successfully"
