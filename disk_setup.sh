#!/bin/bash

# Prompt for Disk Name and Mount Directory
read -p "Enter the disk name (e.g., /dev/sdb): " DISK
PARTITION="${DISK}1"  # Partition name based on the chosen disk

read -p "Enter the mount directory path (e.g., /home/yourusername/mount_directory): " MOUNT_DIR

# Function to create a new partition
create_partition() {
    echo "Creating partition on $DISK..."
    sudo fdisk $DISK <<EOF
n
p
1


w
EOF
}

# Format the partition with ext4 filesystem
format_partition() {
    echo "Formatting $PARTITION with ext4..."
    sudo mkfs.ext4 $PARTITION
}

# Create a mount directory and update /etc/fstab
mount_partition() {
    echo "Creating mount directory and mounting $PARTITION to $MOUNT_DIR..."

    # Create the mount directory
    sudo mkdir -p $MOUNT_DIR

    # Backup fstab
    sudo cp /etc/fstab /etc/fstab.bak

    # Add entry to /etc/fstab
    echo "$PARTITION    $MOUNT_DIR    ext4    defaults    0 0" | sudo tee -a /etc/fstab

    # Mount all filesystems mentioned in /etc/fstab
    sudo mount -a
}

# Confirm partition and mount
confirm_setup() {
    echo "Confirming partition setup..."
    sudo fdisk -l
    echo "Checking mounted directories..."
    df -h | grep $MOUNT_DIR
}

# Run all steps
create_partition
format_partition
mount_partition
confirm_setup

echo "Partitioning, formatting, and mounting completed."
