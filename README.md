# dotfiles
dotfiles using stow

- install git, stow, zsh
- install powerline
  - https://powerline.readthedocs.io/en/latest/installation.html
  - on Ubuntu/Arch linux can install with package manager
    - Ubuntu: sudo apt install powerline
  - Otherwise install with pip and also install fonts (install directory might be different than what dotfiles are configured for)
  - Might have to select one of the powerline patched fonts in terminal.
  - note that vim uses vim-airline instead of powerline but still requires powerline patched font?
- git clone https://github.com/Stephen321/dotfiles.git
- cd dotfiles
- stow X *(note: if any of the files under X/ already exist in ../ then they won't be overriden unless using --override=\*)*
- chsh -s /bin/zsh
