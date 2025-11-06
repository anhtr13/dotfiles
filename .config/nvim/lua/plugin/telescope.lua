return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},
	keys = {
		{ "<leader>/f", ":Telescope find_files<CR>", silent = true, desc = "Telescope find_[f]iles" },
		{ "<leader>/g", ":Telescope live_grep<CR>", silent = true, desc = "Telescope live_[g]rep" },
		{ "<leader>/b", ":Telescope buffers<CR>", silent = true, desc = "Telescope [b]uffers" },
		{ "<leader>//", ":Telescope current_buffer_fuzzy_find<CR>", silent = true, desc = "Telescope current_buffer_fuzzy_find" },
		{ "<leader>/c", ":Telescope command_history<CR>", silent = true, desc = "Telescope [c]ommand_history" },
		{ "<leader>/d", ":Telescope diagnostics<CR>", silent = true, desc = "Telescope [d]iagnostics" },
		{ "<leader>/h", ":Telescope help_tags<CR>", silent = true, desc = "Telescope [h]elp_tags" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case" (default "smart_case")
				},
			},
		})

		-- Install these 2 packages:
		-- [fzf](https://github.com/junegunn/fzf)
		-- [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)

		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("fzf")
	end,
}
