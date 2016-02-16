#!/bin/bash
# Compiles linux and create proper dt.img
# Pass paths to toolchain prefix and device config as parameters
# Requires dtbToolCM in $PATH

function script_exit {
	echo "$0: failed, check log above..."
	exit 1
}

# Check input and print input
USAGE="Usage: $0 [arch] [toolchain prefix] [device config] [options...]\n
	options:\n
	clean - run make clean and make mproper\n
	nomake - go straight to dtb image creation\n
	extconfig - specify an extra config to be added to final config"
[[ -z $1 || -z $2  || -z $3 ]] && echo -e $USAGE && exit 1

# Setup build variables
CONFIG=$3
SHORTCONFIG=$(basename $CONFIG)
export ARCH=$1
export CROSS_COMPILE=$2

# Build and/or clean
[[ $4 = *'clean'* ]] && make clean && make mrproper
[[ $4 = *'nomake'* ]] || make $SHORTCONFIG
if [[ $4 = *'extconfig'* ]]; then
	for i in "${@:5}"; do
		cat $i >> $CONFIG
	done
	make $SHORTCONFIG
	git checkout -- $CONFIG
fi
[[ $4 = *'nomake'* ]] || make -j$(cat /proc/cpuinfo | grep -c ^processor)

# Check build completion
IMAGE=$(find . -name "*Image")
[[ -z $IMAGE ]] && script_exit

# Find, detect and compile dtb image
DTB=$(find . -name "*.dtb" | head -1)
[[ -z $DTB ]] && script_exit
DTBDIR=$(dirname $DTB)
[[ -z $(strings $DTB | grep "qcom,board-id") ]] || DTBVERCMD="--force-v2"
dtbToolCM $DTBVERCMD -o dt.img -s 2048 -p scripts/dtc/ $DTBDIR/ || script_exit
exit
