THEME_BASE_PATH="$ZSH/custom/themes"

#----------------------
# Spaceship theme
if [[ ! -a "$THEME_BASE_PATH/spaceship-prompt" ]]; then
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$THEME_BASE_PATH/spaceship-prompt"
  ln -s "$THEME_BASE_PATH/spaceship-prompt/spaceship.zsh-theme" "$THEME_BASE_PATH/spaceship.zsh-theme"
fi
#----------------------
