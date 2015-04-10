#!/bin/bash
PROJECT=$(basename $(pwd))
BRANCH=$(git rev-parse --abbrev-ref HEAD)
BASEPRJ=${PROJECT^^}
BASEBRCH=${BRANCH^^}
TAG=$(printf "%x" $(git rev-list HEAD --count))
echo ${BASEPRJ:0:2}${BASEBRCH:0:2}$TAG
