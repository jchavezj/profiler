#!/bin/bash

# Get the server hostname
echo "Hostname: $(hostname)"

# Get the operating system information
echo "Operating System: $(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f 2)"

# Get the kernel version
echo "Kernel Version: $(uname -r)"

# Get the number of CPU cores
echo "Number of CPU Cores: $(nproc)"

# Get the total amount of memory
echo "Total Memory: $(free -h | grep Mem | awk '{print $2}')"

# Get the disk space usage
echo "Disk Space Usage: $(df -h)"

# Get the list of running services
echo "Running Services: $(systemctl list-units --type=service --state=running)"
