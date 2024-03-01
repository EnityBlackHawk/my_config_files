#!/bin/bash

IS_ROFI=false
NAME="mp_theme"
OOMOX_PATH=~/.cache/wal/colors-oomox
IMAGE_PATH=${@: -1}

help()
{
    echo "Usage:"
    echo "makepretty [args] [image-path]"
    echo "ARGS:"
    echo "-r	Apply to rofi"
    echo "-n    Name of the theme (default: mp_theme)"
    echo "-h    Help"
}


backup_rofi()
{
	echo "[>] Backuping Rofi config"
	mv ~/.config/rofi/config.rasi ~/.config/rofi/config.rasi.backup
}

while getopts ":n:rh:" option; do
    case $option in
        n) 
            NAME=$OPTARG ;;
      	r)
	        IS_ROFI=true
	        backup_rofi ;;
        h)
            help
            exit 0
    esac
done

echo "name: $NAME"
echo "path: $OOMOX_PATH"

echo "[>] Appling Pywal"
wal -i $IMAGE_PATH

echo "[>] Generating GTK theme"
./oomox-gtk-theme/change_color.sh -o $NAME -d true -m all $OOMOX_PATH

echo "[>] Updating evironment variable"
sudo sed -i '/^GTK_THEME/g' /etc/environment
sudo bash -c "echo 'GTK_THEME=$NAME' >> /etc/environment"
sudo sed -i '/^$/d' /etc/environment

echo "[>] Updating Rofi"
cp ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/config.rasi

echo "[>] Coping colors to Waybar"
sudo cp ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-waybar.css

echo "[>] Setting on Hyprpaper"
echo "preload = $IMAGE_PATH" > ~/.config/hypr/hyprpaper.conf
echo "wallpaper = ,$IMAGE_PATH" >> ~/.config/hypr/hyprpaper.conf 
