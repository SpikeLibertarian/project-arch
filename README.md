<h1> Instalador do Arch Linux</h1>

<h2> Esse instalador foi criado para adiantar o processo de instalação da distribuição pura do arch linux</h2>

<p>
  Primeiro deve verificar a bios do seu computador para poder utilizar o script correto, 
  caso seja UEFI usar o EFI-install.sh junto com o ``instalador-chroot.sh`` ,
  o modo de instalação bios legacy está configurado no arquivo legacy-install.sh junto ao segundo script ``instalar-chroot-legacy.sh ``
</p> 

<h3> Menu de instalação </h3>

<p> 1- Criação das partiçoes - comando parted
	2- Formatação das partiçoes
	3- Montagem das partiçoes
	4- Instalaçao dos pacotes - pacstrap
	5- Arch-Chroot - instalação da segunda parte
	6- Atualizar pacotes iniciais (obrigatorio) de inicio para pacstrap funcionar corretamente.
	7- Definir a senha do usuario root para acesso ssh
	8- sair do software</p>

<h3> Partições </h3>

<p> A primeira parte deve ser mudada para o tamanho do disco usado. Por exemplo: 240GB 

  ``  parted --script /dev/sda \
			mklabel gpt \
			mkpart efi fat32 1MiB 512MiB \
			mkpart primary ext4 512MiB 236GB \
			mkpart primary linux-swap 237GB 240GB \
			set 1 boot on  
``
</p>