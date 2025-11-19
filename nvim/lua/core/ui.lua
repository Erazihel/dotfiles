-- core/ui.lua

-- Set theme
vim.cmd("colorscheme onenord")

local colors = require("onenord.colors").load()

require("onenord").setup({
  custom_highlights = {
    ["Special"] = { fg = colors.cyan },
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

-- FZF configuration
vim.g.fzf_layout = {
  window = {
    width = 1,
    height = 0.8,
    relative = true,
    yoffset = 1.0,
  },
}

vim.g.fzf_preview_window = { "up:60%", "ctrl-/" }

-- Override vim.ui.select to show popup for Code Actions
vim.ui.select = function(items, opts, on_choice)
  if vim.tbl_isempty(items) then return on_choice(nil, nil) end

  local lines = {}
  for i, item in ipairs(items) do
    lines[i] = string.format("[%d] %s", i, opts.format_item and opts.format_item(item) or tostring(item))
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  local width = math.min(80, vim.o.columns - 10)
  local height = math.min(#lines + 2, 20)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = 'minimal',
    border = 'rounded',
    title = " " .. (opts.prompt or "Select"):gsub(":?%s*$", "") .. " ",
    title_pos = 'center',
  })

  local function close(choice)
    pcall(vim.api.nvim_win_close, win, true)
    pcall(vim.api.nvim_buf_delete, buf, { force = true })
    on_choice(choice and items[choice] or nil, choice)
  end

  local keymaps = {
    ['<CR>'] = function() close(vim.api.nvim_win_get_cursor(win)[1]) end,
    ['<Esc>'] = function() close() end,
    ['q'] = function() close() end,
  }

  for key, fn in pairs(keymaps) do
    vim.keymap.set('n', key, fn, { buffer = buf, nowait = true })
  end

  for i = 1, math.min(9, #items) do
    vim.keymap.set('n', tostring(i), function() close(i) end, { buffer = buf, nowait = true })
  end
end
