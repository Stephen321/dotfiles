#!/bin/sh

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# this is likely not needed with a display manager
# https://github.com/dunst-project/dunst/issues/347
# but "https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login"
systemctl --user import-environment DISPLAY
exec i3
