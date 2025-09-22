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
		-- your configuration comes here
		global_keymaps = false,
	},
}
