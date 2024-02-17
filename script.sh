#!/bin/bash

# Function for compressing the Btrfs filesystem using the Zstd algorithm with a progress message
compress_with_zstd() {
    echo "If u want to back, press Enter"
    echo
    read -p "Enter the path to compress: " path
    if [ -n "$path" ]; then
        echo "Compression in progress, please wait..."
        sudo btrfs filesystem defragment -r -v -czstd "$path"
        echo "Compression completed successfully!"
    else
        echo "Please enter a valid path"
        main_menu
    fi
}

# Function to initiate the btrfs scrub process at the specified path
run_btrfs_scrub() {
    echo "If u want to back, press Enter"
    echo
    read -p "Enter the path for 'btrfs scrub' command: " path
    if [ -n "$path" ]; then
        sudo btrfs scrub start "$path"
        echo "Btrfs scrub initiated on $path"
    else
        echo "Please enter a valid path"
        main_menu
    fi
}

# Function to check the status of the btrfs scrub process
btrfs_scrub_status() {
    echo "Checking btrfs scrub status"
    sudo btrfs scrub status /
}

# Function to analyze disk space usage with compsize
analyze_disk_space() {
    echo "If u want to back, press Enter"
    echo
    read -p "Enter the path to analyze disk space: " path
    if [ -n "$path" ]; then
        sudo compsize "$path"
    else
        echo "Please enter a valid path"
        analyze_disk_space
    fi
}

# Function to display Btrfs file systems
display_btrfs_filesystems() {
    echo "Display partition with BTRFS filesystems:"
    echo
    df --type=btrfs -m
}

# Main menu function
main_menu() {
    while true; do
        echo "Choose an option:"
        echo "1. Compress with Zstd"
        echo "2. Run btrfs scrub (Clear)"
        echo "3. Check btrfs scrub status"
        echo "4. Analyze disk space"
        echo "5. Display partition with BTRFS filesystems"
        echo "6. Exit"

        read -p "Enter your choice: " choice
        case $choice in
            1) compress_with_zstd;;
            2) run_btrfs_scrub;;
            3) btrfs_scrub_status;;
            4) analyze_disk_space;;
            5) display_btrfs_filesystems;;
            6) exit;;
            *) echo "Invalid choice. Please select again.";;
        esac
    done
}

# Start the main menu
main_menu
