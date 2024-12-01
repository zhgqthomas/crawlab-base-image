#!/bin/bash
version="124.0.1"

ARCH=$(uname -m)
case $ARCH in
    x86_64)
        FIREFOX_ARCH="x86_64"
        DRIVER_ARCH="linux64"
        ;;
    aarch64)
        FIREFOX_ARCH="aarch64"
        DRIVER_ARCH="linux-aarch64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Install dependencies
apt-get update && apt-get install -y \
    libx11-xcb1 \
    libdbus-glib-1-2 \
    libxt6 \
    libgtk-3-0 \
    unzip \
    bzip2 \
    libxtst6

# Install Firefox
wget -q "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/linux-${FIREFOX_ARCH}/en-US/firefox-${version}.tar.bz2"
tar xjf "firefox-${version}.tar.bz2" -C /opt/
ln -s /opt/firefox/firefox /usr/local/bin/firefox
rm -f "firefox-${version}.tar.bz2"

# Install Firefox Driver (geckodriver)
GECKODRIVER_VERSION="0.34.0"
wget "https://github.com/mozilla/geckodriver/releases/download/v${GECKODRIVER_VERSION}/geckodriver-v${GECKODRIVER_VERSION}-${DRIVER_ARCH}.tar.gz"
tar -xzf "geckodriver-v${GECKODRIVER_VERSION}-${DRIVER_ARCH}.tar.gz"
mv geckodriver /usr/local/bin/geckodriver
chown root:root /usr/local/bin/geckodriver
chmod +x /usr/local/bin/geckodriver
rm -f "geckodriver-v${GECKODRIVER_VERSION}-${DRIVER_ARCH}.tar.gz"

# Verify installation
echo "Firefox version: $(firefox --version)"
echo "Geckodriver version: $(geckodriver --version)"