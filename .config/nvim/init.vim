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
set laststatus=2
set fillchars=eob:\ 
set shortmess+=WcC
set updatetime=300
" set undofile
set noruler
set noswapfile noautoread
set nobackup nowritebackup
set breakindent
set list listchars=tab:│\ ,trail:•,extends:…,precedes:…,nbsp:␣
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

nnoremap \a :set colorcolumn=<C-R>=empty(&cc) ? '125' : ''<CR><CR>
nnoremap \b :set background=<C-R>=&background == 'dark' ? 'light' : 'dark'<CR><CR>
nnoremap \c :setlocal cursorline!<CR>
nnoremap \d :<C-R>=&diff ? 'diffoff' : 'diffthis'<CR><CR>
nnoremap \h :set hlsearch!<CR>
nnoremap \i :set ignorecase!<CR>
nnoremap \l :setlocal list!<CR>
nnoremap \n :setlocal number!<CR>
nnoremap \r :setlocal relativenumber!<CR>
nnoremap \s :setlocal spell!<CR>
nnoremap \v :set <C-R>=(&virtualedit =~# 'all') ? 'virtualedit-=all' : 'virtualedit+=all'<CR><CR>
nnoremap \w :setlocal wrap!<CR>
nnoremap \x :set <C-R>=(&cursorline && &cursorcolumn) ? 'nocursorline nocursorcolumn' : 'cursorline cursorcolumn'<CR><CR>

nnoremap <C-s> :w<CR>
nnoremap <BS> :bd<CR>
tnoremap <A-[> <C-\><C-n>
tnoremap <expr> <A-;> '<C-\><C-n>"'.nr2char(getchar()).'pi'
nnoremap <C-w><C-s> :horizontal terminal<CR>
nnoremap <C-w><C-v> :vertical terminal<CR>
nnoremap <C-w><C-t> :tab terminal<CR>
nnoremap <C-w>m :-tab split<CR>
nnoremap <expr> gs '`[' . strpart(getregtype(), 0, 1) . '`]'
inoremap <expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : '<TAB>'
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : '<CR>'
inoremap <expr> <C-z> coc#refresh()
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
nmap <C-k> <Plug>(coc-diagnostic-prev)
nmap <C-j> <Plug>(coc-diagnostic-next)
nmap <C-q> <Plug>(coc-range-select)
xmap <C-q> <Plug>(coc-range-select)
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
nnoremap <Leader>mh :call CocActionAsync('doHover')<CR>
nnoremap <Leader>ml :call CocActionAsync('highlight')<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :KKBuffers<CR>
nnoremap <Leader>c :KKHistory:<CR>
nnoremap <Leader>/ :KKHistory/<CR>
nnoremap <Leader>o :KKHistory<CR>
nnoremap <Leader>s :KKRg <C-r><C-w><CR>
xnoremap <Leader>s y:KKRg '<C-r>"'<CR>
nnoremap <Leader>e :lua MiniFiles.open()<CR>
nnoremap <Leader>fc :KKChanges<CR>
nnoremap <Leader>fd :KKColors<CR>
nnoremap <Leader>fe :KKCommands<CR>
nnoremap <Leader>ff :KKFiles<CR>
nnoremap <Leader>fg :KKFiles! 
nnoremap <Leader>fh :KKHelptags<CR>
nnoremap <Leader>fj :KKJumps<CR>
nnoremap <Leader>fk :KKBLines<CR>
nnoremap <Leader>fl :KKLines<CR>
nnoremap <Leader>fm :KKMarks<CR>
nnoremap <Leader>fn :KKMaps<CR>
nnoremap <Leader>fo :KKLocate<CR>
nnoremap <Leader>fr :KKRegisters<CR>
nnoremap <Leader>fs :KKSnippets<CR>
nnoremap <Leader>ft :KKFiletypes<CR>
nnoremap <Leader>fw :KKWindows<CR>
nnoremap <Leader>gb :KKBCommits<CR>
xnoremap <Leader>gb :KKBCommits<CR>
nnoremap <Leader>gc :KKCommits<CR>
nnoremap <Leader>gd :silent! lua MiniDiff.toggle_overlay()<CR>
nnoremap <Leader>ge :lua vim.fn.setqflist(MiniDiff.export('qf'))<CR>
nnoremap <Leader>gg :silent! tab Git<CR>
nnoremap <Leader>gl :silent! Flog<CR>
xnoremap <Leader>gl :Flog<Home>silent! <CR>
nnoremap <Leader>gm :silent! GitMessenger<CR>
nnoremap <Leader>tt :Vista!!<CR>
nnoremap <Leader>ta :KKTags<CR>
nnoremap <Leader>tb :KKBTags<CR>

au BufReadPost * silent! normal g`"
au BufEnter * set formatoptions=ql1j
au FileType c,cpp setlocal commentstring=//\ %s
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Cursor", timeout=300}
hi IncSearch ctermfg=230 ctermbg=160 guifg=#fdf6e3 guibg=#f85552
hi FloatBorder ctermbg=NONE guibg=NONE
hi MiniDiffSignAdd guifg=Green
hi MiniDiffSignChange guifg=#ffcc33
hi MiniDiffSignDelete guifg=Red

lua <<EOF
require('flash').setup {
  highlight = {backdrop = false},
  modes = {char = {enabled = false}},
  prompt = {prefix = {{'卍', 'FlashPromptIcon'}}},
}
vim.keymap.set({'n', 'x', 'o'}, 'ss', function() require("flash").jump() end)
vim.keymap.set({'n', 'x', 'o'}, 'st', function() require("flash").treesitter() end)
vim.keymap.set('o', 'r', function() require("flash").remote() end)
vim.keymap.set({'o', 'x'}, 'sr', function() require("flash").treesitter_search() end)
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
require('mini.bracketed').setup {comment = {suffix = 'a'}, diagnostic = {suffix = ''}, oldfile = {suffix = ''}}
require('mini.diff').setup {}
require('mini.files').setup {}
require('mini.move').setup {}
require('mini.surround').setup {}
require('neogen').setup {}
EOF
