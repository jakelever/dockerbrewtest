#!/bin/bash
set -ex

echo "FROM $DOCKER" > TestDockerfile
grep -v "FROM" Dockerfile >> TestDockerfile


docker build -t brewtime -f TestDockerfile
