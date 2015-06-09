#!/bin/bash
for i in $(ls -1 | cut -f 1 -d '.'); do
	[[ -f $i.img ]] && fastboot flash $i $i.img
done
