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

" Theme and syntax
Plug 'arcticicestudio/nord-vim'

Plug 'elzr/vim-json'          , {'for': 'json'}
Plug 'othree/html5.vim'       , {'for': 'html'}
Plug 'hail2u/vim-css3-syntax' , {'for': 'css'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx'            , {'for': ['javascript', 'javascript.jsx']}
Plug 'soywod/typescript.vim'  , {'for': ['typescript', 'typescript.jsx']}

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

function! s:grep(args, bang)
  let args = [
    \'--column',
    \'--line-number',
    \'--no-heading',
    \'--fixed-strings',
    \'--ignore-case',
    \'--hidden',
    \'--follow',
    \'--color "always"',
    \'--glob "!.git/*"',
    \shellescape(a:args),
  \]

  call fzf#vim#grep(printf('rg %s', join(args, ' ')), 1, a:bang)
endfunction

" ----------------------------------------------------------------- # Commands #

command! -bang -nargs=* Grep call s:grep(<q-args>, <bang>0)
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
nmap      <leader>P :Prettier<cr>

vnoremap  .     :normal .<cr>

noremap  <expr> <c-j>    pumvisible() ? "\<c-y>" : "\<c-g>u\<c-j>"
inoremap  <expr> <tab>    pumvisible() ? "\<c-n>" : "\<tab>"
inoremap  <expr> <s-tab>  pumvisible() ? "\<c-p>" : "\<s-tab>"

inoremap  <silent> <expr> <c-space>  coc#refresh()
