-- core/options.lua

local opt = vim.opt
local g = vim.g

opt.syntax = "on"
opt.filetype = "on"

opt.autoindent = true
opt.backspace = { "indent", "eol", "start" }
opt.backup = false
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "noinsert", "menuone", "noselect" }
opt.cursorline = true
opt.expandtab = true
opt.foldenable = false
opt.foldmethod = "indent"
opt.hidden = true
opt.history = 1000
opt.laststatus = 0
opt.linebreak = true
opt.number = true
opt.ruler=false
opt.scrolloff = 3
opt.shiftwidth = 2
opt.shortmess:append("ctT")
opt.showcmd = false
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.softtabstop = 2
opt.splitbelow = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.ttimeoutlen = 50
opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.undofile = true
opt.updatetime = 300
opt.viewoptions = { "curdir", "cursor", "folds" }
opt.wildmenu = true
opt.wildmode = { "longest", "list", "full" }
opt.writebackup = false

-- Leader
g.mapleader = " "
