#!/bin/bash

#install dependencies

#initial update and upgrade system before installing dependiencies
sudo apt update
sudo apt-get update
sudo apt upgrade -y
sudo apt-get upgrade -y


#python
sudo apt install -y python3-pip
sudo apt install -y pip
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
sudo apt install -y zsh
sudo apt install -y nmtui
sudo apt install -y blueman

#nginx install
sudo apt install -y nginx
sudo systemctl enable nginx
sudo apt install -y certbot


mkdir -p ~/.config/sway
cp ./sway ~/.config/sway/

rm -rf ~/.config/waybar
cp -r ./waybar ~/.config


# nginx setup
sudo rm -rf /etc/nginx/sites-available
sudo cp -r ./nginx /etc/nginx/sites-available
sudo systemctl reload nginx
sudo systemctl restart nginx

for file in /etc/nginx/sites-available/*; do
  ln -sf "$file" /etc/nginx/sites-enabled/$(basename "$file")
done

#setup git hub credentials
#gh auth login

# setup shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended #ohmyzsh
rm ~/.zshrc
cp ./zsh/.zshrc ./


# install and setup neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

#export to path
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.zshrc

sudo rm -rf ~/.confg/nvim
cp -r ./nvim ~/.config/
