" this file is sourced from nvim as well
" https://neovim.io/doc/user/nvim.html#nvim-from-vim

set nocompatible

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'

" ----------------------------------------------------
" LSP and completion and snippets:

" deoplete + LanguageClient-neovim + cquery + neovim-snippets
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" another option: vim-lsp, async-vim, asynccomplete.vim, cquery
" Plug 'prabirshrestha/asyncomplete.vim'
call plug#end()


set encoding=utf-8

" https://github.com/vim-airline/vim-airline-themes
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1
" https://github.com/arcticicestudio/nord-vim
colorscheme nord
set background=light

" options for deoplete
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"

let cwd = getcwd()

" use 256 colours
set t_Co=256

" always show the status line
set laststatus=2

" specify leader key
let g:mapleader = '\'
" issue with space is it doesn't show up nicely in the showcmd statusline
" so map space to leader instead of making it leader
map <space> <leader>

" quickly insert ; or , to the end of the line while in insert mode
inoremap ;; <END>;
inoremap ,, <END>,

" mappings to close brackets
" inoremap " ""<left>
" inoremap ' ''<left>
inoremap ( ()<left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [ []<left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap { {}<left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" map key to make for quick compiling
nnoremap <F5> :make<cr>
nnoremap <F6> :make<cr><cr><cr> :make run<cr>

" remap Esc to something easier to press
inoremap jk <esc>
inoremap jj <esc>

" use alt and hjkl to move from any mode (terminal included)
if has('nvim')
    tnoremap jk <C-\><C-n>
    tnoremap jj <C-\><C-n>
    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
endif
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" also allow alt and hjkl to move between tmux splits
" https://github.com/christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
" Write all buffers before navigating from Vim to tmux pane
" let g:tmux_navigator_save_on_switch = 2

" D and C operate to the end of the line. Y copies the entire line which yy
" already does.
nnoremap Y y$

" S by default maps to cc, instead make saving the file easier
nnoremap S :w<cr>

" easier default macro key mapping
nnoremap <leader>q @q

" search while entering string and not after
set incsearch

" save backups of edited files
" set backup
" set backupext=.bak

" show cmd as it is entered in bottom right of status bar
" display settings
set showcmd
set ruler
set title
set wildmenu
set number
"editer settings
set list
set listchars=eol:¬,tab:␉·,trail:␠,nbsp:⎵

" allow mouse so we can resize windows
set mouse+=a

" set virtualedit=all       " edit where there isnt any spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" splt to the right and below
set splitbelow
set splitright

"show matching (,[,{
set showmatch
set matchtime=2

" abbreviations
noreabbrev #b /****************************************
noreabbrev #e <Space> ****************************************/

" wrap
set nowrap

" scroll
set scrolloff=2

if !has('nvim')
    set esckeys
endif
set ignorecase
set smartcase
set smartindent
set smarttab
set bs=indent,eol,start

" system settings
set confirm

" colour settings
set hlsearch
set incsearch

"<Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" set foldcolumn=2 to show folds
" set foldmethod=indent
