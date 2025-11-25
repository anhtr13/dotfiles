return {
	"MagicDuck/grug-far.nvim",
  event = "VeryLazy",
	config = function()
		require("grug-far").setup({})
	end,
	keys = {
		{ "<leader>gf", ":GrugFar<CR>", silent = true, desc = "GrugFar" },
		{ "<leader>gw", ":GrugFarWithin<CR>", silent = true, desc = "GrugFarWithin" },
	},
}
