FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    dbus-x11 \
    x11-xserver-utils \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    xterm \
    firefox \
    sudo \
    curl \
    wget \
    git \
    nano \
    htop \
    unzip \
    ca-certificates \
    fonts-liberation \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.vnc

WORKDIR /root

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
