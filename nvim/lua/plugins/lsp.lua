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

vim.diagnostic.config({
  virtual_text = false,
  signs = { text = { ['1'] = '●', ['2'] = '●', ['3'] = '●', ['4'] = '●' } },
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    header = '',
    source = 'if_many',
  },
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      scope = 'cursor',
      focusable = false,
    })
  end
})
