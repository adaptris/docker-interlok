#!/usr/local/bin/dumb-init /bin/sh
dfuplus action=dafilesrv &
exec /interlok-entrypoint.sh
