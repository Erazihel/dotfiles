-- config/autocmds.lua - Autocommands
--
-- Note: LSP-specific autocommands (LspAttach) are defined in plugins/lsp.lua
--       to maintain tight coupling with LSP configuration

-- Create augroup for organizing autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Helper to close Neo-tree windows if present
local function close_neotree()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "neo-tree" then
      pcall(vim.cmd, "Neotree close")
      break
    end
  end
end

-- Wrap :q / :q! to close Neo-tree first
vim.api.nvim_create_user_command("QuitWithTree", function(opts)
  close_neotree()
  vim.cmd("quit" .. (opts.bang and "!" or ""))
end, { bang = true })

vim.cmd([[
  cnoreabbrev <expr> q getcmdtype() == ':' && getcmdline() ==# 'q' ? 'QuitWithTree' : 'q'
  cnoreabbrev <expr> q! getcmdtype() == ':' && getcmdline() ==# 'q!' ? 'QuitWithTree!' : 'q!'
]])

-- ============================================================================
-- LSP Autocommands
-- ============================================================================

-- Show diagnostics in floating window on CursorHold
autocmd("CursorHold", {
  group = augroup("float_diagnostic", { clear = true }),
  callback = function()
    -- Don't open diagnostics in special buffers
    local bufnr = vim.api.nvim_get_current_buf()
    local buftype = vim.bo[bufnr].buftype

    -- Skip special buffers
    if buftype ~= "" then
      return
    end

    vim.diagnostic.open_float(nil, {
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end,
})

-- ============================================================================
-- File Type Specific Settings
-- ============================================================================

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local buftype = vim.bo[bufnr].buftype

    -- Skip special buffers
    if buftype ~= "" then
      return
    end

    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Wrap and check for spell in text filetypes
autocmd("FileType", {
  group = augroup("wrap_spell", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
autocmd("FileType", {
  group = augroup("json_conceal", { clear = true }),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
