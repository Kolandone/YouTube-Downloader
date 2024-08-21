pkg update && pkg upgrade
pkg install -y python
curl -o $PREFIX/bin/koland https://raw.githubusercontent.com/Kolandone/workercreator/main/kol.py


chmod +x $PREFIX/bin/kolandyt


sed -i '1i#!/usr/bin/env python' $PREFIX/bin/koland


source $PREFIX/etc/profile
echo "Installation complete. You can now run the script using the 'kolandyt' command."
