#!/bin/bash

imageName=$1

docker build -t $imageName .

