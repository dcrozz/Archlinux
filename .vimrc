""""""""""""""""""""""""""
"General
""""""""""""""""""""""""""
set nocompatible    " be iMproved, required
filetype off        " required
let mapleader = "\\"
set wildmenu
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h15
set wildmode=full
set hidden			"切换buffer时不被打断
set nowrap
set incsearch		" 开启实时搜索功能
colorscheme molokai
set smartindent		"smart indent
set autoindent		"auto indent
set shortmess=atI   "remove the Welcome frame
set nu				"line number
set hlsearch		"highlight the search result
set incsearch		"immediately match
set ruler			"right-bottom will show the postion of the current cursor
set showmode
syntax on			"enable the file type detect
set autoread		"refresh the file if it's updated outside
set history=50
set nolinebreak
set backspace=indent,eol,start
set t_Co=256
set cursorline
set list lcs=tab:\|\ 
set foldnestmax=2
set nofoldenable
set ignorecase smartcase
set cursorline cursorcolumn
set guioptions-=L
set guioptions-=r
""""""Indent
"set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
" if !has('gui_running')
"   set background=light
" endif

""""""""""""""""""""""""""
"Functions
""""""""""""""""""""""""""
" Auto Session Save/Restore
function GetProjectName()
    " Get the current editing file list, Unix only
    let edit_files = split(system("ps -o command= -p " . getpid()))
    if len(edit_files) >= 2
        let project_path = edit_files[1]
        if project_path[0] != '/'
            let project_path = getcwd() . project_path
        endif
    else
        let project_path = getcwd()
    endif
    return shellescape(substitute(project_path, '[/]', '', 'g'))
endfunction

function SaveSession()
    "NERDTree doesn't support session, so close before saving
    execute ':NERDTreeClose' 
    let project_name = GetProjectName()
    execute 'mksession! ~/.vim/sessions/' . project_name
endfunction

function RestoreSession()
    let session_path = expand('~/.vim/sessions/' . GetProjectName())
    if filereadable(session_path)
        execute 'so ' . session_path
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exec 'sbuffer ' . l
                endif
            endfor
        endif
    endif
    "Make sure the syntax is on
    syntax on 
endfunction

function DeleteSession()
    let project_name = GetProjectName()
	let session_path = expand('~/.vim/sessions/' . GetProjectName())
	execute "!rm ". session_path
endfunction

function RunProgram()
  if &filetype == 'python'
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
  elseif &filetype == "cpp"
    execute ":!clang++ -std=c++11 -stdlib=libc++ % -o %:r -g && ./%:r"
  elseif &filetype == "c"
	execute ":make %:r"
  endif
endfunction

""""""""""""""""""""""""""
"Mapping
""""""""""""""""""""""""""
hi Normal ctermfg=252 ctermbg=none
imap jj <ESC>
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
nnoremap <c-i> %
"delete all the blank lines in selected range
vmap <Leader>d :g/^\s*$/d<CR> 
nmap <Leader><ESC> :nohl<CR>
nmap ssa :call SaveSession()
nmap sso :call RestoreSession()
nmap ssd :call DeleteSession()
map <F9> :w<CR> :call RunProgram()<CR>
map <F2> :w<CR> :SyntasticCheck<CR> :lopen<CR>

"""""""""""""""""""""""""""""
"Plugins
"""""""""""""""""""""""""""""
"set the runtime path to include Vundle and initialize
filetype plugin indent on    " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'easymotion/vim-easymotion'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'mattn/emmet-vim'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tomasr/molokai'
Plugin 'junegunn/vim-easy-align'
Plugin 'mhinz/vim-startify'
Plugin 'airblade/vim-gitgutter'
" ultisnip engine and snippets
" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
Plugin 'hail2u/vim-css3-syntax'
"Plugin 'nvie/vim-rst-tables'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-syntastic/syntastic'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" All of your Plugins must be added before the following line
call vundle#end()            " required

"NERDTree Setting
nnoremap <silent> <F5> :NERDTree<CR>
let NERDTreeShowBookmarks=1 
"autocmd VimEnter * NERDTree
set gcr=a:block-blinkon0
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"Airline Setting
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#ctrlp#enabled = 1

"Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F6> :TagbarToggle<CR>

"Ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Colorscheme
let g:molokai_original = 1

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" CSS3 highlight
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

"" Plugin syntastic settings.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylint_post_args="--max-line-length=120"
" let g:syntastic_debug=1
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': []}
" Use pylint to check python files.
let g:syntastic_python_checkers = ['pylint']
" Ignore warnings about newlines trailing.
let g:syntastic_quiet_messages = { 'regex': ['trailing-newlines', 'invalid-name',
    \'too-many-lines', 'too-many-instance-attributes', 'too-many-public-methods',
    \'too-many-locals', 'too-many-branches'] }

""""""""""""""""""""""""""
"Macro
""""""""""""""""""""""""""
let @i="I\"<80>lxf:i\"<80>wi\"<80>lxA\",<80>j"	"change the header format
let @c="i:code:`jjxEa`jj"
let @r="\"aygvr "								"cut and paste without indent change
let @p="Ra"
