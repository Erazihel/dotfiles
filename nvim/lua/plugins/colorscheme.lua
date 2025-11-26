-- plugins/colorscheme.lua

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- Load during startup since it's the colorscheme
  priority = 1000, -- Load before other plugins
  config = function()
    require("catppuccin").setup({
      auto_integrations = true,
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
    })

    -- Apply colorscheme
    vim.cmd.colorscheme("catppuccin")
  end,
}
