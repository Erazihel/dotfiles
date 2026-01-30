-- plugins/snacks.lua
-- Collection of QoL plugins by folke (replaces dressing.nvim for vim.ui.select/input)

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Better vim.ui.input
    input = { enabled = true },
    -- Better vim.ui.select
    picker = { enabled = false },
    -- Notifications
    notifier = { enabled = true },
    -- Other useful features
    bigfile = { enabled = true }, -- Disable features for big files
    quickfile = { enabled = true }, -- Fast file opener
    words = { enabled = true }, -- Highlight word under cursor
  },
  keys = {
    { "]r", function() require("snacks").words.jump(vim.v.count1) end, desc = "Next reference", mode = { "n", "t" } },
    { "[r", function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev reference", mode = { "n", "t" } },
    { "<leader>un", function() require("snacks").notifier.hide() end, desc = "Dismiss all notifications" },
  },
}
