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

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>/f", builtin.find_files, { desc = "Telescope find [f]iles" })
		vim.keymap.set("n", "<leader>/g", builtin.live_grep, { desc = "Telescope live [g]rep" })
		vim.keymap.set("n", "<leader>/b", builtin.buffers, { desc = "Telescope [b]buffers" })
		vim.keymap.set("n", "<leader>/h", builtin.help_tags, { desc = "Telescope [h]elp tags" })
	end,
}
