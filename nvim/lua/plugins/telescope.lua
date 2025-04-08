return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
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
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				fzf = {},
			},
		})
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>/f", builtin.find_files, { desc = "Telescope find [f]iles" })
		vim.keymap.set("n", "<leader>/g", builtin.live_grep, { desc = "Telescope live [g]rep" })
		vim.keymap.set("n", "<leader>/b", builtin.buffers, { desc = "Telescope [b]uffers" })
		vim.keymap.set("n", "<leader>/h", builtin.help_tags, { desc = "Telescope [h]elp tags" })
	end,
}
