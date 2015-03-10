set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
colorscheme solarized
set nu
set hlsearch
set backspace=2
set autoindent
set ruler
set showmode
syntax enable
set tabstop=4
set history=50
set nolinebreak
set backspace=indent,eol,start
set t_Co=256
if has('gui_running')
    set background=light
else
    set background=dark
endif
filetype plugin on
let g:pydiction_location = '/home/user/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 3 
hi Normal ctermfg=252 ctermbg=none
