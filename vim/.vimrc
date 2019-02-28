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
"  Note: Many different variations, configurations and combinations of the following plugins
"  are available. Some installed may even overlap but have different parts disabled.

" completion and snippets:
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" LCN for completion and LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Lua completions
" TODO: Onmi complete gives errors with deoplete. Using lua-lsp instead.
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-lua-ftplugin'

" ALE for linting and syntax underlining
Plug 'w0rp/ale'

" ------------------------------------------------------------

" for async running of makefile/build etc.
Plug 'skywind3000/asyncrun.vim'

Plug 'Valloric/ListToggle'

" handy mappings
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'

" working with git
Plug 'tpope/vim-fugitive'

" fzf fuzzy command line search installed for all (added to path and with zsh bindings)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()
" vim-easy-align options
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set encoding=utf-8

" https://github.com/vim-airline/vim-airline-themes
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1
" https://github.com/arcticicestudio/nord-vim
colorscheme nord
set background=light

" ultisnips config
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "extra_snippets"]

" options for deoplete
let g:deoplete#enable_at_startup = 1
" default sources is just buffer
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer']
let g:deoplete#sources.c =   ['buffer', 'tag', 'member', 'file', 'omni', 'LanguageClient','ultisnips','ALE']
let g:deoplete#sources.cpp = ['buffer', 'tag', 'member', 'file', 'omni', 'LanguageClient','ultisnips','ALE']
" let g:deoplete#sources.lua = ['buffer', 'tag', 'member', 'file', 'omni', 'LanguageClient','ultisnips','ALE']
let g:deoplete#sources.lua = ['buffer', 'tag', 'member', 'file', 'LanguageClient','ultisnips','ALE']
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
" deoplete opens preview window when completing to show documentation
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


" https://github.com/Shougo/deoplete.nvim/issues/458
" TODO: Onmi complete gives errors with deoplete. Using lua-lsp instead.
" let g:lua_check_syntax = 0
" let g:lua_complete_omni = 1
" let g:lua_define_completefunc = 0
" let g:lua_complete_dynamic = 0
" let g:lua_define_completion_mappings = 0
" if !exists('g:deoplete#omni#functions')
"   let g:deoplete#omni#functions = {}
"   let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'
" else
"   let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'
" endif
" let g:deoplete#omni#input_patterns = {}
" let g:deoplete#omni#input_patterns.lua = '\w+|[^. *\t][.:]\w*'

" tab to cycel through deoplete
" https://github.com/Shougo/deoplete.nvim/issues/310
inoremap <silent><expr> <tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<tab>" :
    \ deoplete#mappings#manual_complete()
    function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" options for LSP (LanguageClient + cquery)
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\ 'cpp': ['cquery',
\ '--language-server',
\ '--log-file=/tmp/cq.log',
\ '--init={"cacheDirectory":"/tmp/cquery"}'],
\ 'c': ['cquery',
\ '--language-server',
\ '--log-file=/tmp/cq.log',
\ '--init={"cacheDirectory":"/tmp/cquery"}'],
\ 'lua': ['lua-lsp'],
\ }
nnoremap <F3> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" let other plugins handle diagnostics display
let g:LanguageClient_diagnosticsEnable = 0

" https://github.com/autozimu/LanguageClient-neovim/issues/379
" neosnippet + deoplete might do this better than UltiSnips as its made by the same person who makes
" deoplete
function! ExpandLspSnippet()
    call UltiSnips#ExpandSnippetOrJump()
    if !pumvisible() || empty(v:completed_item)
        return ''
    endif

    " only expand Lsp if UltiSnips#ExpandSnippetOrJump not effect.
    let l:value = v:completed_item['word']
    let l:matched = len(l:value)
    if l:matched <= 0
        return ''
    endif

    " remove inserted chars before expand snippet
    if col('.') == col('$')
        let l:matched -= 1
        exec 'normal! ' . l:matched . 'Xx'
    else
        exec 'normal! ' . l:matched . 'X'
    endif

    if col('.') == col('$') - 1
        " move to $ if at the end of line.
        call cursor(line('.'), col('$'))
    endif

    " expand snippet now.
    call UltiSnips#Anon(l:value)
    return ''
