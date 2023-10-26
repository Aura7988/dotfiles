let mapleader = " "

call plug#begin('~/.config/nvim/plugged')
Plug 'Aura7988/anyline'
Plug 'Aura7988/fzf.vim', {'branch': 'dev'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'sainnhe/edge'
	let g:edge_style = 'aura'
	let g:edge_better_performance = 1
Plug 'sakhnik/nvim-gdb'
Plug 'skywind3000/asyncrun.vim'
Plug 'danymat/neogen'
Plug 'mbbill/undotree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kevinhwang91/nvim-bqf'
Plug 'lfv89/vim-interestingwords'
Plug 'justinmk/vim-sneak'
	map f <Plug>Sneak_s
	map F <Plug>Sneak_S
	map t <Plug>Sneak_t
	map T <Plug>Sneak_T
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

xnoremap @ :<C-u>exe ":'<,'>normal @" .. nr2char(getchar())<CR>
nnoremap <C-w>m <C-w>_ \| <C-w>\|
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>
nnoremap <expr> gs '`[' . strpart(getregtype(), 0, 1) . '`]'
vnoremap < <gv
vnoremap > >gv
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

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" jump to the last position
au BufReadPost * if line('`"') <= line('$') | exe 'normal! g`"' | endif
" Disable automatic comment insertion
au BufEnter * set fo-=c fo-=r fo-=o
au FileType c,cpp setlocal commentstring=//\ %s
au FileType crontab setlocal nobackup nowritebackup
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}
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
}
require('mini.ai').setup {}
require('mini.align').setup {
  mappings = {
    start = 'gb',
    start_with_preview = 'gB',
  },
}
require('mini.comment').setup {}
require('mini.move').setup {}
require('mini.surround').setup {}
require('neogen').setup {}
require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '-' },
    topdelete    = { text = '‾' },
    changedelete = { text = 'Ξ' },
    untracked    = { text = '┆' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
    map({'o', 'x'}, 'ih', ':<C-u>Gitsigns select_hunk<CR>')
  end
}
EOF
