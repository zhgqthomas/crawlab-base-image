#!/bin/bash

# Latest stable Chrome version as of March 2024
version="122.0.6261.128"

# Set architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        CHROME_ARCH="amd64"
        DRIVER_ARCH="linux64"
        ;;
    # aarch64)
    #     CHROME_ARCH="arm64"
    #     DRIVER_ARCH="linux64_arm"
    #     ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Install dependencies
apt-get install -y unzip xvfb libxi6 libgconf-2-4

# Install Chrome
wget -q "http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${version}-1_${CHROME_ARCH}.deb"
apt-get -y install "./google-chrome-stable_${version}-1_${CHROME_ARCH}.deb"
echo "Chrome version: $(google-chrome --version)"
rm -f "./google-chrome-stable_${version}-1_${CHROME_ARCH}.deb"

# Install ChromeDriver
wget "https://chromedriver.storage.googleapis.com/${version}/chromedriver_${DRIVER_ARCH}.zip"
unzip "chromedriver_${DRIVER_ARCH}.zip"
mv chromedriver /usr/local/bin/chromedriver
chown root:root /usr/local/bin/chromedriver
chmod +x /usr/local/bin/chromedriver

# Verify installation
echo "ChromeDriver version: $(chromedriver --version)"