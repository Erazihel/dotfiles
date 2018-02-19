syntax on
filetype plugin indent on

call plug#begin()

" LSP Client
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

" ALE
Plug 'jaawerth/nrun.vim'
Plug 'w0rp/ale'

" Completion
Plug 'roxma/nvim-completion-manager'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Theme
Plug 'rakr/vim-one'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'arcticicestudio/nord-vim'

" Git
Plug 'airblade/vim-gitgutter'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" Utilities
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'

call plug#end()

set background=light
set backspace=indent,eol,start
set breakindent
set clipboard+=unnamedplus,unnamed
set completeopt+=menu
set expandtab
set foldcolumn=2
set history=1000
set hlsearch
set ignorecase
set incsearch
set linebreak
set nobackup
set noswapfile
set ruler
set scrolloff=3
set shiftwidth=2
set smartcase
set softtabstop=2
set splitright
set tabstop=2
set termguicolors
set ttimeoutlen=50
set t_Co=256

" Theme ---------------------------------------------------------------------------------

colorscheme nord

hi clear FoldColumn
hi clear SignColumn

let g:airline_powerline_fonts = 1

" Auto commands --------------------------------------------------------------------------

au FileType qf wincmd J
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" LanguageClient ------------------------------------------------------------------------

let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = 'fzf'
let g:LanguageClient_serverCommands = {
  \ 'javascript': ['flow-language-server', '--stdio'],
  \ 'javascript.jsx': ['flow-language-server', '--stdio'],
  \ 'typescript': ['javascript-typescript-stdio'],
  \ }

" ESLint ---------------------------------------------------------------------------------

let g:eslint_path = nrun#Which('eslint')
let eslint_is_active = (g:eslint_path != 'eslint not found')

" Prettier -------------------------------------------------------------------------------

let g:prettier_path = nrun#Which('prettier')
let prettier_is_active = (g:prettier_path != 'prettier not found')

" JavaScript -----------------------------------------------------------------------------

let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

" ALE ------------------------------------------------------------------------------------

let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_linter_aliases = {'javascript.jsx': 'javascript'}
let g:ale_fixers_aliases = {'javascript.jsx': 'javascript'}
let g:ale_linters = {'javascript': []}
let g:ale_fixers = {'javascript': []}

if (eslint_is_active)
  let g:ale_javascript_eslint_executable = g:eslint_path
  let g:ale_linters.javascript = g:ale_linters.javascript + ['eslint']
endif

if (prettier_is_active)
  let g:ale_javascript_prettier_executable = g:prettier_path
  let g:ale_javascript_prettier_options = '--single-quote --print-width 100 --no-bracket-spacing false --use-tabs true'
  let g:ale_fixers.javascript = g:ale_fixers.javascript + ['prettier']
endif

" SuperTab -------------------------------------------------------------------------------

let g:SuperTabDefaultCompletionType = '<C-n>'

" UltiSnips ------------------------------------------------------------------------------

let g:UltiSnipsExpandTrigger = '<C-b>'
let g:UltiSnipsJumpForwardTrigger = '<C-b>'
let g:UltiSnipsSnippetDirectories = ['snips']

" Functions ------------------------------------------------------------------------------

function ToggleQfList()
  if (filter(getwininfo(), 'v:val.quickfix') == [])
    :copen
  else
    :cclose
  endif
endfunction

function ToggleLocList()
  if (getloclist('.') != [])
    if (filter(getwininfo(), 'v:val.loclist') == [])
      :lopen
    else
      :lclose
    endif
  endif
endfunction

function PrevListItem()
  if (getqflist() != [])
    :cprevious
  elseif (getloclist('.') != [])
    :lprevious
  endif
endfunction

function NextListItem()
  if (getqflist() != [])
    :cnext
  elseif (getloclist('.') != [])
    :lnext
  endif
endfunction

function Save()
  :w
endfunction

" Mapping --------------------------------------------------------------------------------

let mapleader = ' '

nnoremap <leader>s :call Save()<CR>
nnoremap <silent> <leader>n :Explore<CR>

nnoremap <leader>g :Ag
nnoremap <silent> <leader>f :GFiles<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>P :ALEFix<CR>
nnoremap <silent> <leader>w :bd<CR>

nnoremap <leader>v :call LanguageClient_textDocument_hover()<CR>
nnoremap <leader>d :call LanguageClient_textDocument_definition()<CR>
nnoremap <leader>r :call LanguageClient_textDocument_rename()<CR>

nnoremap <silent> <leader>c :call ToggleQfList()<CR>
nnoremap <silent> <leader>l :call ToggleLocList()<CR>

nnoremap <silent> [[ :call PrevListItem()<CR>
nnoremap <silent> ]] :call NextListItem()<CR>
