```
sudo pacman -S yubikey-manager-qt pam-u2f
```

```
echo "auth sufficient pam_u2f.so" >> /etc/pam.d/sudo
echo "auth sufficient pam_u2f.so" >> /etc/pam.d/polkit-1
echo "auth sufficient pam_u2f.so" >> /etc/pam.d/lightdm
```

```
pamu2fcfg -o pam://hostname -i pam://hostname > ~/.config/Yubico/u2f_keys
```

```
```
