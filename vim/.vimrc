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
" Plug 'flazz/vim-colorschemes'
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'tpope/vim-vinegar.git'
" Plug 'junegunn/vim-easy-align'
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'vim-scripts/Conque-GDB'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-fugitive' " git integration
" Plug 'Valloric/ListToggle'

" Plugin 'ludovicchabant/vim-gutentags'
" Plugin 'vim-syntastic/syntastic' " https://github.com/Valloric/YouCompleteMe#the-gycm_show_diagnostics_ui-option

" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
" Plugin 'pboettch/vim-cmake-syntax'

" some other auto completion options:
" Plugin 'ajh17/VimCompletesMe' " tab completion
" Plugin 'lifepillar/vim-mucomplete'
" Plugin 'Rip-Rip/clang_complete'
" Plugin 'maralla/completor.vim'
" Plugin 'Valloric/YouCompleteMe'

" -------------------------------------------------------------
" LSP and completion and snippets:

" another option: vim-lsp, async-vim, asynccomplete.vim, cquery
" Plug 'prabirshrestha/asyncomplete.vim'


" deoplete + LanguageClient-neovim + cquery + neovim-snippets
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" -------------------------------------------------------------

call plug#end()


set encoding=utf-8

" https://github.com/vim-airline/vim-airline-themes
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1
" https://github.com/arcticicestudio/nord-vim
colorscheme nord
set background=light

" if has("gui_running")
  " " GUI is running or is about to start.
  " " Maximize gvim window (for an alternative on Windows, see simalt below).
  " set lines=999 columns=999
" else
  " This is console Vim.
  "if exists("+lines")
  "  set lines=50
  "endif
  "if exists("+columns")
  "  set columns=100
  "endif
" endif

" options for deoplete
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"

"" options for YouCompleteMe
"" disable any other completion plugin, syntastic
" let g:ycm_always_populate_location_list=1
" let g:ycm_open_loclist_on_ycm_diags = 1
" let g:ycm_key_list_stop_completion = ['<C-y>']
" let g:ycm_collect_identifiers_from_tags_files = 1 " what does this exactly??
" nnoremap <leader>gt :YcmCompleter GoTo<cr>
" nnoremap <leader>gy :YcmCompleter GetType<cr>
" nnoremap <leader>gd :YcmCompleter GetDoc<cr>
" nnoremap <leader>fi :YcmCompleter FixIt<cr>
"
" function! s:CustomizeYcmLocationWindow()
"     4wincmd _
"     wincmd p
" endfunction
" autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()
"
" function! s:CustomizeYcmQuickFixWindow()
"     4wincmd _
"     wincmd p
" endfunction
" autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()

" options for clang_complete
" let g:clang_library_path='/usr/lib/llvm-3.8/lib/libclang-3.8.so.1'

" options for completor
" let g:completor_clang_binary = '/usr/bin/clang'
" inoremap <expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
" inoremap <expr> <s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" options for ultisnips
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

" options for syntastic
" syntastic is not going to work with YCM is enabled for c family filetypes
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_cpp_compiler='g++'
" let g:syntastic_cpp_compiler_options='-std=c++11'

" options for vim-gutentags
" https://github.com/ludovicchabant/vim-gutentags
" let g:gutentags_ctags_exclude = ['Makefile', 'makefile', 'compile_commands.json']
" set statusline+=%{gutentags#statusline()}

let cwd = getcwd()
" let g:gutentags_exclude_project_root=["/usr/local",  $HOME . "/dotfiles"]
" options for conquedb
" 1: strip color after 200 lines, 2: always with color
" let g:ConqueTerm_Color = 2
" close conque when program ends running
" let g:ConqueTerm_CloseOnEnd = 1
" display warning messages if conqueTerm is configured incorrectly
" let g:ConqueTerm_StartMessages = 0

" dont clutter up current directory
" set backupdir=~/.vim/backup
" set directory=~/.vim/swap

" use 256 colours
set t_Co=256


" always show the status line
set laststatus=2

" set colorscheme if it exists
" let colorScheme="CandyPaper"
" let filePath="~/.vim/colors/".colorScheme.".vim"
" if !empty(glob(filePath))
    " echo "colorscheme doesn't exist at ".filePath
" else
    " execute "colorscheme ".colorScheme
" endif

" http://powerline.readthedocs.io/en/master/usage/other.html
" installed powerline using pip so this method is required to
" setup powerline statusline in vim
" (this is python 3 and zshrc and bashrc use powerline3.5 )
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup

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

" options for ListToggle
" let g:lt_location_list_toggle_map = '<F7>'
" let g:lt_quickfix_list_toggle_map = '<F8>'
" mapping to open and close qf window
" nnoremap <F7> :copen<cr>
" nnoremap <F8> :ccl<cr>
" mapping to open and close location list
" nnoremap <S-F7> :lopen<cr>
" nnoremap <S-F8> :lclose<cr>

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

" issue with space is it doesn't show up nicely in the showcmd statusline
" so map space to leader instead of making it leader
" TODO


" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)

" make fzf easier to use
" nnoremap <leader><space> :Files<CR>
" use fzf to search tags (*does not push to tag stack)
" https://github.com/junegunn/fzf.vim/issues/240
" nnoremap <leader>t :Tags<CR>
" nnoremap <leader>T :BTags<CR>
" nnoremap <leader>s :Ag<CR>

" easier default macro key mapping
nnoremap <leader>q @q

" insert mappings here to help with vims vanilla autocompletion like in this
" link: https://sanctum.geek.nz/arabesque/vim-filename-completion/

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
" also set extended mouse so we can resize even in tmux
" https://superuser.com/questions/549930/cant-resize-vim-splits-inside-tmux
set mouse+=a
" if !has('nvim')
    " if &term =~ '^screen'
        " " tmux knows the extended mouse mode
        " set ttymouse=xterm2
    " endif
" endif

" https://sunaku.github.io/vim-256color-bce.html
" if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " renderproperly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    " set t_ut=
" endif

" set virtualedit=all       " edit where there isnt any spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" splt to the right and below
set splitbelow
set splitright

" THIS STILL DOESNT SEEM TO WORK IN TMUX
" make sure keys are setup right
" https://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
" if &term =~ '^screen'
    " " tmux will send xterm-style keys when its xterm-keys option is on
    " execute "set <xUp>=\e[;*A"
    " execute "set <xDown>=\e[;*B"
    " execute "set <xRight>=\e[;*C"
    " execute "set <xLeft>=\e[;*D"
" endif

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

" CTRL-A is already being used as prefix for tmux, map to something else
" mapping goes here

" set foldcolumn=2 to show folds
" set foldmethod=indent

" make this the default source for fzf so it respects .gitignores when used in
" vim. (it uses ag instead of find to get available files)
" let $FZF_DEFAULT_COMMAND= 'ag -g ""'

