#!/usr/bin/bash

# update first
pacman -Syyuu --noconfirm

# install git
pacman -S --noconfirm git

# clone dotfiles repo
# git clone git@github.com:Kibadda/dotfiles.git ${HOME}/.dotfiles
git clone https://github.com/Kibadda/dotfiles.git ${HOME}/.dotfiles

#####################
# Applications
#####################
pacman -Syyuu --noconfirm lazygit ranger kitty neovim php zsh

# zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# nvm
bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh)"

# remove all default config files
cd ${HOME}/.config
rm -rf kitty
rm -rf lazygit
rm -rf ranger
rm -rf nvim
rm -rf i3
cd ${HOME}
rm .zshrc
rm .zshenv
rm .p10k.zsh

cd ${HOME}/.dotfiles
bash ./install
