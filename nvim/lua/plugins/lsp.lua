-- plugins/lsp.lua
-- LSP configuration with Mason

return {
  -- LSP progress indicator
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        opts = {},
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>pm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
          ensure_installed = {
            "stylua",
            "shfmt",
            "prettier",
            "eslint_d",
            "cspell",
          },
        },
        config = function(_, opts)
          require("mason").setup(opts)
          local mr = require("mason-registry")
          mr:on("package:install:success", function()
            vim.defer_fn(function()
              -- trigger FileType event to possibly load this newly installed LSP server
              require("lazy.core.handler.event").trigger({
                event = "FileType",
                buf = vim.api.nvim_get_current_buf(),
              })
            end, 100)
          end)
          local function ensure_installed()
            for _, tool in ipairs(opts.ensure_installed) do
              local p = mr.get_package(tool)
              if not p:is_installed() then
                p:install()
              end
            end
          end
          if mr.refresh then
            mr.refresh(ensure_installed)
          else
            ensure_installed()
          end
        end,
      },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Build capabilities once, pass explicitly to each server (avoids mutating global default)
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- Setup Mason LSP config
      require("mason-lspconfig").setup({
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
          -- Default handler for all servers
          function(server_name)
            require("lspconfig")[server_name].setup({ capabilities = capabilities })
          end,
          -- Disable built-in copilot LSP (using zbirenbaum/copilot.lua instead)
          copilot = function() end,
          -- Custom handler for eslint
          eslint = function()
            require("lspconfig").eslint.setup({
              capabilities = capabilities,
              settings = {
                format = false, -- Let Prettier handle formatting
              },
            })
          end,
          -- Custom handler for lua_ls (lazydev.nvim handles workspace setup)
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
          end

          -- Navigation
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gr", vim.lsp.buf.references, "Go to references")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")

          -- Documentation
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

          -- Code actions and refactoring
          map("n", "<leader>a", vim.lsp.buf.code_action, "Code action")

          -- Incremental rename (uses inc-rename.nvim for live preview)
          vim.keymap.set("n", "<leader>R", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
          end, { buffer = bufnr, expr = true, desc = "Rename symbol" })

          -- Diagnostics
          map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
          map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous diagnostic")
          map("n", "<leader>D", vim.diagnostic.setqflist, "Diagnostics quickfix")
        end,
      })

      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = false, -- Don't show inline virtual text
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.HINT] = "●",
          },
        },
        underline = true,
        severity_sort = true,
        update_in_insert = false,
        float = {
          border = "rounded",
          header = "",
          source = "if_many",
          focusable = false,
        },
      })
    end,
  },
}
