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
- cd ~
- git clone https://github.com/Stephen321/dotfiles.git
- cd dotfiles
- stow X *(note: if any of the files under X/ already exist in ../ then they won't be overriden unless using --override=\*)*
- chsh -s /bin/zsh

### Note:
- .oh-my-zsh git repos isn't tracked so manually need to update if needed


To update oh-my-zsh directory:
- cd ~/dotfiles/zsh/.oh-my-zsh
- git init
- git remote add origin https://github.com/robbyrussell/oh-my-zsh
- git fetch --all
- git reset --hard origin/master
- git pull
- rm -rf .git/
- git commit -am "updated .oh-my-zsh directory"
- git push
