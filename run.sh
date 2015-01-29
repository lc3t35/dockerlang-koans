#!/bin/bash -ev

docker build -t lc3t35/dockerlang-koans build

# make sure the old one is gone
docker stop dockerlang-koans || true
docker rm dockerlang-koans || true

docker run \
    -t \
    -i \
    --rm \
    -p 2222:22 \
    lc3t35/dockerlang-koans \
    /bin/bash
