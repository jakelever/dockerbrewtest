#!/bin/bash

set -eux

imageName=$1

docker build -t $imageName .

