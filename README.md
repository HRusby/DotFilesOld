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
