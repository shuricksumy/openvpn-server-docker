#!/bin/bash

set -e

docker buildx build --platform linux/amd64 -f Dockerfile -t shuricksumy/openvpn-server . --no-cache  --push --no-cache
