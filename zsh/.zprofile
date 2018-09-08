# https://superuser.com/questions/187639/zsh-not-hitting-profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
