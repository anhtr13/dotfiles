-- Make HTTP requests from within Neovim
return {
	"mistweaverco/kulala.nvim",
  event = "VeryLazy",
	keys = {
		{ "<leader>Rs", desc = "Send request" },
		{ "<leader>Ra", desc = "Send all requests" },
		{ "<leader>Rb", desc = "Open scratchpad" },
	},
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
	},
}
