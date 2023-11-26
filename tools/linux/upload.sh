#!/bin/bash

# given filename
filename=$1

# given mount path
mount_path=$2

# Define the regex pattern
pattern="sd[a-z]1"

# Search for devices in /dev folder that match the pattern
device=$(ls /dev | grep -E "$pattern")

if [ -z "$device" ]; then
  echo "No matching device found."
  exit 1
fi

# Create the mount point if it doesn't exist
mkdir -p "$mount_path"

# Mount the device to the specified mount point
sudo mount "/dev/$device" "$mount_path"

if [ $? -eq 0 ]; then
  echo "Device $device successfully mounted to $mount_path."

  sudo cp "$filename" "$mount_path"
  if [ $? -eq 0 ]; then
    echo "Successfully copied $filename to $mount_path."
  else
    echo "Failed to copy $filename to $mount_path."
  fi

else
  echo "Failed to mount device $device."
fi
