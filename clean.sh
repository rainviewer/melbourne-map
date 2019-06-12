#!/usr/bin/env bash

docker-compose down

if [ -d ./data ]; then
    rm -rf ./data
fi
