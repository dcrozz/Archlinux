set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
"Plugin 'powerline/powerline'
Plugin 'L9'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
"Plugin 'scrooloose/nerdtree'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'user/L9', {'name': 'newL9'}
call vundle#end()            " required
filetype plugin indent on    " required

"vim-powerline
set laststatus=2
set showtabline=2
"set noshowmode
set encoding=utf8
set guifont=PowerlineSymbols\ for\ Powerline
let g:Powerline_symbols = 'fancy'

"vim-airline
let g:airline_powerline_fonts = 1
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
colorscheme solarized
set smartindent "smart indent
set autoindent	"auto indent
set shortmess=atI   "remove the Welcome frame
set nu			"line number
set hlsearch	"highlight the search result
set incsearch	"immediately match
set backspace=2 "enable the backspace
set ruler		"right-bottom will show the postion of the current cursor
set showmode
"set list		"show the tab with "|"
syntax enable	"highlight the syntax
syntax on		"enable the file type detect
set autoread	"refresh the file if it's updated outside
set history=50
set nolinebreak
set backspace=indent,eol,start
set t_Co=256
set cursorline
set shiftwidth=4
set softtabstop=4
set tabstop=4
set foldenable
set fdm=syntax
set ignorecase smartcase
if has('gui_running')
    set background=light
else
    set background=dark
endif

hi Normal ctermfg=252 ctermbg=none
imap jj <ESC>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-i> %
imap <c-k> <Up>
imap <c-j> <Down>
imap <c-l> <Right>
imap <c-h> <Left>
nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w, :resize +3<CR>
nmap w. :resize -3<CR>
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


