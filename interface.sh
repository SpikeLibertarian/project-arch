#!/bin/bash
#
#
# Essa parte do script só deve ser executada pós o primeiro restart de instalação do arch linux
# Para liberar a execução use o comando chmod +x interface.sh
# Execute como sudo para não pedir senha no pacman ou como superuser (root)
#
#
echo -e "
	1- XFCE - Ok
	2- KDE (em testes)
	3- GNOME - Ok
	4- i3wm (em testes)
	5- Cinnamon (em testes)
	6- LXQt - Ok
	7- MATE - Ok
	0- Sair\n
	"
while read -p "Digite a escolha de entrada:" interface
	do
		if [ $interface -eq 1 ]; then
			yes | pacman -Syu
			pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter firefox
			systemctl enable lightdm
            sleep2
            systemctl enable NetworkManager.service
		elif [ $interface -eq 2 ]; then
			#KDE ainda testes
            yes | pacman -Syu
			pacman -S xorg xorg-server
			pacman -S plasma sddm kde-application firefox konsole dolphin ark kwrite kcalc spectacle krunner partitionmanager packagekit-qt5
			sleep 2
			file /etc/systemd/system/display-manager.service
			pacman -S alsa-utils #bluez bluez-utils
			#systemctl enable bluetooth.service
			pacman -S openssh screen git fastfetch
			systemctl enable sshd.service
            systemctl enable sddm.service
            systemctl enable NetworkManager.service
            sleep 2
		elif [ $interface -eq 3 ]; then
			yes | pacman -Syu
			pacman -S gnome-extra gnome-terminal firefox xorg-server xorg-xinit xorg-apps mesa
			sleep 5
			pacman -S gdm 
			systemctl enable gdm.service
		elif [ $interface -eq 4 ]; then
			#i3wm em testes
            pacman -S i3 xorg xorg-xdm dmenu i3status i3lock ttf-dejavu
			sleep 5
			echo "exec i3" > ~/.xsession
			sleep 2
			chmod +x ~/.xsession
			pacman -S mate-terminal bash-completion
			sleep 2
			systemctl enable xdm.service
			sleep 2
			pacman -S polkit
			sleep 2
			echo "setxkbmap -model abnt2 -layout br -variant ,abnt2" > ~/.xsession
			sleep 2
			pacman -S firefox -S pulseaudio pavucontrol xbindkeys
			sleep 2
			echo "bindsym XF86AudioRaiseVolume exec "pactl set-sink-volume @DEFAULT_SINK@ +5%"" > ~/.config/i3/config
			sleep 2
			echo "bindsym XF86AudioLowerVolume exec "pactl set-sink-volume @DEFAULT_SINK@ -5%"" > ~/.config/i3/config
			echo "binsym XF86AudioMut exec "pactl set-sink-mute @DEFAULT_SINK@ toggle"" > ~/.config/i3/config
			sleep 2
			pacman -S xorg-xrandr arandr
			sleep 2
			echo "bindsym XF86MonBrightnessUp exec "xbacklight -inc 5"" > ~/.config/i3/config 
			sleep 2
			echo "bindsym XF86MonBrighnessDown exec "xbacklight -dec 5"" > ~/.config/i3/config
			sleep 2
			pacman -S pcmanfm
			sleep 2
			pacman -S udiskie udisks2 ntfs-3g
			sleep 2
			echo "udiskie &" > ~/.xsession
			sleep 2
			pacman -S tlp tlp-rdw
			sleep 2
			systemctl enable tlp.service
			sleep 2
			systemctl start tlp.service
			sleep 2
			systemctl enable tlp-sleep.service
			sleep 2
			systemctl start tlp-sleep.service
		elif [ $interface -eq 5 ]; then
			#Cinnamon em testes
			yes | pacman -Syu
			pacman -S xorg xorg-server
			pacman -S cinnamon nemo-fileroller firefox
			pacman -S gdm
			systemctl start gdm
			systemctl enable gdm
            sleep 2
		elif [ $interface -eq 6 ]; then
			yes | pacman -Syu
			pacman -S --needed xorg
            sleep 2 
            pacman -S --needed lxqt xdg-utils ttf-freefont sddm
            sleep 2
            pacman -S --needed libpulse libstatgrab libsysstat lm_sensors network-manager-applet oxygen-icons pavucontrol-qt
            sleep 2
            pacman -S --needed firefox vlc filezilla leafpad xscreensaver archlinux-wallpaper
            sleep 2
            systemctl enable sddm
            sleep 2
            systemctl enable NetworkManager
		elif [ $interface -eq 7 ]; then
			yes | pacman -Syu
            pacman -S xorg xorg-server
            pacman -S mate mate-extra
            pacman -S lightdm
            pacman -S lightdm-gtk-greeter
            systemctl enable lightdm
		else 
			echo "Saindo!"
            break
		fi
	done