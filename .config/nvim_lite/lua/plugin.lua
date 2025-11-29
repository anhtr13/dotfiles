-- ============================
-- First load
-- ============================

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

require("oil").setup()
require("fzf-lua").setup()
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

-- ============================
-- Lazy load
-- ============================

local lazy = vim.api.nvim_create_augroup("LazyLoad", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	group = lazy,
	once = true, -- Ensures the command only runs once
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
			{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
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
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "{}",
					node_incremental = "{+",
					node_decremental = "{-",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["<leader>("] = "@parameter.inner",
						["<leader>)"] = "@parameter.outer",
						["<leader>{"] = "@function.inner",
						["<leader>}"] = "@function.outer",
						["<leader>["] = "@class.inner",
						["<leader>]"] = "@class.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
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
					enable = false,
				},
			},
		})
	end,
})
