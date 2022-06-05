#!/bin/bash

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

GRUB_FILE=/etc/default/grub

echo "creating a backup of the previous grub menu config"
sudo cp $GRUB_FILE $GRUB_FILE.bak


function get_grub_property_value {
  PROPERTY="$1"
  grep "$PROPERTY" "$GRUB_FILE" | cut -d'=' -f2
}

function get_grub_property_value {
  PROPERTY="$1"
  grep "$PROPERTY" "$GRUB_FILE" | cut -d'=' -f2
}

function remove_quoting_symbol {
  WORD="$1"
  echo "$WORD" | cut -d '"' -f 2
}

ORIGINAL_FONT_DIR="$(dirname "$(remove_quoting_symbol "$(get_grub_property_value "GRUB_FONT")")")"
echo "detected original font dir: $ORIGINAL_FONT_DIR"


echo "creating scaled version of the font"
SCALED_FONT="$ORIGINAL_FONT_DIR/$FONT_NAME$FONT_SIZE.pf2"
sudo grub2-mkfont -s "$FONT_SIZE" -o "$SCALED_FONT" "$FONT_PATH"


echo "updating grub file font"
SCALED_FONT_FOR_REGEX=$(echo "$SCALED_FONT" | sed 's/\//\\\//g' | sed 's/\./\\./g')
sudo sed -i -e "/GRUB_FONT=/ s/=.*/=\"$SCALED_FONT_FOR_REGEX\"/" $GRUB_FILE


echo "setting grub file terminal output to use gfxterm mode"
if grep -q "GRUB_TERMINAL_OUTPUT=" $GRUB_FILE
then
  sudo sed -i -e "/GRUB_TERMINAL_OUTPUT=/ s/=.*/=\"gfxterm\"/" $GRUB_FILE
else
  echo 'GRUB_TERMINAL_OUTPUT="gfxterm"' | sudo tee -a $GRUB_FILE > /dev/null
fi


sudo grub2-mkconfig -o /boot/grub2/grub.cfg
