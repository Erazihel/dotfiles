-- config/options.lua - Neovim options and settings

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = false -- Absolute line numbers only

-- Indentation
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.smartindent = true
opt.breakindent = true

-- Search
opt.smartcase = true
opt.ignorecase = true -- Ignore case when searching (works with smartcase)
opt.hlsearch = true -- Highlight search results

-- UI
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 3
opt.sidescrolloff = 8
opt.wrap = false -- Don't wrap long lines
opt.linebreak = true

-- Statusline and command line
opt.laststatus = 3 -- Global statusline (modern approach)
opt.showcmd = false
opt.showmode = false
opt.cmdheight = 1

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10 -- Popup menu height
opt.pumblend = 0 -- Popup menu transparency

-- Files and backups
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"

-- Folding
opt.foldenable = false
opt.foldmethod = "indent"

-- Misc
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a" -- Enable mouse support
opt.hidden = true -- Enable background buffers
opt.history = 1000
opt.updatetime = 300 -- Faster completion and diagnostics
opt.timeoutlen = 300 -- Faster mapped sequence timeout
opt.ttimeoutlen = 50
opt.backspace = { "indent", "eol", "start" }
opt.wildmenu = true
opt.wildmode = { "longest", "list", "full" }
opt.shortmess:append("cI") -- Don't show completion messages and intro
opt.viewoptions = { "curdir", "cursor", "folds" }
opt.conceallevel = 0 -- Don't hide quotes in JSON
opt.fileencoding = "utf-8"

-- Performance
opt.lazyredraw = false -- Don't redraw while executing macros (can cause issues)
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.showtabline = 0 -- Never show tabline (bufferline disabled)
