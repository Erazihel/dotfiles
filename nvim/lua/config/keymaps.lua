-- config/keymaps.lua - Key mappings

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- General Keymaps
-- ============================================================================

-- Clear search highlight
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlight" })

-- Save file
keymap("n", "<leader>s", ":w<CR>", { noremap = true, silent = true, desc = "Save file" })

-- ============================================================================
-- Window Navigation
-- ============================================================================

keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })

-- ============================================================================
-- Window Resizing
-- ============================================================================

keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Increase window width" })

-- ============================================================================
-- Buffer Navigation
-- ============================================================================

-- Buffer cycling with Shift+h/l (avoiding Ctrl+j/k conflict with window nav)
keymap("n", "<S-h>", ":bprev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
keymap("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })

-- Close buffer (creates new empty buffer if it's the last one)
keymap("n", "<leader>w", ":bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })

-- ============================================================================
-- File Navigation (FZF)
-- ============================================================================

keymap("n", "<leader>f", ":GFiles<CR>", { noremap = true, silent = true, desc = "Find files" })
keymap("n", "<leader>g", ":Grep ", { noremap = false, silent = false, desc = "Grep search" })
keymap("n", "<leader>b", ":Buffers<CR>", { noremap = true, silent = true, desc = "Find buffers" })
keymap("n", "<leader>h", ":History<CR>", { noremap = true, silent = true, desc = "Recent files" })

-- ============================================================================
-- LSP Keymaps (Standard conventions)
-- ============================================================================
-- Note: Mason package manager keymap (<leader>pm) is defined in plugins/lsp.lua
--       for optimal lazy loading integration

keymap("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })
keymap("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "Go to references" })
keymap("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
keymap("n", "gt", vim.lsp.buf.type_definition, { noremap = true, silent = true, desc = "Go to type definition" })

-- CRITICAL: Hover documentation (was missing!)
keymap("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover documentation" })

-- Signature help in insert mode
keymap("i", "<C-h>", vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "Signature help" })

-- Code actions and refactoring
keymap("n", "<leader>a", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code action" })
keymap("n", "<leader>R", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename symbol" })

-- ============================================================================
-- Diagnostics
-- ============================================================================

keymap("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
keymap("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
keymap("n", "<leader>D", vim.diagnostic.setqflist, { noremap = true, silent = true, desc = "Diagnostics quickfix" })
keymap("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show diagnostic" })
keymap("n", "<leader>Aw", ":CspellAddWord<CR>", { noremap = true, silent = false, desc = "Add word to cspell" })

-- ============================================================================
-- Visual Mode Enhancements
-- ============================================================================

-- Better indenting (stay in visual mode)
keymap("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left" })
keymap("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })

-- Repeat last command
keymap("v", ".", ":normal .<CR>", { noremap = true, silent = true, desc = "Repeat last command" })

-- Sort selection
keymap("v", "<C-S>", ":'<,'>sort<CR>", { noremap = true, silent = true, desc = "Sort selection" })

-- ============================================================================
-- Utility
-- ============================================================================

keymap("n", "<leader>k", ":map<CR>", { noremap = true, silent = true, desc = "Show keymaps" })
keymap("n", "<leader>r", ":registers<CR>", { noremap = true, silent = true, desc = "Show registers" })
