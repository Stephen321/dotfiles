PLUGIN_BASE_PATH="$ZSH/custom/plugins"

#----------------------
# Syntax highlighting
SYNTAX_HIGHLIGHTING_PATH="$PLUGIN_BASE_PATH/zsh-syntax-highlighting"
if [[ ! -a $SYNTAX_HIGHLIGHTING_PATH ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SYNTAX_HIGHLIGHTING_PATH
fi
#----------------------
# Auto suggestions
AUTO_SUGGESTIONS_PATH="$PLUGIN_BASE_PATH/zsh-autosuggestions"
if [[ ! -a $AUTO_SUGGESTIONS_PATH ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $AUTO_SUGGESTIONS_PATH
fi
#----------------------
