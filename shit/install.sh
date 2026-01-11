#!/usr/bin/env bash

mkdir -p "$HOME/.config/xfce4/"
cp "$HOME/.nixfiles/shit/helpers.rc" "$HOME/.config/xfce4/helpers.rc"
cp "$HOME/.nixfiles/shit/mimeapps.list" "$HOME/.config/mimeapps.list"

cp -r "$HOME/.nixfiles/shit/Kvantum" "$HOME/.config/Kvantum"
cp -r "$HOME/.nixfiles/shit/qt5ct" "$HOME/.config/qt5ct"
cp -r "$HOME/.nixfiles/shit/qt6ct" "$HOME/.config/qt6ct"
