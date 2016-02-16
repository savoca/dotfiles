#!/bin/bash
PROJECT=$(basename $(pwd))
BRANCH=$(git rev-parse --abbrev-ref HEAD)
TAG=$(printf "%x" $(git rev-list HEAD --count))
FULLTAG=${PROJECT:0:2}${BRANCH:0:2}$TAG
echo ${FULLTAG^^}
