let mapleader = " "

call plug#begin('~/.config/nvim/plugged')
Plug 'Aura7988/anyline'
Plug 'Aura7988/fzf.vim', {'branch': 'dev'}
Plug 'sainnhe/edge'
Plug 'danymat/neogen'
Plug 'mbbill/undotree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'kevinhwang91/nvim-bqf'
Plug 'justinmk/vim-sneak'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'echasnovski/mini.ai'
Plug 'echasnovski/mini.align'
Plug 'echasnovski/mini.comment'
Plug 'echasnovski/mini.move'
Plug 'echasnovski/mini.surround'
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
set cursorline
set relativenumber
set cindent shiftwidth=4
set tabstop=4
set clipboard+=unnamedplus
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
" set pumblend=9
" set timeoutlen=500
set winminheight=0
set winminwidth=0

tnoremap <A-Esc> <C-\><C-n>
nnoremap <C-w>m <C-w>_ \| <C-w>\|
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>
nnoremap <expr> gs '`[' . strpart(getregtype(), 0, 1) . '`]'
inoremap <expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : '<TAB>'
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : '<CR>'
inoremap <expr> <C-z> coc#refresh()
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
nmap <C-k> <Plug>(coc-diagnostic-prev)
nmap <C-j> <Plug>(coc-diagnostic-next)
nmap <C-s> <Plug>(coc-range-select)
xmap <C-s> <Plug>(coc-range-select)
nmap <C-q> <Plug>(coc-range-select-backward)
xmap <C-q> <Plug>(coc-range-select-backward)
nmap <Leader>j :call CocActionAsync('doHover')<CR>
nmap <Leader>g <Plug>(coc-definition)
nmap <Leader>r <Plug>(coc-references)
nmap <Leader>ar <Plug>(coc-rename)
xmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>ac <Plug>(coc-codeaction-cursor)
nmap <Leader>as <Plug>(coc-codeaction-source)
nmap <Leader>af <Plug>(coc-fix-current)
nmap <Leader>Rc <Plug>(coc-codeaction-refactor)
xmap <Leader>R <Plug>(coc-codeaction-refactor-selected)
nmap <Leader>R <Plug>(coc-codeaction-refactor-selected)
nnoremap <Leader>t :Vista!!<CR>
nnoremap <Leader>f :KKFiles<CR>
nnoremap <Leader>F :KKFiles! 
nnoremap <Leader>b :KKBuffers<CR>
nnoremap <Leader>c :KKHistory:<CR>
nnoremap <Leader>/ :KKHistory/<CR>
nnoremap <Leader>l :KKHistory<CR>
nnoremap <Leader>s :KKRg <C-r><C-w><CR>
xnoremap <Leader>s y:KKRg '<C-r>"'<CR>
nnoremap <Leader>e :CocCommand explorer<CR>
nnoremap <Leader>gg :silent! tab Git<CR>
noremap <Leader>gl :Flog<Home>silent! <CR>

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)

au BufReadPost * silent! normal g`"
au BufEnter * set fo-=c fo-=r fo-=o
au FileType c,cpp setlocal commentstring=//\ %s
au FileType crontab setlocal nobackup nowritebackup
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Cursor", timeout=300}
hi IncSearch ctermfg=230 ctermbg=160 guifg=#fdf6e3 guibg=#f85552
hi FloatBorder ctermbg=NONE guibg=NONE

lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 1024 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  indent = {enable = true},
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      ['z;'] = 'textsubjects-container-outer',
      ['z,'] = 'textsubjects-container-inner',
    },
  },
}
require('mini.ai').setup {}
require('mini.align').setup {mappings = {start = 'gb', start_with_preview = 'gB'}}
require('mini.comment').setup {}
require('mini.move').setup {}
require('mini.surround').setup {}
require('neogen').setup {}
EOF
