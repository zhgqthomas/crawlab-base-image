# Use buildx syntax
FROM --platform=$TARGETPLATFORM ubuntu:22.04 as builder

# Add platform ARG
ARG TARGETPLATFORM
ARG BUILDPLATFORM

# Combine ENV statements to reduce layers
ENV DEBIAN_FRONTEND=noninteractive \
    NODE_PATH=/usr/lib/node_modules \
    TZ=Asia/Shanghai \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    CRAWLAB_DOCKER=Y \
    GOPROXY=goproxy.io,direct

# Copy only necessary install scripts first
COPY ./install/deps/deps.sh /app/install/deps/
COPY ./install/python/requirements.txt /app/install/python/

# Install dependencies in a single RUN to reduce layers
RUN apt-get update && \
    bash /app/install/deps/deps.sh && \
    # Clean up APT cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy remaining install scripts
COPY ./install /app/install

# Install components in a single RUN to reduce layers
RUN bash /app/install/python/python.sh && \
    bash /app/install/golang/golang.sh && \
    bash /app/install/node/node.sh && \
    bash /app/install/seaweedfs/seaweedfs.sh && \
    bash /app/install/chromedriver/chromedriver.sh && \
    bash /app/install/firefox/firefox.sh && \
    bash /app/install/rod/rod.sh && \
    # Clean up unnecessary files
    rm -rf /app/install && \
    rm -rf /root/.cache && \
    rm -rf /tmp/*

WORKDIR /app/backend

# Expose ports
EXPOSE 8080 8000
