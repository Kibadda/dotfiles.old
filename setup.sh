#!/usr/bin/bash


while true; do
  read -p "Username: " USER
  HOME="/home/$USER"
  
  if [ -d $HOME ] then;
    break
  else
    echo "Not a real User!\n"
  fi
done

echo "=========================================\n"
echo "Update all packages\n"
pacman -Syyuu --noconfirm

echo "=========================================\n"
echo "Install pulse\n"
yes | install_pulse

echo "=========================================\n"
echo "Enable AUR support"
sed -i "s/#EnableAUR/EnableAUR/" /etc/pamac.conf

echo "=========================================\n"
echo "Install applications\n"
pacman -S --noconfirm git lazygit ranger kitty neovim zsh php rust exa dolphin unzip playerctl nvm rofi

echo "=========================================\n"
echo "Install AUR packages"
pamac install --no-confirm ckb-next google-chrome

echo "=========================================\n"
echo "Install oh-my-zsh and powerlevel\n"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $USER bash
sudo -u $USER git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

echo "=========================================\n"
echo "Global git config\n"
sudo -u $USER git config --global user.email "mstrobel97@gmail.com"
sudo -u $USER git config --global user.name "Michael Strobel"

echo "=========================================\n"
echo "Install LunarVim\n"
curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | sudo -u $USER bash

echo "=========================================\n"
echo "Remove pre defined configs\n"
CONFIG="$HOME/.config"
rm -rf $CONFIG/kitty $CONFIG/lazygit $CONFIG/ranger $CONFIG/nvim $CONFIG/i3 $CONFIG/lvim $CONFIG/rofi
rm $HOME/.zshrc $HOME/.zshenv $HOME/.p10k.zsh

echo "=========================================\n"
echo "Link all dotfile configs\n"
DOTFILES="$HOME/.dotfiles"
sudo -u $USER git clone https://github.com/Kibadda/dotfiles.git $DOTFILES
sudo -u $USER git -C $DOTFILES remote set-url origin git@github.com:Kibadda/dotfiles.git
bash ./install

echo "=========================================\n"
echo "Install npm and node\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sudo -u $USER bash
source $HOME/.bashrc
sudo -u $USER nvm install --lts

echo "=========================================\n"
echo "Enable ckb-next"
systemctl enable ckb-next-daemon

echo "=========================================\n"
echo "JetBrains Mono font"
JMTMP="/tmp/jetbrains-mono"
mkdir $JMTMP
curl https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip > $JMTMP/jetbrains-mono.zip
unzip $JMTMP/jetbrains-mono.zip -d $JMTMP
mv $JMTMP/fonts /usr/share/fonts/jetbrains-mono

echo "=========================================\n"
echo "Rebooting"
shutdown -r now
