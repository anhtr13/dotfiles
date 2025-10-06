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
						-- You can use the capture groups defined in textobjects.scm
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

		-- Register additional file extensions
		-- vim.filetype.add({ extension = { tf = "terraform" } })
		-- vim.filetype.add({ extension = { tfvars = "terraform" } })
		-- vim.filetype.add({ extension = { pipeline = "groovy" } })
		-- vim.filetype.add({ extension = { multibranch = "groovy" } })
	end,
}
