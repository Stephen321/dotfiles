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

# https://github.com/powerline/powerline
if hash powerline-daemon 2> /dev/null; then
  powerline-daemon -q

  # different directory if on arch linux
  if hash pacman 2> /dev/null; then
    source /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh
  else
    source /usr/share/powerline/bindings/zsh/powerline.zsh
  fi
fi

# sourced before oh-my-zsh so no $ZSH_CUSTOM exists
ZSH_SETUP_DIR=~/.zsh_setup
source $ZSH_SETUP_DIR/setup_themes.zsh
source $ZSH_SETUP_DIR/setup_plugins.zsh
source $ZSH_SETUP_DIR/setup_alias.zsh

# source zsh and set theme
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

if hash trizen 2> /dev/null; then
  alias trizenRemoveOrphans="trizen -Rsun $(trizen -Qdt | awk -F ' ' '{print $1}')"
  alias trizenUpdate="trizen -Syu"
fi


# https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)" >/dev/null
fi

# https://mike.place/2017/fzf-fd/
export FZF_DEFAULT_COMMAND="fd ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d ."


HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
