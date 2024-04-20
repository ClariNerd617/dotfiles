#! /usr/bin/bash

# Install neovim latest version on Linux
# To do this we get the latest version from the github api and download the tar.gz file
#
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

echo "export PATH=$PATH:/opt/nvim-linux64/bin" >>~/.bashrc

# Install LazyVim and Dependencies
# LazyVim has the following dependencies:
# Neovim >= 0.9.0 (needs to be built with LuaJIT)
# Git >= 2.19.0 (for partial clones support)
# a Nerd Font (v3.0 or greater) for the icons
# a C compiler for nvim-treesitter
# for telescope.nvim:
#   live grep: ripgrep
#   find files: fd
# a terminal that supports true color and undercurl, such as wezterm, alacritty, or kitty

# Install the Nerd Font
# I personally prefer using the DaddyTime Mono Nerd Font
# First we get the latest release of nerd fonts
download_url = $(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep "browser_download_url.*DaddyTimeMono.zip" | cut -d : -f 2,3 | tr -d \")
curl -LO $download_url
unzip DaddyTimeMono.zip
mv DaddyTimeMono.ttf ~/.local/share/fonts
fc-cache -f -v

# The next dependencies can be installed with your package manager, be it dnf, apt, or pacman

# We can install all of them here, detecting the linux you are using of course
#
if [ -f /etc/debian_version ]; then
	sudo apt install -y git ripgrep fd-find gcc
elif [ -f /etc/redhat-release ]; then
	sudo dnf install -y git ripgrep fd-find gcc
elif [ -f /etc/arch-release ]; then
	sudo pacman -S --noconfirm git ripgrep fd gcc
fi

# Thankfully getting LazyVim setup is easy, as the dotfiles repo in which this script lives
# also has the entire .config/nvim folder, so I can just copy it over and get started immediately!

# TODO Add my .config/nvim folder to the dotfiles repo

cp -r ../.config/nvim ~/.config/nvim

# To install the plugins all you need to do is open neovim using nvim and run :LazyHealth
# This will load all plugins and check if everything is working correctly.

# Happy Coding!
