#!/bin/bash

# Function to display the system information
system_info() {
  echo "System Information"
  echo "-----------------"
  echo "Hostname: $(hostname)"
  echo "Operating System: $(uname -o)"
  echo "Kernel Version: $(uname -r)"
  echo "CPU Model: $(grep 'model name' /proc/cpuinfo | head -1 | awk -F ': ' '{print $2}')"
  echo "Total Memory: $(grep 'MemTotal' /proc/meminfo | awk -F ': ' '{print $2}')"
  echo "Uptime: $(uptime | awk -F ',' '{print $1}')"
}

# Function to display the disk usage information
disk_usage() {
  echo "Disk Usage"
  echo "----------"
  df -h
}

# Function to display the network information
network_info() {
  echo "Network Information"
  echo "-------------------"
  echo "Public IP Address: $(curl -s ifconfig.co)"
  echo "Gateway IP Address: $(ip route show default | awk '/default/ {print $3}')"
  echo "DNS Servers: $(grep 'nameserver' /etc/resolv.conf | awk '{print $2}')"
}

# Call all functions to display information
system_info
disk_usage
network_info
