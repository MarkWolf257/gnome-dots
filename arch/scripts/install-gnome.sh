#!/bin/bash

sudo pacman -Syu --noconfirm xorg-server gnome-shell gdm gnome-control-center gnome-shell-extensions gnome-tweaks gnome-shell-extension-caffeine gnome-shell-extension-vitals

mkdir AURs
cd AURs

aurs=("text-engine" "extension-manager" "gnome-shell-extension-blur-my-shell" "gnome-shell-extension-forge")

for aur in ${aurs[@]}
do
	git clone https://aur.archlinux.org/$aur.git
	cd $aur
	makepkg --noconfirm -si
	cd ..
done

cd ..

extensions=("blur-my-shell@aunetx" "caffeine@patapon.info" "Vitals@CoreCoding.com" "forge@jmmaranan.com") 

for extension in ${extensions[@]}
do
	gnome-extensions enable $extension
done

echo "Which terminal emulator do you want? (Enter package name; default alacritty)"
read ${terminal:=alacritty}
sudo pacman -S --noconfirm $terminal 

sudo systemctl enable gdm.service
reboot