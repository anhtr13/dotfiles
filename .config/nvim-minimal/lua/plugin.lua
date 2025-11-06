vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("oil").setup()
require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },
		["<C-c>"] = { "cancel", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<CR>"] = { "accept", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = {
			window = { border = "single" },
			auto_show = true,
		},
		menu = {
			border = "single",
			draw = {
				padding = { 0, 1 },
				components = {
					kind_icon = {
						text = function(ctx)
							return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
						end,
					},
				},
			},
		},
	},
	signature = {
		window = { border = "single" },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "lua",
		sorts = {
			"exact",
			"score",
			"sort_text",
		},
	},
})
require("conform").setup({
	formatters_by_ft = {
		sh = { "shfmt" },
		zsh = { "shfmt" },
		bash = { "shfmt" },
		lua = { "stylua" },
		python = { "isort", "black" },
	},
	default_format_opts = {
		lsp_format = "fallback",
		stop_after_first = false,
	},
})
require("mason").setup({
	PATH = "prepend",
	max_concurrent_installers = 3,
	ui = {
		border = "single",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"query",
		"bash",
		"python",
		"dockerfile",
		"python",
	},
	modules = {},
	ignore_install = {},
	-- Autoinstall languages that are not installed
	auto_install = true,
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "[]",
			node_incremental = "[>",
			node_decremental = "[<",
			scope_incremental = "[+",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>j"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>k"] = "@parameter.inner",
			},
		},
	},
})
