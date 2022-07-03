#!/usr/bin/bash

while true; do
  read -p "Username: " USER
  HOME="/home/$USER"
  
  if [ -d $HOME ]; then
    break
  else
    echo "Not a real User!"
  fi
done

echo "========================================="
echo "Update all packages"
pacman -Syyuu --noconfirm

echo "========================================="
echo "Install pulse"
yes | install_pulse

echo "========================================="
echo "Enable AUR support"
sed -i "s/#EnableAUR/EnableAUR/" /etc/pamac.conf

echo "========================================="
echo "Install applications"
pacman -S --noconfirm git lazygit ranger kitty neovim zsh php rust exa dolphin unzip playerctl rofi npm

echo "========================================="
echo "Install AUR packages"
pamac install --no-confirm ckb-next google-chrome

echo "========================================="
echo "Install oh-my-zsh and powerlevel"
yes | sudo -u $USER bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo -u $USER git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

echo "========================================="
echo "Global git config"
sudo -u $USER git config --global user.email "mstrobel97@gmail.com"
sudo -u $USER git config --global user.name "Michael Strobel"

echo "========================================="
echo "Install LunarVim"
yes | sudo -u $USER bash -c "$(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)"

echo "========================================="
echo "Remove pre defined configs"
CONFIG="$HOME/.config"
rm -rf $CONFIG/kitty $CONFIG/lazygit $CONFIG/ranger $CONFIG/nvim $CONFIG/i3 $CONFIG/lvim $CONFIG/rofi
rm $HOME/.zshrc $HOME/.zshenv $HOME/.p10k.zsh

echo "========================================="
echo "Link all dotfile configs"
DOTFILES="$HOME/.dotfiles"
sudo -u $USER git clone https://github.com/Kibadda/dotfiles.git $DOTFILES
sudo -u $USER git -C $DOTFILES remote set-url origin git@github.com:Kibadda/dotfiles.git
bash ./install

echo "========================================="
echo "Enable ckb-next"
systemctl enable ckb-next-daemon

echo "========================================="
echo "JetBrains Mono font"
JMTMP="/tmp/jetbrains-mono"
mkdir $JMTMP
curl https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip > $JMTMP/jetbrains-mono.zip
unzip $JMTMP/jetbrains-mono.zip -d $JMTMP
mv $JMTMP/fonts /usr/share/fonts/jetbrains-mono

echo "========================================="
echo "Rebooting"
shutdown -r now
