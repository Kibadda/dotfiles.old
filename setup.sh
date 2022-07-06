#!/usr/bin/bash

while true; do
  read -p "Username: " USER
  HOME="/home/$USER"

  if [ -d $HOME ]; then
    break
  else
    echo "User $USER does not exist! Please enter a valid user!"
  fi
done

echo "========================================="
echo "Update all packages"
pacman -Syyuu --noconfirm

echo "========================================="
echo "Install pulse"
yes | sudo -u $USER install_pulse

echo "========================================="
echo "Enable AUR support"
sed -i "s/#EnableAUR/EnableAUR/" /etc/pamac.conf

echo "========================================="
echo "Install applications"
pacman -S --noconfirm dolphin exa git kitty lazygit neovim npm numlockx php playerctl ranger rofi rust telegram-desktop thunderbird unzip yarn zsh

echo "========================================="
echo "Install AUR packages"
pamac install --no-confirm google-chrome

echo "========================================="
echo "Install oh-my-zsh and powerlevel"
yes | sudo -u $USER bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo -u $USER git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

echo "========================================="
echo "change default shell"
LINE_NUMBER=$(grep -n $USER /etc/passwd | cut -f1 -d:)
sed -i "${LINE_NUMBER}s=/bin/bash=/usr/bin/zsh=" /etc/passwd

echo "========================================="
echo "Install LunarVim"
# yes | sudo -u $USER bash -c "$(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)"
which npm
which yarn
ls -la /usr/bin/npm
ls -la /usr/bin/yarn
npm config get prefix
yarn config get prefix
echo $USER
sudo -u $USER bash -c "$(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)"

echo "========================================="
echo "Remove default configs"
CONFIG="$HOME/.config"
rm -rf $CONFIG/kitty $CONFIG/lazygit $CONFIG/ranger $CONFIG/nvim $CONFIG/i3 $CONFIG/lvim $CONFIG/rofi
rm -f $HOME/.zshrc $HOME/.zshenv $HOME/.p10k.zsh $HOME/.Xresources $HOME/.profile $HOME/.bashrc $CONFIG/mimeapps.list

echo "========================================="
echo "Link all dotfile configs"
DOTFILES="$HOME/.dotfiles"
sudo -u $USER git clone https://github.com/Kibadda/dotfiles.git $DOTFILES
sudo -u $USER git -C $DOTFILES remote set-url origin git@github.com:Kibadda/dotfiles.git
sudo -u $USER bash $DOTFILES/install

echo "========================================="
echo "JetBrains Mono font"
JMTMP="/tmp/jetbrains-mono"
mkdir $JMTMP
curl -L https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip > $JMTMP/jetbrains-mono.zip
unzip $JMTMP/jetbrains-mono.zip -d $JMTMP
mv $JMTMP/fonts /usr/share/fonts/jetbrains-mono

echo "========================================="
echo "Yubikey stuff"
KEYID="0x3B6861376B6D3D78"
pacman -S --noconfirm yubikey-manager-qt yubikey-personalization-gui yubioath-desktop pam-u2f
sudo -u $USER gpg --recv $KEYID
echo -e "5\ny\n" | sudo -u $USER gpg --command-fd 0 --edit-key $KEYID trust
sudo -u $USER git config --global user.signingkey $KEYID
sudo -u $USER git config --global commit.gpgsign true
mkdir ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys
PAM_LINE="auth sufficient pam_u2f.so"
sed -i "1 a$PAM_LINE" /etc/pam.d/sudo
sed -i "1 a$PAM_LINE" /etc/pam.d/polkit-1
sed -i "1 a$PAM_LINE" /etc/pam.d/lightdm
sed -i "1 a$PAM_LINE" /etc/pam.d/i3lock

echo "========================================="
echo "Install additional packages"
while true; do
  read -p "Do you want to install ckb-next? " yn
  case $yn in
    [Yy]* ) pamac install --no-confirm ckb-next; systemctl enable ckb-next-daemon; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

while true; do
  read -p "Do you want to install disord? " yn
  case $yn in
    [Yy]* ) pacman -S --noconfirm discord; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

while true; do
  read -p "Do you want to install custom boot screen? " yn
  case $yn in
    [Yy]* ) pacman -S --noconfirm bootsplash-systemd bootsplash-manager bootsplash-theme-manjaro-glitch; sudo bootsplash-manager --set "manjaro-glitch"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo "========================================="
echo "Rebooting"
# shutdown -r now
