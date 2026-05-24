#!/bin/bash

docker stop react-container || true
docker rm react-container || true

docker run -d \
  --name react-container \
  -p 80:80 \
  react-prod-app
