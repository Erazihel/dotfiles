-- plugins/lsp.lua
-- LSP configuration with Mason

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
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
			-- Setup capabilities with cmp_nvim_lsp
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
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
						require("lspconfig")[server_name].setup({})
					end,
					-- Custom handler for eslint
					eslint = function()
						require("lspconfig").eslint.setup({
							settings = {
								format = false, -- Use conform.nvim for formatting instead
							},
						})
					end,
					-- Custom handler for lua_ls
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
									workspace = {
										library = {
											[vim.fn.expand("$VIMRUNTIME/lua")] = true,
											[vim.fn.stdpath("config") .. "/lua"] = true,
										},
									},
									telemetry = {
										enable = false,
									},
								},
							},
						})
					end,
				},
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

			-- Override vim.ui.select to show popup for Code Actions
			vim.ui.select = function(items, opts, on_choice)
				if vim.tbl_isempty(items) then
					return on_choice(nil, nil)
				end

				local lines = {}
				for i, item in ipairs(items) do
					lines[i] =
						string.format("[%d] %s", i, opts.format_item and opts.format_item(item) or tostring(item))
				end

				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
				vim.bo[buf].modifiable = false

				local width = math.min(80, vim.o.columns - 10)
				local height = math.min(#lines + 2, 20)
				local win = vim.api.nvim_open_win(buf, true, {
					relative = "editor",
					width = width,
					height = height,
					col = (vim.o.columns - width) / 2,
					row = (vim.o.lines - height) / 2,
					style = "minimal",
					border = "rounded",
					title = " " .. (opts.prompt or "Select"):gsub(":?%s*$", "") .. " ",
					title_pos = "center",
				})

				local function close(choice)
					pcall(vim.api.nvim_win_close, win, true)
					pcall(vim.api.nvim_buf_delete, buf, { force = true })
					on_choice(choice and items[choice] or nil, choice)
				end

				local keymaps = {
					["<CR>"] = function()
						close(vim.api.nvim_win_get_cursor(win)[1])
					end,
					["<Esc>"] = function()
						close()
					end,
					["q"] = function()
						close()
					end,
				}

				for key, fn in pairs(keymaps) do
					vim.keymap.set("n", key, fn, { buffer = buf, nowait = true })
				end

				for i = 1, math.min(9, #items) do
					vim.keymap.set("n", tostring(i), function()
						close(i)
					end, { buffer = buf, nowait = true })
				end
			end
		end,
	},
}
