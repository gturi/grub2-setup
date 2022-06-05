# change-grub-menu-font

Utility script to change grub2 menu font.

Select font family, font style and font size and the script will update your default grub2 menu entry.

## Usage

```bash
./change-grub-menu-font.sh
```

The script will make a backup of your default grub file before making any change. If something goes wrong you can restore the previous grub configuration by running:

```bash
sudo rm /boot/grub2/grub
sudo mv /etc/default/grub.bak /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

## License

[GPL-3.0](LICENSE)
