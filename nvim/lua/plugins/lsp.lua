-- core/lsp.lua

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "dockerls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "lua_ls",
    "ts_ls",
    "vimls",
    "yamlls",
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})
