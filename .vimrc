colorscheme seoul256
au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif " jump to the last position
au FileType c,cpp setlocal commentstring=//\ %s
au FileType crontab setlocal nobackup nowritebackup
au BufEnter * set fo-=c fo-=r fo-=o " Disable automatic comment insertion
au ColorScheme * highlight VertSplit cterm=NONE ctermfg=226 ctermbg=NONE

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
set history=10000
set hidden
set cmdheight=2
set shortmess+=c
set pastetoggle=<F3>
set fillchars=vert:│
set listchars=tab:>>,trail:!,eol:$
set updatetime=300
let mapleader = " "

call plug#begin('~/.vim/plugged')
" Plug 'lfv89/vim-interestingwords'
" Plug 'kshenoy/vim-signature'
Plug 'justinmk/vim-sneak'
Plug '~/.vim/plugged/anyline'
" Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'neoclide/coc.nvim', {'for': ['c', 'cpp', 'go'], 'branch': 'release'}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug '~/.vim/plugged/fuzzy'
Plug 'junegunn/vim-easy-align'
" Plug 'Olical/vim-enmasse'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'airblade/vim-gitgutter'
Plug 'honza/vim-snippets'
call plug#end()

nnoremap <F2> :q<CR>
nnoremap <C-l> :nohlsearch<CR><C-l>
" nnoremap <F4> :set hls!<Bar>set hls?<CR>
vnoremap < <gv
vnoremap > >gv
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-z> coc#refresh()
nmap <C-k> <Plug>(coc-diagnostic-prev)
nmap <C-j> <Plug>(coc-diagnostic-next)
nmap <Leader>g <Plug>(coc-definition)
nmap <Leader>r <Plug>(coc-references)
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :Files! 
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :History:<CR>
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>l :History<CR>
nmap <Leader>- :b#<CR>
nmap <Leader>n :bn<CR>
nmap <Leader>p :bp<CR>
nmap <Leader>s :Rg <C-r><C-w>
xmap <Leader>s y:Rg -F '<C-r>"'<CR>
nmap gb <Plug>(EasyAlign)
xmap gb <Plug>(EasyAlign)
cabbrev dd EasyAlign / \ze\S\+\s*[;=]/ {'rm': 0, 'lm': 0}

" let g:go_template_autocreate = 0
" let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1
" let g:go_addtags_transform = 'camelcase'

let g:tagbar_left = 1
let g:tagbar_width = 24
let g:tagbar_zoomwidth = 0
let g:tagbar_sort = 0
let g:tagbar_autoclose = 1
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

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction
