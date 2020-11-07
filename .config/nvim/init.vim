colorscheme seoul256
au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif " jump to the last position
au FileType c,cpp setlocal commentstring=//\ %s
au FileType crontab setlocal nobackup nowritebackup
au BufEnter * set fo-=c fo-=r fo-=o " Disable automatic comment insertion
au ColorScheme * highlight VertSplit cterm=NONE ctermfg=226 ctermbg=NONE
" au CursorHold * silent call CocActionAsync('doHover')
" au CursorHoldI * silent call CocActionAsync('showSignatureHelp')

set noshowmode
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,big5,euc-jp,euc-kr,latin1
set backspace=start,indent,eol
set whichwrap=b,s,h,l,<,>,~,[,]
set nu
set relativenumber
set cindent shiftwidth=4
set ts=4
set clipboard=unnamed
set ignorecase smartcase
set mouse=a
set hidden
set cmdheight=2
" set shortmess+=c
set pastetoggle=<F3>
set fillchars=vert:│
set updatetime=300
let mapleader = " "

call plug#begin()
Plug 'lfv89/vim-interestingwords'
Plug 'kshenoy/vim-signature'
Plug 'justinmk/vim-sneak'
" Plug 'neoclide/coc.nvim', {'for': ['c', 'rust', 'cpp', 'go'], 'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'aura7988/anyline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-abolish'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'
Plug 'honza/vim-snippets'
call plug#end()

nnoremap <F2> :q<CR>
nnoremap <C-l> :nohlsearch<CR><C-l>
vnoremap < <gv
vnoremap > >gv
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-z> coc#refresh()
nmap <C-e> :call CocActionAsync('doHover')<CR>
nmap <C-k> <Plug>(coc-diagnostic-prev)
nmap <C-j> <Plug>(coc-diagnostic-next)
nmap <Leader>g <Plug>(coc-definition)
nmap <Leader>r <Plug>(coc-references)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :Files! 
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :History:<CR>
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>l :History<CR>
" nmap <Leader>- :b#<CR>
nmap <Leader>n :bn<CR>
nmap <Leader>p :bp<CR>
nmap <Leader>s :Rg <C-r><C-w>
xmap <Leader>s y:Rg -F '<C-r>"'<CR>
nmap gb <Plug>(EasyAlign)
xmap gb <Plug>(EasyAlign)
cabbrev dd EasyAlign / \ze\S\+\s*[;=]/ {'rm': 0, 'lm': 0}

let g:tagbar_left = 1
let g:tagbar_width = 24
let g:tagbar_zoomwidth = 0
let g:tagbar_sort = 0
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▶', '▽']
let g:tagbar_indent = 1

command! -bang -nargs=* -complete=file Rg call fzf#vim#grep("rg -SnHg !.git/* --hidden --column --color=always ".<q-args>, 1, {'options': ['--bind=ctrl-n:preview-page-down,ctrl-p:preview-page-up,ctrl-/:toggle-preview', '--preview-window=right:64%:wrap:hidden', '-d:', '--preview=bat --color=always --pager=never -nH {2} {1}']}, <bang>0)

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction
