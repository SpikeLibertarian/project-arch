#!/bin/bash
	
#EFI chroot

echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf

echo -n "Entre com a zona do tempo:"
read -r tempo_zona

ln -sf /usr/share/zone/{$tempo_zona} /etc/localtime
sleep 2
echo "Crie a senha para o usuario root:"
read -r rei
passwd  $rei

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
pacman -S dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog
systemctl enable NetworkManager.service
pacman -S grub efibootmgr
sleep 5
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
sleep 5
grub-mkconfig -o /boot/grub/grub.cfg
sleep 5
systemclt enable dhcpcd.service
