set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'grafin/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'airblade/vim-gitgutter'
Plugin 'nvie/vim-flake8'
Plugin 'NLKNguyen/papercolor-theme'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"
" All of your Plugins must be added before the following line

call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set exrc
set secure
set encoding=utf-8
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

set number
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray

syntax on
set t_Co=256
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
set background=light
colorscheme PaperColor

highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg

let g:flake8_show_in_gutter = 1
let g:flake8_show_in_file = 1
let g:flake8_show_quickfix = 1

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeIgnore = ['__pycache__']

let g:ycm_key_list_stop_completion = ['<C-y>', '<TAB>']

autocmd FileType make set tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
autocmd FileType cmake set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Split navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <silent><expr> <F1> (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
map <silent> <F2> :NERDTreeToggle<CR>
map <F3> <C-o>
map <F4> <C-]>
map <F5> :YcmCompleter GoToInclude<CR>
map <F6> :YcmCompleter GoToDefinition<CR>
map <F7> :YcmCompleter GoToReferences<CR>
map <F8> :YcmCompleter GetType<CR>
map <F9> :call flake8#Flake8()<CR>
map <F10> :call flake8#Flake8ShowError()<CR>
map <F11> :call flake8#Flake8UnplaceMarkers()<CR>
