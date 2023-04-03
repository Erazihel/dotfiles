syntax on
filetype plugin indent on

call plug#begin()

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'

" Lua
Plug 'nvim-lua/plenary.nvim'

" Theme and syntax
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
" Plug 'arcticicestudio/nord-vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

" Telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

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

" ---------------------------------------------------------------- # Theme #

colorscheme onenord

highlight link  TelescopeMatching       NvimString
" highlight link  TelescopePreviewTitle Search
" highlight link  TelescopeResultsTitle Search
" highlight link  TelescopePromptTitle  Search

highlight DevIconTsx  guifg=#61dbfb

" --------------------------------------------------------------- # FZF #
" Anchor layout to the bottom of the screen
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8, 'relative': v:true, 'yoffset': 1.0 } }

" Preview window on the upper side of the window with 40% height,
" ctrl-/ to toggle
let g:fzf_preview_window = ['up:60%', 'ctrl-/']

" ---------------------------------------------------------------- # Lua Plugins #

lua <<EOF

function breadcrumbs()
  local items = vim.b.coc_nav

  local t = {''}

  local highlight_icon_mapping = {
    CocSymbolFunction = '󰊕',
    CocSymbolProperty = '',
    CocSymbolVariable = ''
  }

  local highlight_icon_color_mapping = {
    CocSymbolFunction = 'CocListFgYellow',
    CocSymbolProperty = 'CocListFgCyan',
    CocSymbolVariable = 'CocListFgMagenta'
  }


  for k, v in ipairs(items) do
    setmetatable(v, {
      __index = function(table, key)
        return ' '
      end
    })

    local icon = highlight_icon_mapping[v.highlight] or v.highlight or ''

    local icon_color = highlight_icon_color_mapping[v.highlight] or ''

    t[#t+1] = '%#' .. icon_color .. '#' .. icon .. ' %#Normal#' .. v.name

    if next(items,k) ~= nil then
      t[#t+1] = '%#CocListFgCyan# > '
    end
  end

  return table.concat(t)
end

local sections_config = {
  lualine_a = {{'mode', fmt = function(res) return '◎' end}},
  lualine_b = {'branch', {'diff', symbols = {added = '󰜄 ', modified = '󱔀 ', removed = '󰛲 '}}, 'diagnostics'},
  lualine_c = {{'filename', path = 1}},
  lualine_x = {},
  lualine_y = {'location'},
  lualine_z = {'%{GetProgress()}'}
}

local winbar_config = {
  lualine_a = {},
  lualine_b = {{'filetype', icon_only = true, separator = ''}, 'filename'},
  lualine_c = {breadcrumbs},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {}
}

require('lualine').setup({
  inactive_sections = sections_config,
  inactive_winbar = winbar_config,
  sections = sections_config,
  winbar = winbar_config
})

EOF

" ---------------------------------------------------------------- # Telescope #

lua <<EOF

local actions = require("telescope.actions")

require('telescope').setup({
  defaults = {
    layout_config = {vertical = {width = 0.9, height = 0.9, preview_height = 0.5, preview_cutoff = 0}},
    layout_strategy = "vertical",
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
})

EOF

" ---------------------------------------------------------------- # Treesiter #

lua <<EOF

require('nvim-treesitter.configs').setup({
  auto_install = true,
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "gitignore",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "regex",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "yaml"
  },
  highlight = {
    enable = true,
  }
})

EOF

" ---------------------------------------------------------------- # Functions #

function! GetProgress()
  let current_line = line('.')
  let total_lines = line('$')
  let progress = total_lines > 0 ? (current_line * 100 / total_lines) : 0
  let position = current_line == 1 ? "Top" : (current_line == total_lines ? "Bot" : "")

  if position != ""
    return position .. "/" .. total_lines
  endif

  let padded_progress = repeat(' ', 2 - len(string(progress))) . progress

  return padded_progress .. "%/" .. total_lines
endfunction

" ----------------------------------------------------------------- # Commands #

command! -bang -nargs=* Grep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --hidden --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

augroup dotfiles
  autocmd!
  autocmd CursorHold  *   silent call CocActionAsync('highlight')
  autocmd FileType    *   setlocal fo-=c fo-=r fo-=o
  autocmd FileType    qf  wincmd J
augroup end

" ----------------------------------------------------------------- # Mappings #

let mapleader = ' '

nnoremap  <leader>b   :Buffers<cr>
nnoremap  <leader>f   :GFiles<cr>
nnoremap  <leader>g   :Grep 
nnoremap  <leader>h   :History<cr>
nnoremap  <leader>n   :Explore<cr>

nnoremap  <leader>d   <plug>(coc-definition)
nnoremap  <leader>R   <plug>(coc-rename)
nnoremap  <leader>a   <plug>(coc-codeaction)
nnoremap  <leader>P   <plug>(coc-format)
nnoremap  <leader>k   <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap  <leader>r   <cmd>lua require('telescope.builtin').registers()<cr>

nnoremap  <leader>s   :w<cr>
nnoremap  <leader>w   :bd<cr>

nnoremap  <leader>Gd  :Git diff<cr>
nnoremap  <leader>Gb  :Git blame<cr>

vnoremap  .             :normal .<cr>
vnoremap  <silent><c-s> :'<,'>sort<cr>

" Tab navigation on autocompletion
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
