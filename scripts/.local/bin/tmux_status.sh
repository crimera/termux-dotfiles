#!/bin/bash

# Get CPU temperature
cpu_temp=$($HOME/.local/bin/cpu_temp)

# Check if running on macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    # On macOS, include swap usage
    swap_usage=$(sysctl vm.swapusage | awk '{print $4}')
    echo "${cpu_temp} ${swap_usage}"
else
    # On other systems, just show CPU temp
    echo "${cpu_temp}"
fi
