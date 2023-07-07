#!/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

if [ -z "$1" ]; then
    echo "./install.sh <mb_id>"
    exit 1
fi

FOLDER=$(dirname "$0")
CONFIG="$FOLDER/config.yml"

cloudflared tunnel create $1
cloudflared tunnel route dns --overwrite-dns $1 $1.mosquitobusters.site

#Setup config:
ID=$(cloudflared tunnel info $1 | grep -E --only-matching -e "\b(([0-9a-f]+\-)+[0-9a-f]+)\b" --line-buffered | head -1)
echo "Tunnel ID: $ID"

cp $CONFIG /root/.cloudflared/config.yml
sed -i "s/<tunnel_id>/$ID/g" /root/.cloudflared/config.yml

#Install service:
rm -f /etc/cloudflared/config.yml
cloudflared --config /root/.cloudflared/config.yml service install
systemctl enable cloudflared
systemctl start cloudflared
echo "Done installing cloudflare service"
exit 0
