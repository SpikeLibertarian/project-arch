#!/bin/bash
#EFI install
echo -e "
	1- Criação das partiçoes - comando parted
	2- Formatação das partiçoes
	3- Montagem das partiçoes
	4- Instalaçao dos pacotes - pacstrap
	5- Arch-Chroot - instalação da segunda parte
	6- Atualizar pacotes iniciais (obrigatorio)
	7- Definir a senha do usuario root para acesso ssh
	8- sair do software\n
	"

while read -p "Digite a opção de entrada:" entrada

	do
		if [ $entrada -eq 1 ]; then
			parted --script /dev/sda \
			mklabel gpt \
			mkpart efi fat32 1MiB 512MiB \
			mkpart primary ext4 512MiB 74G \
			mkpart primary linux-swap 75GB 80GB \
			set 1 boot on
		elif [ $entrada -eq 2 ]; then
			mkfs.fat -F32 /dev/sda1 && mkfs.ext4 /dev/sda2 && mkswap /dev/sda3
		elif [ $entrada -eq 3 ]; then
			mount /dev/sda2 /mnt 
			mkdir /mnt/home  
			mkdir -p /mnt/boot/efi  
			mount /dev/sda1 /mnt/boot/efi  
			swapon /dev/sda3
		elif [ $entrada -eq 4 ]; then
			pacstrap /mnt base base-devel linux linux-firmware nano vim dhcpcd net-tools
			sleep 5
			genfstab -U -p /mnt >> /mnt/etc/fstab &&
			sleep 5
			chmod +x instalar-chroot.sh
			cp instalar-chroot.sh /mnt
		elif [ $entrada -eq 5 ]; then
			arch-chroot /mnt ./instalar-chroot.sh
		
		elif [ $entrada -eq 6 ]; then
			timedatectl set-ntp true
			sleep 5
			pacman-key --init
			sleep 5
			pacman-key --populate archlinux
			sleep 5
			pacman -Sy archlinux-keyring
		elif [ $entrada -eq 7 ]; then
			echo "Digite o usuario para definir a senha"
			read -r $senha
			passwd $senha
		else
			echo "Saindo do software";
			break
		fi
	done