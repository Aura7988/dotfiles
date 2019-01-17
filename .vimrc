colorscheme delek
au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif " jump to the last position
" au FileType go,vim,c,cpp,python nested :TagbarOpen
au FileType crontab setlocal nobackup nowritebackup
au BufEnter * set fo-=c fo-=r fo-=o " Disable automatic comment insertion
au VimEnter * call <SID>OnceADay()

" augroup NoSimultaneousEdits
"     au!
"     au SwapExists ~/*    :let v:swapchoice = 'q'
"     au SwapExists /etc/* :let v:swapchoice = 'o'
" augroup END

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
" Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
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
Plug '~/.vim/plugged/doxygenTool', {'for': ['c', 'cpp']}
call plug#end()

nnoremap <F2> :q<CR>
set pastetoggle=<F3>
nnoremap <F4> :set hls!<Bar>set hls?<CR>
nnoremap <F5> :!open %<CR><CR>
" nnoremap <F6> :Dox<CR>
nnoremap <F7> :CtrlSFToggle<CR>
" nnoremap <F8> :match StatusLineTerm /<C-R><C-W>/<CR>
nnoremap <F8> :call HlWord()<CR>

vnoremap < <gv
vnoremap > >gv
nnoremap <C-j> <C-w>j "Ctrl-j to move down a split
nnoremap <C-k> <C-w>k "Ctrl-k to move up a split
nnoremap <C-l> <C-w>l "Ctrl-l to move right a split
nnoremap <C-h> <C-w>h "Ctrl-h to move left a split

au FileType go nnoremap <Leader>g :GoDef<CR>
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

let g:go_template_autocreate = 0
" let g:go_auto_sameids = 1
let g:go_addtags_transform = 'camelcase'

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

nmap gb <Plug>(EasyAlign)
xmap gb <Plug>(EasyAlign)
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

function! <SID>OnceADay()
	let s:vimrc = '/Users/aura/.vimrc'
	let s:vimrcDate = strftime("%Y%m%d", getftime(s:vimrc))
	let s:currDate = strftime("%Y%m%d")
	if s:vimrcDate != s:currDate
		:PlugUpdate | PlugUpgrade
		execute "silent !touch" s:vimrc
	endif
endfunction

function! HlWord()
	let w:hlword = exists('w:hlword') ? !w:hlword : 1
	if w:hlword
		let l:cmd = 'match StatusLineTerm /\<'.expand("<cword>").'\>/'
		exec l:cmd
	else
		match none
	endif
endfunction
