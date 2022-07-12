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

echo "============================================================================================"
echo "UPDATE"
pacman -Syyuu --noconfirm
echo "============================================================================================"

echo "============================================================================================"
echo "pulseaudio"
yes | sudo -u $USER install_pulse
echo "============================================================================================"

echo "============================================================================================"
echo "enable AUR support"
sed -i "s/#EnableAUR/EnableAUR/" /etc/pamac.conf
echo "============================================================================================"

echo "============================================================================================"
echo "applications"
pacman -S --noconfirm dolphin exa git kitty lazygit neovim npm numlockx php playerctl ranger rofi rust telegram-desktop thunderbird tmux unzip yarn zsh composer
pamac install --no-confirm google-chrome
echo "============================================================================================"

echo "============================================================================================"
echo "oh-my-zsh and powerlevel10k"
yes | sudo -u $USER bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo -u $USER git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
echo "============================================================================================"

echo "============================================================================================"
echo "tmux plugin manager"
sudo -u $USER $ git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
echo "============================================================================================"

echo "============================================================================================"
echo "change default shell"
LINE_NUMBER=$(grep -n $USER /etc/passwd | cut -f1 -d:)
sed -i "${LINE_NUMBER}s=/bin/bash=/usr/bin/zsh=" /etc/passwd
echo "============================================================================================"

echo "============================================================================================"
echo "LunarVim"
yes | sudo -u $USER bash -c "$(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)"
echo "============================================================================================"

echo "============================================================================================"
echo "Remove default configs"
CONFIG="$HOME/.config"
rm -rf $CONFIG/kitty $CONFIG/lazygit $CONFIG/ranger $CONFIG/nvim $CONFIG/i3 $CONFIG/lvim $CONFIG/rofi
rm -f $HOME/.zshrc $HOME/.zshenv $HOME/.p10k.zsh $HOME/.Xresources $HOME/.profile $HOME/.bashrc $CONFIG/mimeapps.list
echo "============================================================================================"

echo "============================================================================================"
echo "Link all dotfile configs"
DOTFILES="$HOME/.dotfiles"
sudo -u $USER git clone https://github.com/Kibadda/dotfiles.git $DOTFILES
sudo -u $USER git -C $DOTFILES remote set-url origin git@github.com:Kibadda/dotfiles.git
sudo -u $USER bash $DOTFILES/install
echo "============================================================================================"

echo "============================================================================================"
echo "JetBrains Mono font"
JMTMP="/tmp/jetbrains-mono"
mkdir $JMTMP
curl -L https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip > $JMTMP/jetbrains-mono.zip
unzip $JMTMP/jetbrains-mono.zip -d $JMTMP
mv $JMTMP/fonts /usr/share/fonts/jetbrains-mono
echo "============================================================================================"

echo "============================================================================================"
echo "Yubikey stuff"
pacman -S --noconfirm yubikey-manager-qt yubikey-personalization-gui yubioath-desktop pam-u2f
KEYID="0x3B6861376B6D3D78"
TOBI="0x4b7228cfe59b7380"
for KEY in $KEYID $TOBI
do
  sudo -i $USER gpg --recv $KEY
  echo -e "5\ny\n" | sudo -u $USER gpg --command-fd 0 --edit-key $KEY trust
done
sudo -u $USER git config --global user.signingkey $KEYID
sudo -u $USER git config --global commit.gpgsign true
sudo -u $USER mkdir ~/.config/Yubico
echo "Generate u2f keys: Connect Yubikey and touch it"
sudo -u $USER pamu2fcfg > ~/.config/Yubico/u2f_keys
PAM_LINE="auth sufficient pam_u2f.so"
sed -i "1 a$PAM_LINE" /etc/pam.d/sudo
sed -i "1 a$PAM_LINE" /etc/pam.d/polkit-1
sed -i "1 a$PAM_LINE" /etc/pam.d/lightdm
sed -i "1 a$PAM_LINE" /etc/pam.d/i3lock
echo "============================================================================================"

echo "============================================================================================"
echo "additional packages"
while true; do
  read -p "Do you want to install ckb-next? " yn
  case $yn in
    [Yy]* ) pamac install --no-confirm ckb-next; systemctl enable ckb-next-daemon; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
  echo "============================================================================================"
done

while true; do
  read -p "Do you want to install disord? " yn
  case $yn in
    [Yy]* ) pacman -S --noconfirm discord; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
  echo "============================================================================================"
done

while true; do
  read -p "Do you want to install custom boot screen? " yn
  case $yn in
    [Yy]* ) pacman -S --noconfirm bootsplash-systemd bootsplash-manager bootsplash-theme-manjaro-glitch; sudo bootsplash-manager --set "manjaro-glitch"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
  echo "============================================================================================"
done

while true; do
  read -p "Enable natural scrolling?" yn
  case $yn in
    [Yy]* ) sed -i "$ 1\    Option \"Natural Scrolling\" \"true\"" /etc/X11/xorg.conf.d/30-touchpad.conf; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
  echo "============================================================================================"
done

while true; do
  read -p "Do you want to install spotify? " yn
  case $yn in
    [Yy]* )
      SPOTIFY_KEY=0x5E3C45D7B312C643
      sudo -u $USER gpg --recv $SPOTIFY_KEY
      echo -e "5\ny\n" | sudo -u $USER gpg --command-fd 0 --edit-key $SPOTIFY_KEY trust
      pamac install --no-confirm spotify
      break
      ;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
  echo "============================================================================================"
done

echo "============================================================================================"
echo "============================================================================================"
echo "============================================================================================"
echo "============================================================================================"
echo "User Actions"
echo "i3:   To reload the config, either run \"Meta+Shift+r\" or reboot the computer"
echo "lvim: To use LunarVim open lvim and type \":PackerCompile<Enter>:PackerInstall<Enter>:q<Enter>\""
echo "nvim: To use Neovim open nvim and answer both questions with \"y\", then start neovim again and type \"p\", after that you should reopen nvim"
echo "============================================================================================"
echo "============================================================================================"
echo "============================================================================================"
echo "============================================================================================"

echo "============================================================================================"
echo "Rebooting"
while true; do
  read -p "Do you want to reboot now? " yn
  case $yn in
    [Yy]* ) shutdown -r now; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
  echo "============================================================================================"
done
