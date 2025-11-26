-- plugins/fzf.lua
-- FZF fuzzy finder (faster than Telescope for this setup)
--
-- Note: Eagerly loaded (lazy = false) because:
--   1. Lightweight plugin with minimal startup cost (~5-10ms)
--   2. Used very frequently in daily workflows
--   3. Lazy loading would introduce first-use delay
--   4. Provides immediate availability for muscle-memory workflows

return {
	-- FZF binary
	{
		"junegunn/fzf",
		lazy = false,
		build = "./install --bin",
	},

	-- FZF Vim integration
	{
		"junegunn/fzf.vim",
		lazy = false,
		dependencies = { "junegunn/fzf" },
		config = function()
			-- FZF layout configuration
			vim.g.fzf_layout = {
				window = {
					width = 0.9,
					height = 0.8,
				},
			}

			vim.g.fzf_preview_window = { "up,60%", "ctrl-p" }

			-- Create Grep command
			vim.api.nvim_create_user_command("Grep", function(opts)
				local query = table.concat(opts.fargs, " ")
				local cmd = "rg --column --line-number --no-heading --color=always --hidden --smart-case -- "
					.. vim.fn.shellescape(query)
				vim.fn["fzf#vim#grep"](cmd, 1, vim.fn["fzf#vim#with_preview"](), opts.bang and 1 or 0)
			end, {
				bang = true,
				nargs = "*",
			})
		end,
	},
}
