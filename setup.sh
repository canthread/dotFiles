#!/bin/bash

#install dependencies

#initial update and upgrade system before installing dependiencies
sudo apt update
sudo apt upgrade -y


#python
sudo apt install -y python3-pip
sudo apt install -y python3-venv

#git and verison control
sudo apt install -y git
sudo apt install -y gh

#terminal desktop enviornament and tools
sudo apt install -y sway
sudo apt install -y waybar
sudo apt install -y bemenu
sudo apt install -y ranger
sudo apt install -y openssh-server
sudo apt install -y swaylock

#nice apps to have to get started
sudo apt install -y firefox-esr
sudo apt install -y terminator
sudo apt install -y curl
sudo apt install  zsh
sudo apt install -y network-manager
sudo apt install -y blueman

#nginx install
sudo apt install -y nginx
sudo systemctl enable nginx
sudo apt install -y certbot


mkdir -p ~/.config/sway
rm ~/.config/sway/config
cp -r ./sway/sway/config ~/.config/sway/

mkdir -p ~/.config/swaylock/
cp -r ./sway/swaylock/config ~/.config/swaylock/

rm -rf ~/.config/waybar
cp -r ./waybar ~/.config


# nginx setup
sudo rm -rf /etc/nginx/sites-available
sudo cp -r ./nginx /etc/nginx/sites-available
sudo systemctl reload nginx
sudo systemctl restart nginx

for file in /etc/nginx/sites-available/*; do
  sudo ln -sf "$file" /etc/nginx/sites-enabled/$(basename "$file")
done

#setup git hub credentials
#gh auth login
# setup shell
echo 'alias nv="nvim"
alias aptinst="sudo apt-get install"
alias updt="sudo apt update && sudo apt-get update"
alias updg="sudo apt-get upgrade && sudo apt upgrade"
' >> ~/.zshrc

#ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# install and setup neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

#install packer package manager for neovim 
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

sudo rm -rf ~/.config/nvim
cp -r ./nvim ~/.config/


#install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
brew install hello

sudo apt-get install build-essential procps curl file git
