export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.
DEFAULT_USER=`whoami`       # dont display user@hostname
setopt RM_STAR_WAIT         # if you do a 'rm *', Zsh will give you a sanity check!
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)


# fix shell issue 1 from here for powerline:
# http://powerline.readthedocs.io/en/master/troubleshooting.html#shell-issues
#if [ -d "$HOME/.local/bin" ]; then
#     export PATH="$HOME/.local/bin:$PATH"
#fi

export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# https://wiki.archlinux.org/index.php/Powerline#Zsh
powerline-daemon -q
source /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh

# source zsh and set theme
# https://github.com/denysdovhan/spaceship-prompt
ZSH_THEME="spaceship"
source $ZSH/oh-my-zsh.sh

#https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false

# stop ctrl q from freezing
stty -ixon
stty ixany

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# This isnt good...
# https://unix.stackexchange.com/questions/139082/zsh-set-term-screen-256color-in-tmux-but-xterm-256color-without-tmux
#[[ $TMUX = "" ]] && export TERM="xterm-256color"

# https://unix.stackexchange.com/questions/135084/double-rm-verification-in-zsh
#setopt rm_star_silent


# on arch linux you can just pacman install syntax-highlighting and autosuggestions, then just source it. Could also clone and install to ~/.oh-my-zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


alias trizenRemoveOrphans="trizen -Rsun $(trizen -Qdt | awk -F ' ' '{print $1}')"
alias trizenUpdate="trizen -Syu"


export PATH=~/bin:$PATH


# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)" >/dev/null
fi
