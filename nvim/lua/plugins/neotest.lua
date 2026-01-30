-- plugins/neotest.lua
-- Test runner for Vitest

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
  },
  keys = {
    { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
    { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
    { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest")({}),
      },
      status = {
        virtual_text = true,
      },
      output = {
        open_on_run = false,
      },
    })
  end,
}
