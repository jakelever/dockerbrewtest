#!/bin/bash

set -euxo pipefail

imageName=$1

docker build -t $imageName .

