syntax on
filetype plugin indent on

call plug#begin()

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-neco', {'for': 'vim'}
Plug 'shougo/neco-vim'  , {'for': 'vim'}

" Fuzzy Finder
Plug 'junegunn/fzf'     , {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

" Utilities
Plug 'mattn/emmet-vim'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
Plug 'numToStr/Comment.nvim'

" Registers
Plug 'gennaro-tedesco/nvim-peekup'

" Terminal
Plug 'voldikss/vim-floaterm'

" Git
Plug 'tpope/vim-fugitive'

" Lua
Plug 'nvim-lua/plenary.nvim'

" Theme and syntax
Plug 'arcticicestudio/nord-vim'

" Icons
Plug 'nvim-tree/nvim-web-devicons'

" Coc Plugins
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-spell-checker', {'do': 'yarn install --frozen-lockfile'}

" Line
Plug 'nvim-lualine/lualine.nvim'

" Testing
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

call plug#end()

" ---------------------------------------------------------------- # Settings #

set autoindent
set hidden
set autoindent
set background=dark
set backspace=indent,eol,start
set breakindent
set clipboard=unnamedplus
set cmdheight=2
set completeopt=noinsert,menuone,noselect
set cursorline
set expandtab
set foldlevelstart=99
set foldmethod=syntax
set foldtext=getline(v:foldstart)
set hidden
set history=1000
set laststatus=2
set linebreak
set nobackup
set noshowmode
set noswapfile
set nowritebackup
set number
set relativenumber
set ruler
set scrolloff=3
set shiftwidth=2
set shortmess+=ctT
set signcolumn=yes
set smartcase
set softtabstop=2
set splitbelow
set tabstop=2
set termguicolors
set ttimeoutlen=50
set undodir=~/.config/nvim/undo//
set undofile
set updatetime=300
set viewoptions=cursor,folds,slash,unix
set wildmenu

" ---------------------------------------------------------------- # FZF #
" Anchor layout to the bottom of the screen
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8, 'relative': v:true, 'yoffset': 1.0 } }

" Preview window on the upper side of the window with 40% height,
" ctrl-/ to toggle
let g:fzf_preview_window = ['up:60%', 'ctrl-/']

" ---------------------------------------------------------------- # Registers Plugin #
let g:peekup_open = '<leader>r'

" ---------------------------------------------------------------- # Floaterm Plugin#
let g:floaterm_title = ''
let g:floaterm_keymap_toggle = '<leader>\'
let g:floaterm_height = 0.8
let g:floaterm_width = 0.8

" ---------------------------------------------------------------- # Lua Plugins #
lua require('Comment').setup()

lua sections_config = {
\   lualine_a = { { 'mode', fmt = function(res) return '◎' end } },
\   lualine_b = {'branch', { 'diff', symbols = { added = '󰜄 ', modified = '󱔀 ', removed = '󰛲 ' } }, 'diagnostics'},
\   lualine_c = { { 'filename', path = 1 } },
\   lualine_x = { { 'filetype', colored = false } },
\   lualine_y = {'location'},
\   lualine_z = {'%p%%/%L'}
\ }

lua winbar_config = {
\   lualine_a = {},
\   lualine_b = { { 'filetype', colored = false, icon_only = true, separator = '' }, 'filename' },
\   lualine_c = {},
\   lualine_x = {},
\   lualine_y = {},
\   lualine_z = {}
\ }

lua require('lualine').setup({
\   inactive_sections = sections_config,
\   inactive_winbar = winbar_config,
\   sections = sections_config,
\   winbar = winbar_config
\ })

" ---------------------------------------------------------------- # Theme #

colorscheme nord

highlight Error               guibg=#BF616A guifg=#D8DEE9 gui=NONE
highlight ErrorMsg            guibg=NONE    guifg=#BF616A gui=Bold
highlight CocErrorHighlight   guibg=NONE    guifg=#BF616A gui=Underline
highlight CocErrorSign        guibg=NONE    guifg=#BF616A gui=None
highlight Warning             guibg=#EBCB8B guifg=#D8DEE9 gui=NONE
highlight WarningMsg          guibg=NONE    guifg=#EBCB8B gui=Bold
highlight CocWarningHighlight guibg=NONE    guifg=#EBCB8B gui=Underline
highlight CocWarningSign      guibg=NONE    guifg=#EBCB8B gui=NONE

" ----------------------------------------------------------------- # Commands #

command! -bang -nargs=* Grep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

augroup dotfiles
  autocmd!
  autocmd CursorHold  *   silent call CocActionAsync('highlight')
  autocmd FileType    *   setlocal fo-=c fo-=r fo-=o
  autocmd FileType    qf  wincmd J
  autocmd FileType    html,css,scss,less,javascript*,typescript*  EmmetInstall
  autocmd VimEnter    * if exists(':FloatermNew') | execute "FloatermNew --cwd=<root>" | execute "FloatermHide" | stopinsert | endif
augroup end

" ----------------------------------------------------------------- # Mappings #

let mapleader = ' '

nnoremap  <leader>n   :Explore<cr>
nnoremap  <leader>d   <plug>(coc-definition)
nnoremap  <leader>R   <plug>(coc-rename)
nnoremap  <leader>a   <Plug>(coc-codeaction)
nnoremap  <leader>f   :GFiles<cr>
nnoremap  <leader>g   :Grep 
nnoremap  <leader>h   :History<cr>
nnoremap  <leader>b   :Buffers<cr>
nnoremap  <leader>w   :bd<cr>
nnoremap  <leader>s   :w<cr>
nnoremap  <leader>P   :Prettier<cr>
nnoremap  <leader>\   :FloatermToggle --cwd=<root><cr>
nnoremap  <leader>gd  :Git diff<cr>

vnoremap  .     :normal .<cr>
