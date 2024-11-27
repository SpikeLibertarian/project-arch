#!/bin/bash
#legacy menu
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
			mklabel msdos \
			mkpart primary ext4 1MiB 74G \
			mkpart primary linux-swap 75GB 80GB \
			set 1 boot on
		elif [ $entrada -eq 2 ]; then
			mkfs.ext4 /dev/sda1 && mkswap /dev/sda2
		elif [ $entrada -eq 3 ]; then
			mount /dev/sda1 /mnt 
			mkdir /mnt/home  
			mkdir -p /mnt/boot/  
			mount /dev/sda1 /mnt/boot/  
			swapon /dev/sda2
		elif [ $entrada -eq 4 ]; then
			pacstrap /mnt base base-devel linux linux-firmware nano vim dhcpcd net-tools
			sleep 5
			genfstab -U -p /mnt >> /mnt/etc/fstab
			sleep 5
			chmod +x instalar-chroot-legacy.sh
			cp instalar-chroot-legacy.sh /mnt
		elif [ $entrada -eq 5 ]; then
			arch-chroot /mnt ./instalar-chroot-legacy.sh
		
		elif [ $entrada -eq 6 ]; then
			timedatectl
			sleep 5
			pacman-key --init
			sleep 5
			pacman-key --populate archlinux
			sleep 5
			yes | pacman -Sy archlinux-keyring
		elif [ $entrada -eq 7 ]; then
			echo "Digite o usuario para definir a senha"
			read -r $senha
			passwd $senha
		else
			echo "Saindo do software";
			break
		fi
	done