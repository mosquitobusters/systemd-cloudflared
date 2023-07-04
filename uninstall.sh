#!/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

if [ -z "$1" ]; then
    echo "./uninstall.sh <mb_id>"
    exit 1
fi

cloudflared service uninstall
cloudflared tunnel cleanup $1
cloudflared tunnel delete $1
