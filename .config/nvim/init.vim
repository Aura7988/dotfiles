let mapleader = " "

call plug#begin('~/.config/nvim/plugged')
Plug 'Aura7988/anyline'
Plug 'Aura7988/fzf.vim', {'branch': 'dev'}
Plug 'sainnhe/edge'
Plug 'danymat/neogen', {'on': 'Neogen'}
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'kevinhwang91/nvim-bqf'
Plug 'folke/flash.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog', {'on': 'Flog'}
Plug 'rhysd/git-messenger.vim', {'on': 'GitMessenger'}
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'echasnovski/mini.ai'
Plug 'echasnovski/mini.align'
Plug 'echasnovski/mini.bracketed'
Plug 'echasnovski/mini.diff'
Plug 'echasnovski/mini.files'
Plug 'echasnovski/mini.move'
Plug 'echasnovski/mini.surround'
Plug 'honza/vim-snippets'
call plug#end()

colorscheme edge
set termguicolors
set background=light
set noshowmode
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gbk,big5,euc-jp,euc-kr,latin1
set whichwrap=b,s,h,l,<,>,~,[,]
set number
set cursorline
set relativenumber
set cindent shiftwidth=4
set tabstop=4
set clipboard+=unnamedplus
set ignorecase smartcase infercase
set mouse=a
set hidden
set cmdheight=2
set laststatus=3
set fillchars=eob:\ 
set shortmess+=WcC
set updatetime=300
" set undofile
set noruler
set noswapfile noautoread
set nobackup nowritebackup
set breakindent
set listchars=tab:¬·,trail:•,extends:…,precedes:…,nbsp:␣
set completeopt=menuone,noinsert,noselect,popup
set splitkeep=screen
set matchpairs+=<:>
set jumpoptions=stack
set signcolumn=auto:2
set virtualedit=block
" set lazyredraw
set timeoutlen=900
set pumblend=9
set winblend=9
set pumheight=9
set winminheight=0
set winminwidth=0

nmap \a :set colorcolumn=<C-R>=empty(&cc) ? '125' : ''<CR><CR>
nmap \b :set background=<C-R>=&background == 'dark' ? 'light' : 'dark'<CR><CR>
nmap \c :setlocal cursorline!<CR>
nmap \d :<C-R>=&diff ? 'diffoff' : 'diffthis'<CR><CR>
nmap \h :set hlsearch!<CR>
nmap \i :set ignorecase!<CR>
nmap \l :setlocal list!<CR>
nmap \n :setlocal number!<CR>
nmap \r :setlocal relativenumber!<CR>
nmap \s :setlocal spell!<CR>
nmap \v :set <C-R>=(&virtualedit =~# 'all') ? 'virtualedit-=all' : 'virtualedit+=all'<CR><CR>
nmap \w :setlocal wrap!<CR>
nmap \x :set <C-R>=(&cursorline && &cursorcolumn) ? 'nocursorline nocursorcolumn' : 'cursorline cursorcolumn'<CR><CR>

tnoremap <A-Esc> <C-\><C-n>
nnoremap <C-w>m <C-w>_ \| <C-w>\|
nnoremap <Leader>q :q<CR>
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
xmap <C-q> <Plug>(coc-range-select-backward)
nmap <Leader>h :call CocActionAsync('doHover')<CR>
nmap <Leader>j <Plug>(coc-definition)
nmap <Leader>r <Plug>(coc-references)
nmap <Leader>d <Plug>(coc-type-definition)
nmap <Leader>i <Plug>(coc-implementation)
xmap <Leader>mf <Plug>(coc-format-selected)
nmap <Leader>mf <Plug>(coc-format-selected)
xmap <Leader>ma <Plug>(coc-codeaction-selected)
nmap <Leader>ma <Plug>(coc-codeaction-selected)
xmap <Leader>mr <Plug>(coc-codeaction-refactor-selected)
nmap <Leader>mr <Plug>(coc-codeaction-refactor-selected)
nmap <Leader>aa <Plug>(coc-codeaction)
nmap <Leader>af <Plug>(coc-fix-current)
nmap <Leader>an <Plug>(coc-rename)
nmap <Leader>ac <Plug>(coc-codeaction-cursor)
nmap <Leader>as <Plug>(coc-codeaction-source)
nmap <Leader>ar <Plug>(coc-codeaction-refactor)
nmap <Leader>al <Plug>(coc-codelens-action)
nmap <Leader>ah :call CocActionAsync('highlight')<CR>
nnoremap <Leader>t :Vista!!<CR>
nnoremap <Leader>f :KKFiles<CR>
nnoremap <Leader>F :KKFiles! 
nnoremap <Leader>b :KKBuffers<CR>
nnoremap <Leader>c :KKHistory:<CR>
nnoremap <Leader>/ :KKHistory/<CR>
nnoremap <Leader>o :KKHistory<CR>
nnoremap <Leader>s :KKRg <C-r><C-w><CR>
xnoremap <Leader>s y:KKRg '<C-r>"'<CR>
nnoremap <Leader>e :lua MiniFiles.open()<CR>
nnoremap <Leader>gd :silent! lua MiniDiff.toggle_overlay()<CR>
nnoremap <Leader>ge :lua vim.fn.setqflist(MiniDiff.export('qf'))<CR>
nnoremap <Leader>gg :silent! tab Git<CR>
nnoremap <Leader>gl :silent! Flog<CR>
xnoremap <Leader>gl :Flog<Home>silent! <CR>
nnoremap <Leader>gm :silent! GitMessenger<CR>

au BufReadPost * silent! normal g`"
au BufEnter * set formatoptions=ql1j
au FileType c,cpp setlocal commentstring=//\ %s
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Cursor", timeout=300}
hi IncSearch ctermfg=230 ctermbg=160 guifg=#fdf6e3 guibg=#f85552
hi FloatBorder ctermbg=NONE guibg=NONE

lua <<EOF
require('flash').setup {
  highlight = {backdrop = false},
  modes = {
    search = {enabled = false},
    char = {enabled = false},
  },
  prompt = {prefix = {{'卍', 'FlashPromptIcon'}}},
}
vim.keymap.set({'n', 'x', 'o'}, 'ss', function() require("flash").jump() end)
vim.keymap.set({'n', 'x', 'o'}, 'S', function() require("flash").treesitter() end)
vim.keymap.set('o', 'r', function() require("flash").remote() end)
vim.keymap.set({'o', 'x'}, 'R', function() require("flash").treesitter_search() end)
vim.keymap.set('c', '<C-s>', function() require("flash").toggle() end)
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
require('mini.bracketed').setup {comment = {suffix = 'a'}, diagnostic = {suffix = ''}}
require('mini.diff').setup {}
require('mini.files').setup {}
require('mini.move').setup {}
require('mini.surround').setup {}
require('neogen').setup {}
EOF
