-- plugins/ui.lua
-- UI enhancement plugins: lualine, bufferline, indent-blankline, notify

return {
	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			local devicons = require("nvim-web-devicons")
			devicons.setup({})

			local all_icons = devicons.get_icons()

			-- Override tsx extension color to match TypeScript
			if all_icons["tsx"] then
				devicons.set_icon({
					["tsx"] = {
						icon = all_icons["tsx"].icon,
						color = "#3178c6",
						cterm_color = "74",
						name = "Tsx",
					},
				})
			end

			-- Override test.tsx color to match TypeScript
			if all_icons["test.tsx"] then
				devicons.set_icon({
					["test.tsx"] = {
						icon = all_icons["test.tsx"].icon,
						color = "#3178c6",
						cterm_color = "74",
						name = all_icons["test.tsx"].name,
					},
				})
			end
		end,
	},

	-- Lualine statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Get Catppuccin colors
			local colors = require("catppuccin.palettes").get_palette("macchiato")

			-- Common mode indicator
			local mode_component = {
				"mode",
				fmt = function()
					return "◎"
				end,
			}

			-- Progress mode indicator
			local progress_component = {
				"progress",
				color = { bg = colors.flamingo, fg = colors.base },
			}

			-- Location component
			local location_component = {
				"location",
				color = { bg = colors.peach, fg = colors.base },
			}

			-- Default sections configuration
			local sections_config = {
				lualine_a = { mode_component },
				lualine_b = {
					{ "branch", icon = "" },
					{ "diff", symbols = { added = "󰜄 ", modified = "󱔀 ", removed = "󰛲 " } },
					"diagnostics",
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						cond = function()
							return vim.bo.filetype ~= "fzf"
						end,
					},
				},
				lualine_x = {},
				lualine_y = { location_component },
				lualine_z = { progress_component },
			}

			require("lualine").setup({
				options = {
					theme = "catppuccin",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
				sections = sections_config,
				inactive_sections = sections_config,
				tabline = {},
				extensions = { "fugitive", "trouble", "aerial" },
			})
		end,
	},

	-- Nvim-notify for better notifications
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			render = "compact",
			stages = "fade_in_slide_out",
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},
}
