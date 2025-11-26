-- plugins/editor.lua
-- Editor enhancement plugins: Comment, surround, oil

return {
	-- Comment.nvim for smart commenting
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- Context commentstring for treesitter-aware commenting
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},

	-- nvim-surround for surrounding text manipulation
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty for defaults
			})
		end,
	},

	-- Neo-tree.nvim for file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
		},
		opts = {
			close_if_last_window = false,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "",
				},
				git_status = {
					symbols = {
						added = "✚",
						modified = "",
						deleted = "✖",
						renamed = "󰁕",
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = "none",
					["<cr>"] = "open",
					["<esc>"] = "cancel",
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
					["l"] = "focus_preview",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["a"] = {
						"add",
						config = {
							show_path = "none",
						},
					},
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = "show_file_details",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"node_modules",
					},
					never_show = {
						".DS_Store",
						"thumbs.db",
					},
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = false,
				hijack_netrw_behavior = "open_default",
				use_libuv_file_watcher = true,
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["#"] = "fuzzy_sorter",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["og"] = { "order_by_git_status", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = true,
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
		},
	},

	-- Aerial for symbols outline
	{
		"stevearc/aerial.nvim",
		cmd = { "AerialToggle", "AerialOpen", "AerialClose" },
		keys = {
			{ "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
		},
		opts = {
			backends = { "treesitter", "lsp", "markdown", "man" },
			layout = {
				max_width = { 40, 0.2 },
				width = nil,
				min_width = 10,
			},
			attach_mode = "window",
			close_automatic_events = {},
			keymaps = {
				["?"] = "actions.show_help",
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.jump",
				["<2-LeftMouse>"] = "actions.jump",
				["<C-v>"] = "actions.jump_vsplit",
				["<C-s>"] = "actions.jump_split",
				["p"] = "actions.scroll",
				["<C-j>"] = "actions.down_and_scroll",
				["<C-k>"] = "actions.up_and_scroll",
				["{"] = "actions.prev",
				["}"] = "actions.next",
				["[["] = "actions.prev_up",
				["]]"] = "actions.next_up",
				["q"] = "actions.close",
				["o"] = "actions.tree_toggle",
				["za"] = "actions.tree_toggle",
				["O"] = "actions.tree_toggle_recursive",
				["zA"] = "actions.tree_toggle_recursive",
				["l"] = "actions.tree_open",
				["zo"] = "actions.tree_open",
				["L"] = "actions.tree_open_recursive",
				["zO"] = "actions.tree_open_recursive",
				["h"] = "actions.tree_close",
				["zc"] = "actions.tree_close",
				["H"] = "actions.tree_close_recursive",
				["zC"] = "actions.tree_close_recursive",
				["zr"] = "actions.tree_increase_fold_level",
				["zR"] = "actions.tree_open_all",
				["zm"] = "actions.tree_decrease_fold_level",
				["zM"] = "actions.tree_close_all",
				["zx"] = "actions.tree_sync_folds",
				["zX"] = "actions.tree_sync_folds",
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
