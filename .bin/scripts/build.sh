#!/bin/bash
# Compiles linux and create proper dt.img
# Pass paths to toolchain prefix and device config as parameters
# Requires dtbToolCM in $PATH

function script_exit {
	echo "$0: failed, check log above..."
	exit 1
}

# Check input and print input
USAGE="Usage: $0 [toolchain prefix] [device config] [options...]\n
	options:\n
	clean - run make clean and make mproper\n
	nomake - go straight to dtb image creation\n
	extconfig - specify an extra config to be added to final config"
[[ -z $1 || -z $2 ]] && echo -e $USAGE && exit 1

# Setup build variables
CONFIG=$2
SHORTCONFIG=$(basename $CONFIG)
export ARCH=arm
export CROSS_COMPILE=$1

# Build and/or clean
[[ $3 = *'clean'* ]] && make clean && make mrproper
[[ $3 = *'nomake'* ]] || make $SHORTCONFIG
if [[ $3 = *'extconfig'* ]]; then
	for i in "${@:4}"; do
		cat $i >> $CONFIG
	done
	make $SHORTCONFIG
	git checkout -- $CONFIG
fi
[[ $3 = *'nomake'* ]] || make -j$(cat /proc/cpuinfo | grep -c ^processor)

# Check build completion
ZIMAGE=$(find . -wholename "*/zImage")
[[ -z $ZIMAGE ]] && script_exit

# Find, detect and compile dtb image
DTB=$(find . -name "*.dtb" | head -1)
[[ -z $DTB ]] && script_exit
DTBDIR=$(dirname $DTB)
[[ -z $(strings $DTB | grep "qcom,board-id") ]] || DTBVERCMD="--force-v2"
dtbToolCM $DTBVERCMD -o dt.img -s 2048 -p scripts/dtc/ $DTBDIR/ || script_exit
exit
