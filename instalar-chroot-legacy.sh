#!/bin/bash

#Legacy chroot	

echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
sleep 5
echo "Definir a senha para o usuario root:"
read -r rei
passwd -u $rei
sleep 5
echo -n "Entre com a zona do tempo:"
read -r tempo_zona

ln -sf /usr/share/zone/{$tempo_zona} /etc/localtime

echo -n "Entre com hostname:"
read -r hostname
echo "{$hostname}" >> /etc/hostname

echo -n "Entre com o usuario: "
read -r usuario

useradd -m -g users -G wheel,storage,power -s /bin/bash $usuario
sleep 5
echo "Digite o usuario para definir a senha:"
read -r senha
passwd $senha
sleep 5
yes | pacman-key --init
sleep 5
yes | pacman -Sy archlinux-keyring
sleep 5
yes | pacman -S dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog
yes | pacman -S grub
sleep 5

grub-install --target=i386-pc --recheck /dev/sda
sleep 5
grub-mkconfig -o /boot/grub/grub.cfg
sleep 5
systemctl enable dhcpcd.service
systemctl enable NetworkManager.service
