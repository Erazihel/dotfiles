-- plugins/formatting.lua
-- conform.nvim for async formatting

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo", "Format" },
	opts = {
		format_on_save = function(bufnr)
			return {
				bufnr = bufnr,
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
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
				async = params.bang,
				lsp_fallback = true,
				range = range,
			})
		end, { range = true, bang = true, desc = "Format current buffer" })
	end,
}
