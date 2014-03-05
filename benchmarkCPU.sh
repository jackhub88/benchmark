#!/bin/bash

echo "Simple CPU Benchmark"
time $(echo "scale=5000; a(1)*4" | bc -l &>/dev/null)
