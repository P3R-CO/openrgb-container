#!/bin/sh
udevadm control --reload-rules
udevadm trigger

exec /usr/src/openrgb/OpenRGB --gui --server --server-port 6742 --profile "${DEFAULT_PROFILE}"
