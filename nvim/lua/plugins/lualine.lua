-- plugins/lualine.lua

-- Lualine sections configuration
local sections_config = {
	lualine_a = { {
		"mode",
		fmt = function()
			return "◎"
		end,
	} },
	lualine_b = {
		{ "diff", symbols = { added = "󰜄 ", modified = "󱔀 ", removed = "󰛲 " } },
		"diagnostics",
	},
	lualine_c = { { "filename", path = 1 } },
	lualine_x = {},
	lualine_y = { "location" },
	lualine_z = { "progress" },
}

-- Setup Lualine with the sections and winbar configuration
require("lualine").setup({
	inactive_sections = sections_config,
	sections = sections_config,
	options = {
		disabled_filetypes = {
			statusline = {
				"Avante",
				"AvanteInput",
				"AvanteSelectedFiles",
			},
		},
	},
})
