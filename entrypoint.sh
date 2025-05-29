#!/bin/bash

git clone https://github.com/WaitForSummer/HW08.git /app/src

mkdir -p /app/src/build
cd /app/src/build
cmake ..
make

./demo > /output/log.txt 2>&1