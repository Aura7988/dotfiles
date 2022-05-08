let mapleader = " "
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

call plug#begin('~/.config/nvim/plugged')
Plug 'Aura7988/anyline'
Plug 'sainnhe/edge'
	let g:edge_style = 'aura'
	let g:edge_better_performance = 1
Plug 'voldikss/vim-floaterm'
	let g:floaterm_title = ''
	let g:floaterm_position = 'topright'
	let g:floaterm_borderchars = '─│─│╭╮╯╰'
	let g:floaterm_keymap_toggle = '<F2>'
	let g:floaterm_opener = 'vsplit'
Plug 'wellle/targets.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kevinhwang91/nvim-bqf'
Plug 'lfv89/vim-interestingwords'
Plug 'justinmk/vim-sneak'
	let g:sneak#label = 1
	let g:sneak#use_ic_scs = 1
	map f <Plug>Sneak_s
	map F <Plug>Sneak_S
	map t <Plug>Sneak_t
	map T <Plug>Sneak_T
Plug 'ibhagwan/fzf-lua'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich'
Plug 'honza/vim-snippets'
call plug#end()

colorscheme edge
set termguicolors
set background=light
set noshowmode
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,big5,euc-jp,euc-kr,latin1
set backspace=start,indent,eol
set whichwrap=b,s,h,l,<,>,~,[,]
set number
set relativenumber
set cindent shiftwidth=4
set tabstop=4
set clipboard=unnamed
set ignorecase smartcase
set mouse=a
set hidden
set cmdheight=2
set laststatus=3
" set shortmess+=c
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
nnoremap <expr> gs '`[' . strpart(getregtype(), 0, 1) . '`]'
vnoremap < <gv
vnoremap > >gv
nnoremap <Leader>f :FzfLua files <C-r>=GitRoot()<CR><CR>
nnoremap <Leader>F :FzfLua files cwd=
nnoremap <Leader>b :FzfLua buffers<CR>
nnoremap <Leader>c :FzfLua command_history<CR>
nnoremap <Leader>/ :FzfLua search_history<CR>
nnoremap <Leader>l :FzfLua oldfiles<CR>
nnoremap <Leader>s :FzfLua grep_cword <C-r>=GitRoot()<CR><CR>
xnoremap <Leader>s :<C-u>FzfLua grep_visual <C-r>=GitRoot()<CR><CR>
nnoremap <TAB> <C-w>w
nnoremap <S-TAB> <C-w>W
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
nmap gb <Plug>(EasyAlign)
xmap gb <Plug>(EasyAlign)
noremap! <A-a> <Home>
noremap! <A-s> <S-Left>
noremap! <A-d> <S-Right>
noremap! <A-f> <End>
noremap! <A-h> <Left>
noremap! <A-j> <Down>
noremap! <A-k> <Up>
noremap! <A-l> <Right>
cabbrev dd EasyAlign / \ze\S\+\s*[;=]/ {'rm': 0, 'lm': 0}

command! -nargs=0 NNN FloatermNew nnn

function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction

function! GitRoot()
	let l:gr = system('git rev-parse --show-toplevel 2> /dev/null')
	if empty(l:gr) | return '' | endif
	return 'cwd=' . l:gr[:-2]
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
require('nvim-treesitter.configs').setup {
ensure_installed = {'bash', 'c', 'cmake', 'cpp', 'go', 'json', 'lua', 'python', 'rust', 'vim'},
  highlight = {
    enable = true,
  },
}
EOF