endfunction
imap <C-j> <C-R>=ExpandLspSnippet()<CR>


" ale configure
let g:ale_lint_on_enter = 1
" use other plugins for completion
let g:ale_completion_enabled = 0
" dont use g++ or clang to lint as they cant see compilation database for compiler flags
let g:ale_linters = {
            \'c': ['clangtidy','cquery','clangcheck','clazy','cppcheck','cpplint','flawfinder'],
            \'cpp': ['clangtidy','cquery','clangcheck','clazy','cppcheck','cpplint','flawfinder']}
let g:ale_c_parse_compile_commands = 1
let g:ale_fixers = {
\   '*': [
\       'remove_trailing_lines',
\       'trim_whitespace',
\   ],
\   'cpp' : [
\       'remove_trailing_lines',
\       'trim_whitespace',
\       'clang-format'
\   ],
\   'c' : [
\       'remove_trailing_lines',
\       'trim_whitespace',
\       'clang-format'
\   ],
\}

" fzf + ag options
" {{{
"  let g:fzf_nvim_statusline = 0 " disable statusline overwriting
"
"  nnoremap <silent> <leader><space> :Files<CR>
"  nnoremap <silent> <leader>a :Buffers<CR>
"  nnoremap <silent> <leader>A :Windows<CR>
"  nnoremap <silent> <leader>; :BLines<CR>
"  nnoremap <silent> <leader>o :BTags<CR>
"  nnoremap <silent> <leader>O :Tags<CR>
"  nnoremap <silent> <leader>? :History<CR>
"  nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
"  nnoremap <silent> <leader>. :AgIn
"
"  nnoremap <silent> K :call SearchWordWithAg()<CR>
"  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
"  nnoremap <silent> <leader>gl :Commits<CR>
"  nnoremap <silent> <leader>ga :BCommits<CR>
"  nnoremap <silent> <leader>ft :Filetypes<CR>
"
"  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
"  imap <C-x><C-l> <plug>(fzf-complete-line)
"
"  function! SearchWordWithAg()
"    execute 'Ag' expand('<cword>')
"  endfunction
"
"  function! SearchVisualSelectionWithAg() range
"    let old_reg = getreg('"')
"    let old_regtype = getregtype('"')
"    let old_clipboard = &clipboard
"    set clipboard&
"    normal! ""gvy
"    let selection = getreg('"')
"    call setreg('"', old_reg, old_regtype)
"    let &clipboard = old_clipboard
"    execute 'Ag' selection
"  endfunction
"
"  function! SearchWithAgInDirectory(...)
"    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
"  endfunction
"  command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
" }}}

" asyncrun options
map <F5> :AsyncRun make -C build/<CR>
let g:asyncrun_bell = 1
let g:asyncrun_trim = 1
let g:asyncrun_open = 10

" Valloric list toggle options
let g:lt_location_list_toggle_map = 'tl'
let g:lt_quickfix_list_toggle_map = 'tq'


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

" fzf mappings
" only search files not in gitignore
nnoremap <leader>f :GFiles<cr>
"search all files if you really want to
nnoremap <leader>af :Files<cr>
"fzf grep (with ripgrep,ag etc)
nnoremap <leader>g :Rg<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>h :History:<cr>
nnoremap <leader>s :Snippets<cr>
" To use ripgrep instead of Ag:
" https://github.com/junegunn/fzf.vim#advanced-customization
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always --smart-case --hidden --follow '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:50%:hidden', '?'),
\   <bang>0)


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
set shiftwidth=2
set tabstop=2
set softtabstop=2
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
