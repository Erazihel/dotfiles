-- config/keymaps.lua - Key mappings

local keymap = vim.keymap.set

-- ============================================================================
-- General Keymaps
-- ============================================================================

-- Clear search highlight
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Save file
keymap("n", "<leader>s", "<cmd>w<CR>", { silent = true, desc = "Save file" })

-- ============================================================================
-- Window Navigation
-- ============================================================================

keymap("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right window" })

-- ============================================================================
-- Window Resizing
-- ============================================================================

keymap("n", "<C-Up>", "<cmd>resize +2<CR>", { silent = true, desc = "Increase window height" })
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", { silent = true, desc = "Decrease window height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { silent = true, desc = "Decrease window width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { silent = true, desc = "Increase window width" })

-- ============================================================================
-- Buffer Navigation
-- ============================================================================

-- Buffer cycling with Shift+h/l (avoiding Ctrl+j/k conflict with window nav)
keymap("n", "<S-h>", "<cmd>bprev<CR>", { silent = true, desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })

-- Close buffer (creates new empty buffer if it's the last one with neo-tree)
keymap("n", "<leader>w", ":BufDelete<CR>", { silent = true, desc = "Close current buffer" })

-- ============================================================================
-- File Navigation (FZF)
-- ============================================================================
-- Note: <leader>f, <leader>b, <leader>H are defined in plugins/fzf.lua

keymap("n", "<leader>G", function()
  require("fzf-lua").live_grep()
end, { silent = true, desc = "Live grep" })

-- ============================================================================
-- Cspell (non-LSP diagnostic tool)
-- ============================================================================
-- Note: LSP keymaps are defined in plugins/lsp.lua via LspAttach autocmd

keymap("n", "<leader>Aw", ":CspellAddWord<CR>", { silent = false, desc = "Add word to cspell" })

-- ============================================================================
-- Visual Mode Enhancements
-- ============================================================================

-- Better indenting (stay in visual mode)
keymap("v", "<", "<gv", { silent = true, desc = "Indent left" })
keymap("v", ">", ">gv", { silent = true, desc = "Indent right" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Repeat last command
keymap("v", ".", ":normal .<CR>", { silent = true, desc = "Repeat last command" })

-- Sort selection
keymap("v", "<C-S>", ":'<,'>sort<CR>", { silent = true, desc = "Sort selection" })

-- ============================================================================
-- Utility
-- ============================================================================

keymap("n", "<leader>k", function()
  require("fzf-lua").keymaps()
end, { silent = true, desc = "Search keymaps" })
keymap("n", "<leader>r", function()
  require("fzf-lua").registers()
end, { silent = true, desc = "Search registers" })

-- Note: <leader>cf is defined in plugins/formatting.lua (lazy-loaded via keys spec)

-- Toggle diagnostics
keymap("n", "<leader>ud", function()
  local enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not enabled)
  vim.notify(enabled and "Diagnostics disabled" or "Diagnostics enabled")
end, { silent = true, desc = "Toggle diagnostics" })

-- ============================================================================
-- Terminal
-- ============================================================================

-- Open terminal in horizontal split
keymap("n", "<C-/>", "<cmd>split | terminal<CR>", { silent = true, desc = "Open terminal" })
keymap("n", "<C-_>", "<cmd>split | terminal<CR>", { silent = true, desc = "Open terminal" })

-- Terminal mode mappings
keymap("t", "<C-\\>", "<C-\\><C-n>", { silent = true, desc = "Exit terminal mode" })
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true, desc = "Move to left window" })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true, desc = "Move to bottom window" })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true, desc = "Move to top window" })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true, desc = "Move to right window" })
