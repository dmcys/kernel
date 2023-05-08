#!/bin/bash

# Remove all logs from the system
sudo rm -rf /var/log/*

# Clean temporary files
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Clean package cache and other unnecessary files
sudo apt-get autoclean -y
sudo apt-get autoremove -y

# Free up disk space by removing unnecessary packages
sudo apt-get clean -y

# Vacuum all logs to free up space
sudo journalctl --vacuum-size=1G

# Print disk space usage before and after cleanup
echo "Disk space usage before cleanup:"
df -h

# Clean up unused disk space
sudo fstrim -v /

# Print disk space usage after cleanup
echo "Disk space usage after cleanup:"
df -h

echo "Clean up complete!"
