-- plugins/formatting.lua
-- conform.nvim for async formatting

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "Format" },
  keys = {
    { "<leader>cf", "<cmd>Format<CR>", desc = "Format buffer" },
  },
  opts = {
    format_after_save = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "eslint_d", "prettier" },
      typescript = { "eslint_d", "prettier" },
      javascriptreact = { "eslint_d", "prettier" },
      typescriptreact = { "eslint_d", "prettier" },
      vue = { "eslint_d", "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      ["markdown.mdx"] = { "prettier" },
      graphql = { "prettier" },
      handlebars = { "prettier" },
      bash = { "shfmt" },
      sh = { "shfmt" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
    },
  },
  config = function(_, opts)
    local conform = require("conform")

    conform.setup(opts)

    vim.api.nvim_create_user_command("Format", function(params)
      local range
      if params.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, params.line2 - 1, params.line2, true)[1] or ""
        range = {
          start = { params.line1, 0 },
          ["end"] = { params.line2, end_line:len() },
        }
      end

      conform.format({
        async = not params.bang, -- Async by default (matching format_after_save), :Format! for sync
        lsp_format = "fallback",
        range = range,
      })
    end, { range = true, bang = true, desc = "Format current buffer" })
  end,
}
