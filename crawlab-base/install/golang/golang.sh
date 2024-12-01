#!/bin/bash
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        GOARCH="amd64"
        ;;
    aarch64)
        GOARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

curl -OL "https://golang.org/dl/go1.22.4.linux-${GOARCH}.tar.gz" \
    && tar -C /usr/local -xvf "go1.22.4.linux-${GOARCH}.tar.gz" \
    && ln -s /usr/local/go/bin/go /usr/local/bin/go