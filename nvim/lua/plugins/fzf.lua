-- plugins/fzf.lua
-- fzf-lua for fast fuzzy finding with modern UI

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "FzfLua" },
  keys = {
    { "<leader>f", function() require("fzf-lua").git_files() end, desc = "Find git files" },
    { "<leader>F", function() require("fzf-lua").files() end, desc = "Find all files" },
    { "<leader>b", function() require("fzf-lua").buffers() end, desc = "Find buffers" },
    { "<leader>H", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },
  },
  init = function()
    -- Register ui_select early so vim.ui.select always uses fzf
    -- This lazy-loads fzf-lua on first vim.ui.select call
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("fzf-lua").register_ui_select()
      return vim.ui.select(...)
    end
  end,
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      "default-title",
      winopts = {
        width = 0.9,
        height = 0.8,
        border = "rounded",
        preview = {
          layout = "vertical",
          vertical = "up:60%",
          border = "rounded",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
          ["ctrl-p"] = "toggle-preview",
        },
      },
      files = {
        git_icons = true,
        file_icons = true,
      },
      git = {
        files = {
          git_icons = true,
          file_icons = true,
        },
      },
      buffers = {
        file_icons = true,
        sort_lastused = true,
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --hidden --smart-case"
          .. " --glob '!node_modules/*' --glob '!.git/*' --glob '!dist/*' --glob '!build/*'",
        file_icons = true,
        git_icons = true,
      },
    })

  end,
}
