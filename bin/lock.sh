#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
cmustat=$(echo "$(cmus-remote -Q 2>/dev/null)" | grep -o 'status [^\$]\+' | cut -d " " -f 2- )
if [ "$cmustat" = "playing" ]; then
	cmus-remote -u
fi
i3lock -u -i /tmp/screen.png
