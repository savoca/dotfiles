#!/bin/bash

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -z $DISPLAY && $XDG_VTNR  -eq 1 ]] && exec startx
