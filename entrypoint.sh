#!/bin/bash
echo "Starting the application..." > /output/log.txt
git clone https://github.com/WaitForSummer/HW08.git /app/src

mkdir -p /app/src/build
cd /app/src/build
cmake ..
make

echo "1 2 3" | ./solver_application/solver >> /output/log.txt 2>&1
