colorscheme jellybeans
au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif " jump to the last position
au FileType go nnoremap <Leader>g :GoDef<CR>
" au FileType go,vim,c,cpp,python nested :TagbarOpen
au FileType crontab setlocal nobackup nowritebackup
" au FileType * setlocal formatoptions-=cro " Disable automatic comment insertion

if has('gui')
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h16
endif
" set directory=.,$TEMP
" set termencoding=cp936
" set langmenu=zh_CN.UTF-8
" language message zh_CN.UTF-8
" set ambiwidth=double
" set go=
" filetype plugin indent on
" syntax enable
set nocompatible
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,big5,euc-jp,euc-kr,latin1
set showcmd
set showmatch
set backspace=start,indent,eol
set whichwrap=b,s,h,l,<,>,~,[,]
set ru
set nu
set relativenumber
set cindent shiftwidth=4
set ts=4
set clipboard=unnamed
set ignorecase smartcase
set hlsearch
set incsearch
set mouse=a
set completeopt=menu,longest,menuone
set cursorline
set history=126
" set listchars=tab:>>,trail:!,eol:$
" set expandtab
" set smarttab
" set nowrap
" set colorcolumn=80
" set shortmess=atI
" set cmdheight=2
" let regexpengine = 1
let mapleader = "\<Space>"	"default value is backslash(\).

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoUpdateBinaries'}
Plug 'Valloric/YouCompleteMe', {'for': ['c', 'cpp', 'go'], 'do': './install.py --clang-completer --go-completer'}
Plug 'w0rp/ale', {'for': 'go'}
Plug 'tpope/vim-fugitive'
" Plug 'godlygeek/csapprox'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
"Plug 'rking/ag.vim'
Plug 'dyng/ctrlsf.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'junegunn/goyo.vim', {'for': 'markdown'}
" Plug 'junegunn/limelight.vim', {'for': 'markdown'}
Plug 'junegunn/vim-easy-align'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-abolish'
" Plug 'vim-scripts/c.vim'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
Plug 'mhinz/vim-signify'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
" Plug 'dbeniamine/cheat.sh-vim'
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp']}
call plug#end()

nnoremap <F2> :q<CR>
set pastetoggle=<F3>
nnoremap <F4> :set hls!<Bar>set hls?<CR>
nnoremap <F5> :!open %<CR><CR>
nnoremap <F6> :Dox<CR>
nnoremap <F7> :CtrlSFToggle<CR>
nnoremap <F8> :call Header()<CR>

nnoremap <C-j> <C-w>j "Ctrl-j to move down a split
nnoremap <C-k> <C-w>k "Ctrl-k to move up a split
nnoremap <C-l> <C-w>l "Ctrl-l to move right a split
nnoremap <C-h> <C-w>h "Ctrl-h to move left a split

nnoremap <Leader>g :YcmCompleter GoTo<CR>
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :Files 
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History:<CR>
nnoremap <Leader>/ :History/<CR>
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9
nmap <Leader>- :b#<CR>
nmap <Leader>n :bn<CR>
nmap <Leader>p :bp<CR>
nmap <Leader>s <Plug>CtrlSFCwordPath
xmap <Leader>s <Plug>CtrlSFVwordExec
nmap gb <Plug>(EasyAlign)
xmap gb <Plug>(EasyAlign)
vnoremap < <gv
vnoremap > >gv

let g:airline_powerline_fonts = 1
let g:airline_extensions = ['branch', 'tabline']
" let g:airline_section_c = '%<%{tagbar#currenttag("%s", "", "s")}'
let g:airline_section_z = '%l,%c%V / %L -%p%%-'
" let g:airline#extensions#tabline#buffer_idx_mode = 1

" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
" let g:ycm_min_num_of_chars_for_completion = 3
" let g:ycm_disable_for_files_larger_than_kb = 0
" let g:ycm_always_populate_location_list = 1
let g:ycm_show_diagnostics_ui = 0
" let g:ycm_semantic_triggers = {'c,cpp,go': ['re!\w{2}']}
let g:ycm_key_invoke_completion = '<C-z>'

let g:ale_echo_delay = 20
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:tagbar_left = 1
let g:tagbar_width = 24
let g:tagbar_zoomwidth = 0
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▶', '▽']
let g:tagbar_indent = 1
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

cabbrev dd EasyAlign / \ze\S\+\s*[;=]/ {'rm': 0, 'lm': 0}

let g:ctrlsf_context = '-C 1'
let g:ctrlsf_default_root = 'project+fw'
let g:ctrlsf_indent = 2
let g:ctrlsf_position = 'right'

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsEditSplit="vertical"

highlight DiffAdd           cterm=bold ctermbg=none ctermfg=14
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=197
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=14
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=197

function! Header()
	call append(0, "/*")
	call append(1, " * Copyright ".strftime("%Y")." Aura. All rights reserved.")
	call append(2, " *")
	call append(3, " * @file   : ".expand("%:t"))
	call append(4, " * @brief  : ")
	call append(5, " *")
	call append(6, " * @created: ".strftime("%Y-%m-%d %a %H:%M:%S"))
	call append(7, " * @author : Aura, aura8897@gmail.com")
	call append(8, " */")
	call append(9, "")
endfunction
