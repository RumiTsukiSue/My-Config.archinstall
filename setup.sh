# archinstall安装系统



## 安装日常软件
sudo pacman -S base-devel git curl mosh \
  noto-fonts-cjk noto-fonts-emoji ttf-hack-nerd ttf-roboto \
  firefox firefoxpwa
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si
paru -S cherry-studio linuxqq wechat mubu-bin clash-verge-rev-bin \
  btop tldr tmux neofetch kmscon


## zsh
sudo pacman -S zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
paru -S autojump-git
cd ~/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting
cd ~/.oh-my-zsh/custom/themes
git clone https://github.com/romkatv/powerlevel10k
git -C "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" pull


## vim yazi vscode
sudo pacman -S gvim yazi visual-studio-code-bin
sudo pacman -S luarocks ueberzugpp fd ripgrep ffmpeg 7zip jq poppler fzf zoxide imagemagick chafa 
sudo pacman -S wl-clipboard less bat


## 系统软件
paru -S noctalia-shell \
  nwg-look nwg-displays \
  cliphist matugen cava wlsunset power-profiles-daemon \
  vicinae-bin
systemctl enable --now --user vicinae.service


## 文件管理器配置，实现u盘自动挂载，ntfs访问与smb访问
sudo pacman -S ntfs-3g exfatprogs f2fs-tools dosfstools
sudo pacman -S --needed \
    nemo cinnamon-translations nemo-fileroller \
    gvfs gvfs-smb gvfs-nfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-goa \
    udisks2 \
    avahi nss-mdns smbclient \
    gcr gnome-keyring \
    ntfs-3g


## 中文本地化
paru -S fcitx5-im fcitx5-rime rime-ice \
  fcitx5-nord-pink \
  rime-pinyin-moegirl rime-pinyin-moegirl
mkdir ~/.local/share/fcitx5/rime
vim ~/.local/share/fcitx5/rime/default.custom.yaml
#patch:
#  # 仅使用「雾凇拼音」的默认配置，配置此行即可
#  __include: rime_ice_suggestion:/
#  # 以下根据自己所需自行定义
#  __patch:
#    menu/page_size: 8   #候选词个数
cp /usr/share/rime-data/rime_ice.dict.yaml ~/.local/share/fcitx5/rime/rime_ice.dict.yaml
vim ~/.local/share/fcitx5/rime/rime_ice.dict.yaml
#import_tables:
#  ...
#  ...
#  - zhwiki
#  - moegirl


## office
sudo pacman -S libreoffice-still libreoffice-still-zh-cn


## 多媒体
paru -S imv mpv ani-cli


## N卡闪屏问题
#sudo nano /etc/default/grub
#sudo grub-mkconfig -o /boot/grub/grub.cfg
#修改 GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nvidia.NVreg_PowerMizerMode=1"


## 添加windows启动项
sudo pacman -S os-prober polkit-gnome
sudo vim /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
## grub 安全启动
paru -S shim-signed
sudo pacman -S sbsigntools mokutil
## grub 主题
paru -S grub-theme-lain
git clone https://github.com/uiriansan/LainGrubTheme.git
cd LainGrubTheme
sudo ./install.sh
sudo ./patch_entries.sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
## sddm 主题
paru -S sddm-lain-wired-theme
sudo mkdir /etc/sddm.conf.d
sudo cp -p /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf.d/theme.conf
vim /etc/sddm.conf.d/theme.conf
sudo -e /etc/sddm.conf.d/theme.conf
Current=sddm-lain-wired-theme


## chromebook声卡
git clone https://github.com/WeirdTreeThing/chromebook-linux-audio.git
cd chromebook-linux-audio
./setup-audio
sudo pacman -S pavucontrol
