call plug#begin('~/.config/nvim/plugged')
Plug 'Aura7988/anyline'
Plug 'Aura7988/fzf.vim', {'branch': 'dev'}
Plug 'Aura7988/vim-fugitive', {'branch': 'dev'}
Plug 'sainnhe/edge'
	let g:edge_style = 'aura' | let g:edge_better_performance = 1
Plug 'danymat/neogen'
Plug 'mbbill/undotree'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'main', 'do': ':TSUpdate'}
Plug 'folke/flash.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hedyhli/outline.nvim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'nvim-mini/mini.ai'
Plug 'nvim-mini/mini.align'
Plug 'nvim-mini/mini.bracketed'
Plug 'nvim-mini/mini.diff'
Plug 'nvim-mini/mini.files'
Plug 'nvim-mini/mini.move'
Plug 'nvim-mini/mini.surround'
Plug 'honza/vim-snippets'
call plug#end()

let mapleader = ' '
set background=light
set termguicolors
colorscheme edge
set noshowmode
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait790-blinkoff430-blinkon250
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
set noruler
set noswapfile noautoread
set nobackup nowritebackup
set breakindent
set showbreak=╰➤
set list listchars=tab:│\ ,trail:•,extends:…,precedes:…,nbsp:␣
set completeopt=menuone,noinsert,noselect,popup
set splitkeep=screen
set matchpairs+=<:>
set jumpoptions=stack
set virtualedit=block
set timeoutlen=900
set pumblend=9
set pumheight=9
set tabclose=uselast

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

