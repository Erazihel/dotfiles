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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Git
" Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'

" Theme and syntax
Plug 'arcticicestudio/nord-vim'

" Plug 'elzr/vim-json'               , {'for': 'json'}
" Plug 'othree/html5.vim'            , {'for': 'html'}
" Plug 'hail2u/vim-css3-syntax'      , {'for': 'css'}
" Plug 'plasticboy/vim-markdown'     , {'for': 'markdown'}
" Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
" Plug 'mxw/vim-jsx'            , {'for': ['javascript', 'javascript.jsx']}
" Plug 'soywod/typescript.vim'  , {'for': ['typescript', 'typescript.jsx']}
" Plug 'yuezk/vim-js'                , {'for': 'javascript'}
" Plug 'HerringtonDarkholme/yats.vim', {'for': ['typescript', 'typescript.jsx']}
" Plug 'maxmellon/vim-jsx-pretty'    , {'for': ['javascript.jsx', 'typescript', 'typescript.tsx']}

Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-spell-checker', {'do': 'yarn install --frozen-lockfile'}

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
set noswapfile
set nowritebackup
set number
set relativenumber
set ruler
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set scrolloff=3
set shiftwidth=2
set shortmess+=ctT
set signcolumn=yes
set smartcase
set softtabstop=2
set splitbelow
set statusline=%<%f\ %h%m%r%=%=%y\ %-14.(%l,%c-%{strwidth(getline('.'))}%)\ %P
set tabstop=2
set termguicolors
set ttimeoutlen=50
set undodir=~/.config/nvim/undo//
set undofile
set updatetime=300
set viewoptions=cursor,folds,slash,unix
set wildmenu

" --------------------------------------------------------------- # FZF #
" Anchor layout to the bottom of the screen
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8, 'relative': v:true, 'yoffset': 1.0 } }

" Preview window on the upper side of the window with 40% height,
" ctrl-/ to toggle
let g:fzf_preview_window = ['up:60%', 'ctrl-/']
" ---------------------------------------------------------------- # Theme #
colorscheme nord

highlight Error               guibg=#BF616A guifg=#D8DEE9 gui=NONE
highlight ErrorMsg            guibg=NONE    guifg=#BF616A gui=Bold
highlight CocErrorHighlight   guibg=#BF616A guifg=#D8DEE9 gui=NONE
highlight CocErrorSign        guibg=#BF616A guifg=#D8DEE9 gui=NONE
highlight Warning             guibg=#EBCB8B guifg=#D8DEE9 gui=NONE
highlight WarningMsg          guibg=NONE    guifg=#EBCB8B gui=Bold
highlight CocWarningHighlight guibg=#EBCB8B guifg=#616E88 gui=NONE
highlight CocWarningSign      guibg=#EBCB8B guifg=#616E88 gui=NONE

" ---------------------------------------------------------------- # Functions #

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute printf('h %s', expand('<cword>'))
  else
    call CocAction('doHover')
  endif
endfunction

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
augroup end

" ----------------------------------------------------------------- # Mappings #

let mapleader = ' '

nnoremap  <silent>  <leader>n :Explore<cr>
" nnoremap  <silent>  <c-c> :bwipeout<cr>
" nnoremap  <silent>  <a-/> :noh<cr>
nmap      <silent>  <leader>d <plug>(coc-definition)
nmap      <silent>  <leader>r <plug>(coc-references)
nnoremap  <silent>  K     :call <sid>show_documentation()<cr>
" vnoremap  <silent>  <a-s> :'<,'>sort<cr>

nmap      <leader>R <plug>(coc-rename)
nmap      <leader>a <Plug>(coc-codeaction)
nnoremap  <leader>f :GFiles<cr>
nnoremap  <leader>g :Grep 
nnoremap  <leader>h :History<cr>
nnoremap  <leader>b :Buffers<cr>
nnoremap  <leader>w :bd<cr>
nnoremap  <leader>s :w<cr>
nnoremap  <leader>P :Prettier<cr>

vnoremap  .     :normal .<cr>

noremap  <expr> <c-j>    pumvisible() ? "\<c-y>" : "\<c-g>u\<c-j>"
inoremap  <expr> <tab>    pumvisible() ? "\<c-n>" : "\<tab>"
inoremap  <expr> <s-tab>  pumvisible() ? "\<c-p>" : "\<s-tab>"

inoremap  <silent> <expr> <c-space>  coc#refresh()
