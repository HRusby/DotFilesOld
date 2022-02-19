#!/usr/bin/env bash

scriptName="Template"

echo
echo "Installing ${scriptName}"
echo

cd "${HOME}"

PKGS=(

	# ----- Classification -----
	'base-devel' 				# Basic Development Tools: gcc, make, perl etc.
	'git'					# Version Control
	'neovim',				# NeoVim Editor
	'dotnet-sdk', 				# Dotner Dev
	'aspnet-runtime', 			# Dotnet Dev
	'tree',					# Cli directory visualisation
	'tmux', 				# Terminal Multiplexer
	# NVim requirements
    	'ripgrep',  				# Grep CMD Tool for telescope
    	'fd',       				# Find Alternative for Telescope
)

for PKG in "${PKGS[@]}"; do
	echo "INSTALLING: ${PKG}"
	sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
