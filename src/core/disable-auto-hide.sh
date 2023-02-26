#!/bin/bash

echo "disabling auto hide"

sudo grub2-editenv - unset menu_auto_hide
