#!/bin/bash

currentDir="$(dirname "$0")"

cd "$currentDir" || exit

source ../utils/get-grub-property.sh
source ../utils/set-grub-property.sh


FONTS_DIR=/usr/share/fonts

echo 'Select the font family to use for grub menu:'
mapfile -t options < <(ls $FONTS_DIR)
select opt in "${options[@]}"
do
  FONT_FAMILY="$opt"
  break; 
done


echo 'Select the font style to use for grub menu:'
mapfile -t options < <(ls "$FONTS_DIR/$FONT_FAMILY")
select opt in "${options[@]}"
do
  FONT_STYLE="$opt"
  break; 
done

echo -n 'Input the font size to use for grub menu: '
read -r FONT_SIZE


FONT_NAME="${FONT_STYLE%.*}"
FONT_PATH="$FONTS_DIR/$FONT_FAMILY/$FONT_STYLE"


function remove_quoting_symbol {
  local WORD="$1"
  echo "$WORD" | cut -d '"' -f 2
}


GRUB_FONT_DIR=/boot/grub2/fonts


echo "creating scaled version of the font"

SCALED_FONT="$GRUB_FONT_DIR/$FONT_NAME-$FONT_SIZE.pf2"
sudo mkdir -p "$GRUB_FONT_DIR"
sudo grub2-mkfont -s "$FONT_SIZE" -o "$SCALED_FONT" "$FONT_PATH"


echo "updating grub file font"

# wrapping font into quotes just to be sure that there are no spaces
set_grub_property "GRUB_FONT" "\"$SCALED_FONT\""


echo "setting grub file terminal output to use gfxterm mode"

set_grub_property "GRUB_TERMINAL_OUTPUT" '"gfxterm"'
