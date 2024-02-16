#!/bin/bash

# Функция для сжатия файловой системы Btrfs с использованием алгоритма Zstd и вывода прогресса
compress_with_zstd() {
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

# Функция для анализа занятости раздела с помощью compsize
analyze_disk_space() {
    read -p "Enter the path to analyze disk space: " path
    if [ -n "$path" ]; then
        sudo compsize "$path"
    else
        echo "Please enter a valid path"
        main_menu
    fi
}

# Главное меню
main_menu() {
    while true; do
        echo "Choose an option:"
        echo "1. Compress with Zstd"
        echo "2. Analyze disk usage space"
        echo "3. Exit"

        read -p "Enter your choice: " choice
        case $choice in
            1) compress_with_zstd;;
            2) analyze_disk_usage_space;;
            3) exit;;
            *) echo "Invalid choice. Please select again.";;
        esac
    done
}

# Запуск главного меню
main_menu
