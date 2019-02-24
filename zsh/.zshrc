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


# on arch linux you can just pacman install syntax-highlighting and autosuggestions, then just source it without any oh-my-zsh plugin manager
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_PLUG_BASE_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
ZSH_SYNTAX_HIGHLIGHTING_PLUG_PATH="$ZSH_PLUG_BASE_PATH/zsh-syntax-highlighting"
ZSH_AUTO_SUGGESTIONS_PLUG_PATH="$ZSH_PLUG_BASE_PATH/zsh-autosuggestions"
if [[ ! -a $ZSH_SYNTAX_HIGHLIGHTING_PLUG_PATH ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HIGHLIGHTING_PLUG_PATH
fi
if [[ ! -a $ZSH_AUTO_SUGGESTIONS_PLUG_PATH ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_AUTO_SUGGESTIONS_PLUG_PATH
fi

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
