#!/bin/bash
# Create builder instance
docker buildx create --name multiarch-builder --driver docker-container --use

# Build and push for multiple platforms
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t zhgqthomas/crawlab-base:latest \
  --push \
  .