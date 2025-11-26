-- plugins/git.lua
-- Git integration with gitsigns and fugitive

return {
  -- Gitsigns for git decorations and hunk operations
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous hunk" })

        -- Actions
        map("n", "<leader>Ghs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>Ghr", gs.reset_hunk, { desc = "Reset hunk" })
        map("v", "<leader>Ghs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk" })
        map("v", "<leader>Ghr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk" })
        map("n", "<leader>GhS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>Ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>GhR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>Ghp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>GB", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>Gb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
        map("n", "<leader>GD", gs.diffthis, { desc = "Diff this" })
        map("n", "<leader>Ghd", function()
          gs.diffthis("~")
        end, { desc = "Diff this ~" })
        map("n", "<leader>Gd", gs.toggle_deleted, { desc = "Toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
      end,
    },
  },

  -- Fugitive for advanced git commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
    keys = {
      { "<leader>Gd", "<cmd>Git diff<cr>", desc = "Git diff" },
      { "<leader>Gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>Gm", "<cmd>Git mergetool<cr>", desc = "Git mergetool" },
    },
  },
}
