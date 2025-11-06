-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"bash",
				"regex",
				-- 'terraform',
				"yaml",
				"make",
				"cmake",
				"sql",
				"dockerfile",
				-- "toml",
				"json",
				-- 'java',
				-- 'groovy',
				"python",
				"go",
				"rust",
				"zig",
				"cpp",
				"gitignore",
				-- 'graphql',
				"javascript",
				"typescript",
				"tsx",
				-- 'css',
				-- 'html',
				"vue",
			},
			modules = {},
			ignore_install = {},
			auto_install = true, -- Autoinstall languages that are not installed
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "{}",
					scope_incremental = "{+",
					node_incremental = "{]",
					node_decremental = "{[",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
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
					enable = false,
					swap_next = {
						["<leader>j"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>k"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
