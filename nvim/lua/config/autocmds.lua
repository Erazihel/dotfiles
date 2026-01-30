-- config/autocmds.lua - Autocommands
--
-- Note: LSP-specific autocommands (LspAttach) are defined in plugins/lsp.lua
--       to maintain tight coupling with LSP configuration

-- Create augroup for organizing autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

    -- Only show float if there are diagnostics on the current line
    local cursor = vim.api.nvim_win_get_cursor(0)
    local diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor[1] - 1 })
    if #diagnostics == 0 then
      return
    end

    vim.diagnostic.open_float(nil, {
      scope = "line",
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
    "grug-far",
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

-- Open SVG files in browser
autocmd({ "BufReadPost", "BufNewFile" }, {
  group = augroup("svg_preview", { clear = true }),
  pattern = "*.svg",
  callback = function(event)
    vim.keymap.set("n", "<leader>Ms", function()
      vim.system({ "open", "-a", "Firefox", vim.api.nvim_buf_get_name(event.buf) })
    end, { buffer = event.buf, silent = true, desc = "Preview SVG in browser" })
  end,
})

-- ============================================================================
-- Buffer Management
-- ============================================================================

-- Smart buffer delete that prevents quitting when neo-tree is open
vim.api.nvim_create_user_command("BufDelete", function()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Warn on unsaved changes instead of letting Vim throw an error
  if vim.bo[current_buf].modified then
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(current_buf), ":t")
    if name == "" then
      name = "[No Name]"
    end
    vim.notify("Buffer '" .. name .. "' has unsaved changes. Save first or use :bdelete!", vim.log.levels.WARN)
    return
  end

  -- Count "real" buffers (listed, loaded, not special)
  local real_bufs = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.api.nvim_buf_is_loaded(buf) then
      local ft = vim.bo[buf].filetype
      if ft ~= "neo-tree" then
        real_bufs = real_bufs + 1
      end
    end
  end

  -- If this is the last real buffer and neo-tree is open, create empty buffer first
  if real_bufs <= 1 then
    local has_neotree = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == "neo-tree" then
        has_neotree = true
        break
      end
    end

    if has_neotree then
      vim.cmd("enew")
      vim.cmd("bdelete! " .. current_buf)
      return
    end
  end

  vim.cmd("bdelete")
end, { desc = "Smart buffer delete" })
