#!/bin/bash

# Check if youtube-dl is installed
if ! command -v youtube-dl &> /dev/null
then
    echo "youtube-dl could not be found. Please install it first."
    exit
fi

# Prompt user for the YouTube video link
read -p "Enter the YouTube video link: " video_link

# Get available formats and store them in an array
mapfile -t formats < <(youtube-dl -F "$video_link" | awk '/mp4/ {print $1 " - " $3}')

# Display available qualities
echo "Available qualities:"
for i in "${!formats[@]}"; do
    echo "$((i+1))) ${formats[i]}"
done

# Prompt user to select the quality
read -p "Choose the quality (e.g., 1 for the first option): " user_choice

# Get the format code based on user selection
format_code=$(echo "${formats[$((user_choice-1))]}" | awk '{print $1}')

# Download the video in the selected quality
youtube-dl -f "$format_code" "$video_link"
