#!/usr/bin/env bash

ID=$(cloudflared tunnel info mb02 | grep -E --only-matching -e "\b(([0-9a-f]+\-)+[0-9a-f]+)\b" --line-buffered | head -1)
echo "$ID"