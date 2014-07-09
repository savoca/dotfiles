#!/bin/bash
for pkg in `dpkg --list | awk '/ii/ {print $2}'`; do echo -e "`dpkg --status $pkg | grep Installed-Size | awk '{print $2}'` \t\t $pkg" >> pkgs.tmp; done; sort -rg pkgs.tmp > pkgs; cat pkgs; rm -f pkgs.tmp pkgs;
