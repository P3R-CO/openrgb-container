#!/bin/bash

if [ -z "${DEFAULT_PROFILE}" ]
then
	exec /usr/src/openrgb/OpenRGB
else
	exec /usr/src/openrgb/OpenRGB --server --gui --profile "${DEFAULT_PROFILE}"
fi
