#!/bin/bash
wget http://savoca.codefi.re/priv/shared/resources/51-android.rules
sudo mv 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 0644 /etc/udev/rules.d/51-android.rules
sudo udevadm trigger
