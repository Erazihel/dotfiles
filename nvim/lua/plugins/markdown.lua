-- plugins/markdown.lua
-- Markdown preview

return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Toggle Markdown Preview",
        ft = "markdown",
      },
    },
    config = function()
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = "8080"
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_page_title = "${name}"
    end,
  },
}
