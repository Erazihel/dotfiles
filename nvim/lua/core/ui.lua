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
