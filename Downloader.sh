#!/bin/bash

# Display channel information
echo -e "\e[31mYOUTUBE: KOLANDONE\e[0m"
echo -e "\e[34mTELEGRAM: KOLANDJS\e[0m"

# Ask for storage permissions in Termux
termux-setup-storage

# Wait for the user to grant permission
sleep 5

# Define the download directory
download_directory="/storage/emulated/0/Download"

# Check if youtube-dl and ffmpeg are installed
if ! command -v youtube-dl &> /dev/null || ! command -v ffmpeg &> /dev/null
then
    echo "Please ensure both youtube-dl and ffmpeg are installed."
    exit
fi

# Prompt user for the type of link (YouTube or Telegram)
echo "Choose the type of link:"
echo "1) YouTube"
echo "2) Telegram"
read -p "Enter your choice (1 or 2): " link_type

if [ "$link_type" -eq 1 ]; then
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

    # Download the video in the selected quality to the specified directory
    youtube-dl -f "$format_code" -o "$download_directory/%(title)s.%(ext)s" "$video_link"

    # Wait for the download to complete
    wait

    # Check if the downloaded file is a video that needs merging of audio and video
    if youtube-dl -F "$video_link" | grep -q 'audio only'; then
        # Extract the title for use in the ffmpeg command
        video_title=$(youtube-dl --get-filename -o "%(title)s" "$video_link")

        # Path to the downloaded video
        input_path="$download_directory/$video_title.mp4"

        # Use ffmpeg to merge audio and video into a single file
        ffmpeg -i "$input_path" -c copy -strict experimental "$input_path".new && mv "$input_path".new "$input_path"
    fi

    echo "Download completed! Check your Downloads folder."

elif [ "$link_type" -eq 2 ]; then
    # Prompt user for the Telegram file link
    read -p "Enter the Telegram file link: " telegram_link

    # Download the file from Telegram
    youtube-dl -o "$download_directory/%(title)s.%(ext)s" "$telegram_link"

    echo "Download completed! Check your Downloads folder."
else
    echo "Invalid choice. Please run the script again and choose a valid option."
    exit
fi
