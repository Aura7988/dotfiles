let mapleader = " "

call plug#begin()
Plug 'andymass/vim-matchup'
Plug 'mizlan/iswap.nvim'
Plug 'skywind3000/asyncrun.vim'
Plug 'voldikss/vim-floaterm'
	let g:floaterm_title = ''
	let g:floaterm_borderchars = '─│─│╭╮╯╰'
	let g:floaterm_keymap_toggle = '<F2>'
Plug 'kkoomen/vim-doge', {'do': { -> doge#install() }}
Plug 'mbbill/undotree'
Plug 'wellle/targets.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kevinhwang91/nvim-bqf'
Plug 'lfv89/vim-interestingwords'
Plug 'kshenoy/vim-signature'
Plug 'justinmk/vim-sneak'
	let g:sneak#label = 1
	let g:sneak#use_ic_scs = 1
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
	let g:vista#renderer#enable_icon = 0
Plug '~/.config/nvim/plugged/anyline'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'
Plug 'honza/vim-snippets'
call plug#end()

colorscheme seoul256
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
" set undofile
set matchpairs+=<:>
set jumpoptions=stack
set signcolumn=auto:2
set virtualedit=block
" set lazyredraw

nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>
nnoremap <C-l> :nohlsearch<CR><C-l>
vnoremap < <gv
vnoremap > >gv
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-z> coc#refresh()
nmap <Leader>j :call CocActionAsync('doHover')<CR>
nmap <C-k> <Plug>(coc-diagnostic-prev)
nmap <C-j> <Plug>(coc-diagnostic-next)
nmap <Leader>g <Plug>(coc-definition)
nmap <Leader>r <Plug>(coc-references)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nnoremap <Leader>t :Vista!!<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :Files! 
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :History:<CR>
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>l :History<CR>
nnoremap <Leader>e :CocCommand explorer<CR>
nnoremap <Leader>x :cclose <Bar> lclose<CR>
nnoremap [q :cprev<CR>zz
nnoremap ]q :cnext<CR>zz
nnoremap [l :lprev<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>
nnoremap <TAB> <C-w>w
nnoremap <S-TAB> <C-w>W
" nmap <Leader>- :b#<CR>
" nmap <Leader>n :bn<CR>
" nmap <Leader>p :bp<CR>
nmap <Leader>s :Rg <C-r><C-w>
xmap <Leader>s y:Rg -F '<C-r>"'<CR>
nmap gb <Plug>(EasyAlign)
xmap gb <Plug>(EasyAlign)
cabbrev dd EasyAlign / \ze\S\+\s*[;=]/ {'rm': 0, 'lm': 0}

command! -nargs=0 NNN FloatermNew nnn
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction

" jump to the last position
au BufReadPost * if line ("'\"") <= line("$") | exe "normal! g`\"" | endif
" Disable automatic comment insertion
au BufEnter * set fo-=c fo-=r fo-=o
au ColorScheme * highlight VertSplit cterm=NONE ctermfg=226 ctermbg=NONE
" au CursorHold * silent call CocActionAsync('doHover')
" au CursorHoldI * silent call CocActionAsync('showSignatureHelp')
au FileType c,cpp setlocal commentstring=//\ %s
au FileType crontab setlocal nobackup nowritebackup
au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
highlight FloatermBorder guibg=NONE guifg=Blue

lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = {'bash', 'c', 'cmake', 'cpp', 'go', 'json', 'lua', 'python', 'rust'},
  highlight = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
}
require('iswap').setup {}
EOF
