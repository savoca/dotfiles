#!/bin/bash

# For MacBookPro11,5

# Enable monitor backlight control (or use apple_set_os.efi)
# setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0

# Disable AMD GPU (has no effect when 'gpu-switch -d' is used)
echo OFF > /sys/kernel/debug/vgaswitcheroo/switch

# Disable red LED from AUX port
echo 1 > /sys/module/snd_hda_intel/parameters/power_save

# Set default brightness (remember to disable systemd-backlight services)
echo 292 > /sys/class/backlight/gmux_backlight/brightness

# Disable ACPI wakeup events
echo XHC1 > /proc/acpi/wakeup
echo LID0 > /proc/acpi/wakeup

# Boot into Linux again unless otherwise specified
efibootmgr -n 0001 # Get the right value for your grub entry first
