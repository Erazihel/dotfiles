-- core/plugins.lua

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Import avante plugin specification
  -- require("plugins.avante"),

  -- Theme
  { "rmehri01/onenord.nvim" },

  -- LSP & completion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- FZF
  { "junegunn/fzf",                     build = "./install --bin" },
  { "junegunn/fzf.vim" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },

  -- UI
  { "nvim-tree/nvim-web-devicons" },

  -- Lualine
  { "nvim-lualine/lualine.nvim" },

  -- Git
  { "tpope/vim-fugitive" },
  { "airblade/vim-gitgutter" },

  -- Symbols outline replacement
  { "stevearc/aerial.nvim" },

  -- Copilot
  { "github/copilot.vim" },
})
