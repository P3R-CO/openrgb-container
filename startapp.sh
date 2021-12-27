#!/bin/sh
exec /usr/src/openrgb/OpenRGB --gui --server --server-port "${SRV_PORT}" --profile "${DEFAULT_PROFILE}"
