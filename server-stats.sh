#!/bin/bash

echo "--------------------------"
echo "OS Version:"
if [ -f /etc/os-release ]; then
    grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
else
    uname -a
fi

echo "--------------------------"
echo "Uptime:"
uptime -p

echo "--------------------------"
echo "Logged in Users:"
who


echo "--------------------------"
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}'

echo "--------------------------"
echo "Memory Usage:"
total=$(free -m | awk '/Mem:/ {print $2}')
used=$(free -m | awk '/Mem:/ {print $3}')
free_mem=$(free -m | awk '/Mem:/ {print $4}')
percent=$(( (used * 100) / total ))

echo "Total: ${total} MB"
echo "Used: ${used} MB"
echo "Free: ${free_mem} MB"
echo "Usage: ${percent}%"

echo "--------------------------"
echo "Disk Usage:"
total=$(df -h --total | awk '/total/ {print $2}')
used=$(df -h --total | awk '/total/ {print $3}')
avail=$(df -h --total | awk '/total/ {print $4}')
percent=$(df -h --total | awk '/total/ {print $5}')

echo "Total: $total"
echo "Used: $used"
echo "Available: $avail"
echo "Usage: $percent"

echo "--------------------------"
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo "--------------------------"
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

