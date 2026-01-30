-- plugins/search-replace.lua
-- Find and replace across files using grug-far.nvim

return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      { "<leader>St", function() require("grug-far").toggle_instance({ instanceName = "far" }) end, desc = "Toggle search/replace" },
      { "<leader>Sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search current word" },
      { "<leader>Sw", function() require("grug-far").with_visual_selection() end, mode = "v", desc = "Search selection" },
      { "<leader>Sf", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "Search in current file" },
    },
    opts = {
      headerMaxWidth = 80,
    },
  },
}
