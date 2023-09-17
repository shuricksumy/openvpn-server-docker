#!/bin/bash

set -e

docker buildx create --use
docker login
docker buildx build --platform linux/amd64,linux/arm64 -f Multi-arch.dockerfile -t shuricksumy/openvpn-server:latest . --push --no-cache
