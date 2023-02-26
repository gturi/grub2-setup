# grub2-setup

Utility script to change grub2 menu default setup.

It runs a collection of scripts that will:
- disable menu autohide
- change the font
- remember last chosen entry

## Usage

```bash
./src/istall.sh

# enable debug mode when installing
TRACE=1 ./src/istall.sh
```

The script will make a backup of your default grub file before making any change. If something goes wrong you can restore the previous grub configuration by running:

```bash
./src/restore-grub-backup.sh
```

## License

[GPL-3.0](LICENSE)