tnoremap <A-[> <C-\><C-n>
tnoremap <expr> <A-;> '<C-\><C-n>"'.nr2char(getchar()).'pi'
nnoremap <C-w><C-s> :horizontal terminal<CR>
nnoremap <C-w><C-v> :vertical terminal<CR>
nnoremap <C-w><C-t> :tab terminal<CR>
"s- used: adfhnrst F
"ctrl-w unused: ay ABDEGIMVXYZ
nnoremap <C-w><BS> :bd<CR>
nnoremap <C-w>C :tabclose<CR>
nnoremap <C-w>O :tabonly<CR>
nnoremap <C-w>Q :qa<CR>
nnoremap <C-w>U :wa<CR>
nnoremap <C-w>u :up<CR>
nnoremap <C-w>e :q!<CR>
nnoremap <C-w>m :-tab split<CR>
nnoremap <expr> gs '`[' . strpart(getregtype(), 0, 1) . '`]'
inoremap <expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : '<TAB>'
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : '<CR>'
inoremap <expr> <C-z> coc#refresh()
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
nmap <nowait> [d <Plug>(coc-diagnostic-prev)
nmap <nowait> ]d <Plug>(coc-diagnostic-next)
nmap <nowait> <Leader>j <Plug>(coc-definition)
nmap <nowait> <Leader>r <Plug>(coc-references)
nmap <nowait> <Leader>d <Plug>(coc-type-definition)
nmap <nowait> <Leader>i <Plug>(coc-implementation)
xmap <C-s>f <Plug>(coc-format-selected)
nmap <C-s>f <Plug>(coc-format-selected)
xmap <C-s>a <Plug>(coc-codeaction-selected)
nmap <C-s>a <Plug>(coc-codeaction-selected)
xmap <C-s>r <Plug>(coc-codeaction-refactor-selected)
nmap <C-s>r <Plug>(coc-codeaction-refactor-selected)
nmap <C-s>e <Plug>(coc-codeaction-refactor)
nmap <C-s>c <Plug>(coc-codeaction-cursor)
nmap <C-s>i <Plug>(coc-codelens-action)
nmap <C-s>d <Plug>(coc-fix-current)
nmap <C-s>n <Plug>(coc-rename)
nnoremap <C-s>z :call CocActionAsync('fold')<CR>
nnoremap <C-s>h :call CocActionAsync('doHover')<CR>
nnoremap <C-s>l :call CocActionAsync('highlight')<CR>
nnoremap <Leader>b :KKBuffers<CR>
nnoremap <Leader>c :KKHistory:<CR>
nnoremap <Leader>/ :KKHistory/<CR>
nnoremap <Leader>o :KKHistory<CR>
nnoremap <Leader>s :KKRg <C-r><C-w><CR>
xnoremap <Leader>s y:KKRg '<C-r>"'<CR>
nnoremap <Leader>e :lua MiniFiles.open()<CR>
nnoremap <Leader>fc :KKChanges<CR>
nnoremap <Leader>fe :KKCommands<CR>
nnoremap <Leader>ff :KKFiles<CR>
nnoremap <Leader>fg :KKFiles 
nnoremap <Leader>fh :KKHelptags<CR>
nnoremap <Leader>fj :KKJumps<CR>
nnoremap <Leader>fk :KKBLines<CR>
nnoremap <Leader>fl :KKLines<CR>
nnoremap <Leader>fm :KKMarks<CR>
nnoremap <Leader>fr :KKRegisters<CR>
nnoremap <Leader>ga :GAnnotation<CR>
nnoremap <Leader>gd :lua MiniDiff.toggle_overlay()<CR>
nnoremap <Leader>ge :lua vim.fn.setloclist(0, MiniDiff.export('qf'))<CR>:lopen<CR>
nnoremap <Leader>gg :tab Git<CR>
nnoremap <Leader>gk :<C-u>Flog -- %<CR>
nnoremap         gl :Flog<CR>
xnoremap         gl :Flog<CR>
nnoremap <Leader>tt :Outline<CR>
nnoremap <Leader>ta :KKTags<CR>
nnoremap <Leader>tb :KKBTags<CR>

au BufReadPost * silent! normal g`"
au BufEnter * set formatoptions=ql1j
au TextPutPost,TextYankPost * silent! lua vim.hl.hl_op {higroup='Yanked', timeout=300}
au FileType git set foldmethod=syntax
hi Yanked cterm=underline ctermfg=Blue gui=underline guifg=Blue
hi IncSearch ctermfg=230 ctermbg=203 guifg=#fdf6e3 guibg=#f85552
hi CocHighlightText ctermbg=221 guibg=#ffcc33
hi FloatBorder ctermbg=NONE guibg=NONE

lua <<EOF
require('flash').setup {modes = {char = {enabled = false}}, prompt = {prefix = {{'卍', 'FlashPromptIcon'}}}}
vim.keymap.set({'n', 'x', 'o'}, 'ss', function() require("flash").jump() end)
vim.keymap.set({'n', 'x', 'o'}, 'st', function() require("flash").treesitter() end)
vim.keymap.set('o', 'r', function() require("flash").remote() end)
vim.keymap.set({'o', 'x'}, 'sr', function() require("flash").treesitter_search() end)
vim.keymap.set('c', '<C-s>', function() require("flash").toggle() end)
require('nvim-treesitter').setup {install_dir = vim.fn.stdpath('config') .. '/ts-parsers'}
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'*'},
  callback = function(ev)
    local ok, stats = pcall(vim.uv.fs_stat, ev.file)
    if ok and stats and stats.size < 3145728 then
      pcall(vim.treesitter.start)
    end
  end,
})
require('outline').setup {providers = {priority = {'lsp', 'coc', 'markdown', 'norg', 'man', 'asciidoc', 'treesitter', 'ctags'}}}
require('mini.ai').setup {}
require('mini.align').setup {mappings = {start = 'gb', start_with_preview = 'gB'}}
require('mini.bracketed').setup {comment = {suffix = 'a'}, diagnostic = {suffix = ''}, oldfile = {suffix = ''}}
require('mini.diff').setup {options = {wrap_goto = true}}
require('mini.files').setup {mappings = {go_in = '.', go_in_plus = 'g.', go_out = ',', go_out_plus = 'g,'}}
require('mini.move').setup {}
require('mini.surround').setup {}
require('neogen').setup {}
EOF
