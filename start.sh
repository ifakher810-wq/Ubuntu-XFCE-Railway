#!/bin/bash

set -e

export DISPLAY=:1
export HOME=/root

PORT="${PORT:-8080}"
VNC_PASSWORD="root"

mkdir -p /root/.vnc

echo "Starting Ubuntu XFCE..."

x11vnc -storepasswd "$VNC_PASSWORD" /root/.vnc/passwd

Xvfb :1 -screen 0 1600x900x24 &
sleep 3

dbus-run-session -- startxfce4 &
sleep 5

x11vnc \
  -display :1 \
  -rfbauth /root/.vnc/passwd \
  -forever \
  -shared \
  -localhost \
  -rfbport 5900 &

sleep 2

websockify \
  --web=/usr/share/novnc \
  0.0.0.0:$PORT \
  localhost:5900
