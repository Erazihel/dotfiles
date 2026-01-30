-- plugins/which-key.lua
-- Keymap discovery and documentation

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      border = "rounded",
      padding = { 2, 2, 2, 2 },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    -- Only register group prefixes (individual keymaps have their own descriptions)
    wk.add({
      { "<leader>A", group = "Add" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "Git hunks" },
      { "<leader>gt", group = "Git toggles" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>m", group = "Markdown" },
      { "<leader>p", group = "Packages" },
      { "<leader>q", group = "Session" },
      { "<leader>S", group = "Search/Replace" },
      { "<leader>t", group = "Test" },
      { "<leader>cs", group = "Code swap" },
      { "<leader>u", group = "User Interface" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>M", group = "Misc" },
    })
  end,
}
