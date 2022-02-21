# DotFiles
Source of DotFiles

Set up on new system:

    DotFileDirectory=".cfg"
    DotFileRepoUrl=""
    
    #Add Alias to current shell and bashrc and add location to .gitignore
    echo "alias config='/usr/bin/git --git-dir=$HOME/$DotFileDirectory/ --work-tree=$HOME'" >> $HOME/.bashrc
    alias config='/usr/bin/git --git-dir=$HOME/$DotFileDirectory/ --work-tree=$HOME'
    echo "$DotFileDirectory" >> .gitignore
    
    # Clone Remote repo to defined location
    git clone --bare $DotFileRepoUrl $HOME/$DotFileDirectory
    config checkout
    config config --local status.showUntrackedFiles no

# Installing Arch Linux on WSL
1. Set Default wsl version to 2
```pwsh
wsl --set-default-version 2
```
3. Install an up-to-date Ubuntu instance onto WSL 
```sh
sudo apt update && sudo apt upgrade
```
2. Ensure ubuntu instance is WSL 2
```sh
wsl --set-version <distro name> 2
```
3. In Docker Desktop Settings use the following
    1. General: Use the WSL 2 based Engine
    2. Resources->WSL Integration:  Enable Integration with my default WSL distro
4. Restart PC and Docker Desktop
5. Within the Ubuntu Instance run the following
```sh
docker pull archlinux
containerguid=docker create -i archlinux bash
docker container start $containerguid
docker container exec -it $containerguid /bin/bash
```
6. The above puts you in an interactive shell of the archlinux container from there:
```sh
pacman-key init # Initialise the Pacman Key
useradd -m -G wheel <username> # Adds a new user to the wheel group (for non root access and wheel group for sudo access)
passwd <username> # Set User Password
pacman -Syu # System Update
pacman -Sy sudo vim
```
7. Enable wheel group to use sudo
```sh
EDITOR=nvim visudo
# Ensure the below line is uncommented
## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL
# Save and exit with :wq then exit the archlinux container
exit
```
8. Export archlinux image from docker
```sh
docker export $containerguid > <SomePath>/archlinux.tar
```
9. Move to a Powershell terminal
```pwsh
wsl --import <NewDistroName> <DirectoryPathToStoreTheImage> <SomePath>/archlinux.tar
# For safety ensure the new distro is using wsl 2
wsl --set-version <NewDistroName> 2
```
10. In Windows Terminal Settings Update the `<NewDistroName>` CommandLine to:
```sh
wsl.exe -d <NewDistroName> -u <UserName>
```
## Ubuntu install
To get Nerdfonts installed
1. Download .zip
```sh
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip -o /mnt/c/tmp/Hack.zip
unzip /mnt/c/tmp/Hack.zip -o /mnt/c/tmp/Hack
```
1. Enter C:\tmp\Hack, Select all .ttf files and press enter to install them 


Install Neovim
```sh
sudo apt update && sudo apt upgrade
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
```

Other Packages
```sh
sudo apt install tree
sudo apt install ripgrep
sudo apt install fd
sudo apt install npm
```

Certificates:
https://github.com/microsoft/WSL/issues/3161
Go to Manage User Certificates >  Trusted Root Certification Authorities > Certificates > Open the root CA you are interesed in
> Details > Copy To File > Base64 X.509

Copy that .cer file to /usr/local/share/ca-certificates in WSL2
Run 
sudo openssl x509 -inform PEM -in xxx.cer -out xxx.crt
sudo update-ca-certificates

Verify:
ls /etc/ssl/certs | grep xxx
