#!/bin/bash 

#install dependencies

#initial update and upgrade system before installing dependiencies
sudo apt update
sudo apt-get update
sudo apt upgrade 
sudo apt-get upgrade 


#python
sudo apt install python3-pip
sudo apt install pip 
sudo apt install python3-venv 

#git and verison control 
sudo apt install git
sudo apt install gh

#terminal desktop enviornament and tools
sudo apt install sway
sudo apt install waybar
sudo apt install bemenu
sudo apt install ranger 
sudo apt install openssh-server

#nice apps to have to get started
sudo apt install firefox-esr
sudo apt install terminator
sudo apt install curl
sudo apt install zsh

#nginx install 
sudo apt install nginx 
sudo systemctl enable nginx
sudo apt install certbot 


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
gh auth login

# setup shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" #ohmyzsh
rm ~/.zshrc 
cp ./.zshrc ./


# install and setup neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

#export to path
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.zshrc

sudo rm -rf ~/.confg/nvim
cp -r ./nvim ~/.config/






