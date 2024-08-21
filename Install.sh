pkg update && pkg upgrade
pkg install -y python
curl -o $PREFIX/bin/kolandyt https://raw.githubusercontent.com/Kolandone/Selector/main/Sel.sh
chmod +x $PREFIX/bin/kolandyt
echo "Installation complete. You can now run the script using the 'kolandyt' command."
