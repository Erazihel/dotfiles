syntax on
filetype plugin indent on

" ------- # Plugins # -------

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

" Wilder
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'
endif

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


" Symbols Outline
Plug 'liuchengxu/vista.vim'

call plug#end()

" ------- # Settings # -------

set autoindent
set backspace=indent,eol,start
set breakindent
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set expandtab
set foldmethod=indent
set hidden
set history=1000
set laststatus=2
set linebreak
set nobackup
set nofoldenable
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
set viewoptions=curdir,cursor,folds
set wildmenu
set wildmode=longest,list,full

" ------- # Coc Extensions # -------

let g:coc_global_extensions = [
\   'coc-eslint',
\   'coc-git',
\   'coc-html',
\   'coc-json',
\   'coc-nav',
\   'coc-prettier',
\   'coc-sh',
\   'coc-spell-checker',
\   'coc-tsserver',
\ ]

" ------- # Theme # -------

highlight DevIconTsx  guifg=#61dbfb

" ------- # FZF # -------

" Anchor layout to the bottom of the screen
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8, 'relative': v:true, 'yoffset': 1.0 } }

" Preview window on the upper side of the window with 40% height,
" ctrl-/ to toggle
let g:fzf_preview_window = ['up:60%', 'ctrl-/']

" ------- # Vista # -------

let g:vista_default_executive = 'coc'

let g:vista_fzf_preview = ['right:50%']

" ------- # Wilder # -------

call wilder#setup({'modes': [':', '/', '?']})

" 'border'            : 'single', 'double', 'rounded' or 'solid'
"                     : can also be a list of 8 characters,
"                     : see :h wilder#popupmenu_border_theme() for more details
" 'highlights.border' : highlight to use for the border`
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'highlights': {
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
      \   'border': 'Normal',
      \ },
      \ 'border': 'rounded',
      \ 'min_width': '100%',
      \ })))

" -------- # Custom Color Scheme # -------

lua <<EOF

local colors = require("onenord.colors").load()

require("onenord").setup({
  custom_highlights = {
    ["Special"] = { fg = colors.cyan },
    -- ["TSInclude"] = { fg = colors.yellow },
    ["Function"] = { fg = colors.yellow },
  },
  custom_colors = {
    diff_add_bg = '#689940',
    diff_change_bg = '#d9a821',
    diff_remove_bg = colors.red,
    diff_change = colors.yellow,
    info = colors.blue,
    warn = colors.yellow,
  },
})

EOF

" -------- # LuaLine # -------

lua <<EOF

function breadcrumbs()
  local items = vim.b.coc_nav

  local t = {''}

  local highlight_icon_mapping = {
    CocSymbolArray      = '',
    CocSymbolClass      = '',
    CocSymbolEnum       = '',
    CocSymbolField      = '',
    CocSymbolFunction   = '󰊕',
    CocSymbolInterface  = '',
    CocSymbolMethod     = '',
    CocSymbolModule     = '',
    CocSymbolProperty   = '',
    CocSymbolString     = '',
    CocSymbolVariable   = ''
  }

  local highlight_icon_color_mapping = {
    CocSymbolArray      = 'CocListFgBlue',
    CocSymbolClass      = 'CocListFgRed',
    CocSymbolEnum       = 'CocListFgCyan',
    CocSymbolField      = 'CocListFgYellow',
    CocSymbolFunction   = 'CocListFgYellow',
    CocSymbolInterface  = 'CocListFgYellow',
    CocSymbolMethod     = 'CocListFgYellow',
    CocSymbolModule     = 'CocListFgYellow',
    CocSymbolProperty   = 'CocListFgYellow',
    CocSymbolString     = 'CocListFgGreen',
    CocSymbolVariable   = 'CocListFgMagenta'
  }

  for k, v in ipairs(items) do
    setmetatable(v, {
      __index = function(table, key)
        return ' '
      end
    })

    local icon = highlight_icon_mapping[v.highlight] or v.highlight or ''

    local icon_color = highlight_icon_color_mapping[v.highlight] or ''

    t[#t+1] = '%#' .. icon_color .. '#' .. icon .. ' %#' .. v.highlight .. '#' .. v.name 

    if next(items,k) ~= nil then
      t[#t+1] = '%#CocListFgCyan# > '
    end
  end

  return table.concat(t)
end

local sections_config = {
  lualine_a = {{'mode', fmt = function(res) return '◎' end}},
  lualine_b = {
    { 'diff', symbols = {added = '󰜄 ', modified = '󱔀 ', removed = '󰛲 '} },
    'diagnostics',
  },
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

" -------- # Treesiter # -------

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

" -------- # Functions # -------

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

" --------- # Commands # -------

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

" --------- # Mappings # -------

let mapleader = ' '

nnoremap  <leader>b   :Buffers<cr>
nnoremap  <leader>f   :GFiles<cr>
nnoremap  <leader>g   :Grep 
nnoremap  <leader>h   :History<cr>
nnoremap  <leader>k   :map<cr>
nnoremap  <leader>n   :Explore<cr>
nnoremap  <leader>o   :Vista!!<cr>
nnoremap  <leader>r   :registers<cr>
nnoremap  <leader>s   :w<cr>
nnoremap  <leader>w   :bd<cr>
nnoremap  <C-j>       :bprev<cr>
nnoremap  <C-k>       :bnext<cr>

nnoremap  <leader>D   :CocDiagnostics<cr>
nnoremap  <leader>d   <Plug>(coc-definition)
nnoremap  <leader>R   <Plug>(coc-rename)
nnoremap  <leader>a   <Plug>(coc-codeaction)
nnoremap  <leader>P   <Plug>(coc-format)
nnoremap  <C-p>       <Plug>(coc-diagnostic-prev)
nnoremap  <C-n>       <Plug>(coc-diagnostic-next)

nnoremap  <leader>Gd  :Git diff<cr>
nnoremap  <leader>Gb  :Git blame<cr>
nnoremap  <leader>Gm  :Git mergetool<cr>
nnoremap  <leader>Gkb <Plug>(coc-git-keepboth)
nnoremap  <leader>Gkc <Plug>(coc-git-keepcurrent)
nnoremap  <leader>Gki <Plug>(coc-git-keepincoming)
nnoremap  <leader>Gn  <Plug>(coc-git-nextconflict)
nnoremap  <leader>Gp  <Plug>(coc-git-prevconflict)

vnoremap  .             :normal .<cr>
vnoremap  <silent><C-S> :'<,'>sort<cr>

" Tab navigation on autocompletion
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Change tab autocomplete for GitHub Copilot
imap <silent><script><expr> <Right> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

imap <silent><M-Right> <Plug>(copilot-accept-word)
imap <M-]> <Plug>(copilot-next)
imap <M-[> <Plug>(copilot-previous)

