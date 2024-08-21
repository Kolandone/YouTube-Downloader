pkg update && pkg upgrade
pkg install -y python
pip install youtube-dl
pkg install ffmpeg
curl -o $PREFIX/bin/kolandyt https://raw.githubusercontent.com/Kolandone/YouTube-Downloader/main/Downloadr.sh
chmod +x $PREFIX/bin/kolandyt
echo "Installation complete. You can now run the script using the 'kolandyt' command."
