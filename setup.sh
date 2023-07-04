#!/usr/bin/env bash

ARCHIVE=cloudflared_2023.6.1_arm.tar.gz
DOWNLOAD_URL=https://hobin.ca/cloudflared/releases/2023.6.1/$ARCHIVE

if [ ! $(which wget) ]; then
    echo 'Please install wget package'
    exit 1
fi

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

echo "Downloading cloudflared . . ."
wget $DOWNLOAD_URL
sudo tar -xvzf $ARCHIVE
rm $ARCHIVE
cp ./cloudflared /usr/local/bin
rm ./cloudflared
chmod +x /usr/local/bin/cloudflared

echo "Done setting up cloudflared"
exit 0