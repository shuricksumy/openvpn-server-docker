#!/bin/bash

set -e

docker login
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -f Multi-arch.dockerfile -t shuricksumy/openvpn-server:latest . --push --no-cache
