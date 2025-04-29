-- plugins/lualine.lua

-- Helper function for displaying the progress
function _G.GetProgress()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  local progress = total_lines > 0 and (current_line * 100 / total_lines) or 0
  local position = current_line == 1 and "Top" or (current_line == total_lines and "Bot" or "")

  if position ~= "" then
    return position .. "/" .. total_lines
  end

  local padded_progress = string.format("%2d", progress)

  return padded_progress .. "%/" .. total_lines
end

-- Lualine sections configuration
local sections_config = {
  lualine_a = { { 'mode', fmt = function(res) return '◎' end } },
  lualine_b = {
    { 'diff', symbols = { added = '󰜄 ', modified = '󱔀 ', removed = '󰛲 ' } },
    'diagnostics',
  },
  lualine_c = { { 'filename', path = 1 } },
  lualine_x = {},
  lualine_y = { 'location' },
  lualine_z = { 'progress' },
}

-- Winbar configuration (file path and breadcrumbs)
local winbar_config = {
  lualine_a = {},
  lualine_b = { { 'filetype', icon_only = true, separator = '' }, 'filename' },
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {}
}

-- Setup Lualine with the sections and winbar configuration
require('lualine').setup({
  inactive_sections = sections_config,
  inactive_winbar = winbar_config,
  sections = sections_config,
  winbar = winbar_config
})
