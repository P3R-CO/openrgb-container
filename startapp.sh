#!/bin/sh
default=$(cat /config/default.txt)

if [ -z "$default" ]
then
	exec /usr/src/openrgb/OpenRGB
else
	exec /usr/src/openrgb/OpenRGB --server --gui --profile $default
fi
