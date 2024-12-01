#!/bin/bash
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        BINARY="linux_amd64.tar.gz"
        ;;
    aarch64)
        BINARY="linux_arm64.tar.gz"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

wget "https://github.com/seaweedfs/seaweedfs/releases/download/3.80/${BINARY}" \
    && tar -zxf "${BINARY}" \
    && cp weed /usr/local/bin
