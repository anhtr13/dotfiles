return {
	"MagicDuck/grug-far.nvim",
  event = "VeryLazy",
	-- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
	-- additional lazy config to defer loading is not really needed...
	config = function()
		require("grug-far").setup({})
	end,
	keys = {
		{ "<leader>gf", ":GrugFar<CR>", silent = true, desc = "GrugFar" },
		{ "<leader>gw", ":GrugFarWithin<CR>", silent = true, desc = "GrugFarWithin" },
	},
}
