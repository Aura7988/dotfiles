let mapleader = " "

call plug#begin('~/.config/nvim/plugged')
Plug 'Aura7988/anyline'
Plug 'rcarriga/nvim-notify'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sainnhe/edge'
	let g:edge_style = 'aura'
	let g:edge_better_performance = 1
Plug 'sakhnik/nvim-gdb', {'do': ':!./install.sh'}
Plug 'skywind3000/asyncrun.vim'
Plug 'voldikss/vim-floaterm'
	let g:floaterm_title = ''
	let g:floaterm_position = 'topright'
	let g:floaterm_borderchars = '─│─│╭╮╯╰'
	let g:floaterm_keymap_toggle = '<F2>'
	let g:floaterm_opener = 'vsplit'
Plug 'danymat/neogen'
Plug 'mbbill/undotree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
Plug 'kevinhwang91/nvim-bqf'
Plug 'lfv89/vim-interestingwords'
Plug 'justinmk/vim-sneak'
	map f <Plug>Sneak_s
	map F <Plug>Sneak_S
	map t <Plug>Sneak_t
	map T <Plug>Sneak_T
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
	let g:vista#renderer#enable_icon = 0
Plug 'ibhagwan/fzf-lua'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
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

nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>
nnoremap <expr> gs '`[' . strpart(getregtype(), 0, 1) . '`]'
vnoremap < <gv
vnoremap > >gv
inoremap <expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : "\<TAB>"
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
inoremap <expr> <C-z> coc#refresh()
nmap <Leader>j :call CocActionAsync('doHover')<CR>
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
nmap <C-k> <Plug>(coc-diagnostic-prev)
nmap <C-j> <Plug>(coc-diagnostic-next)
nmap <Leader>g <Plug>(coc-definition)
nmap <Leader>r <Plug>(coc-references)
nmap <leader>R <Plug>(coc-rename)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
nnoremap <Leader>t :Vista!!<CR>
nnoremap <Leader>f :FzfLua files <C-r>=GitRoot()<CR><CR>
nnoremap <Leader>F :FzfLua files cwd=
nnoremap <Leader>b :FzfLua buffers<CR>
nnoremap <Leader>c :FzfLua command_history<CR>
nnoremap <Leader>/ :FzfLua search_history<CR>
nnoremap <Leader>l :FzfLua oldfiles<CR>
nnoremap <Leader>s :FzfLua grep_cword <C-r>=GitRoot()<CR><CR>
xnoremap <Leader>s :<C-u>FzfLua grep_visual <C-r>=GitRoot()<CR><CR>
nnoremap <Leader>e :CocCommand explorer<CR>
" nnoremap <TAB> <C-w>w
" nnoremap <S-TAB> <C-w>W
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

command! -nargs=0 NNN FloatermNew nnn
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)

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
require('fzf-lua').setup {
  registers = {
    actions = {
      ["@"] = function(selected)
        local keys = '@'..string.sub(selected[1], 2, 2)
        vim.api.nvim_feedkeys(keys, "x", false)
      end,
    },
  },
}
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = 'Ξ', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    untracked    = {hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
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
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
vim.notify = require("notify")
vim.notify.setup {
  stages = "fade_in_slide_out",
  timeout = 3000,
}
EOF
