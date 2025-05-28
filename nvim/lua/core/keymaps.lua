local setkey = vim.keymap.set

-- <========== Unbind keys ==========>

setkey({ "n", "v" }, "<s-j>", "<Nop>", { silent = true })

-- Use <PageUp>, <PageDown> for scrolling
setkey({ "n", "v" }, "<s-Up>", "<Nop>", { silent = true })
setkey({ "n", "v" }, "<s-Down>", "<Nop>", { silent = true })
setkey({ "n", "v" }, "<c-u>", "<Nop>", { silent = true })
setkey({ "n", "v" }, "<c-d>", "<Nop>", { silent = true })

--

--

--

-- <========== Bind keys ==========>

-- Save
setkey(
	{ "i", "v" },
	"<c-s>",
	"<ESC><cmd>:w<CR>",
	{ desc = "Save file and back to normal mode", noremap = true, silent = true }
)
setkey("n", "<c-s>", "<cmd>:w<CR>", { desc = "Save file", noremap = true, silent = true })

-- Quit
setkey({ "n", "i", "v" }, "<c-q>", "<ESC>", { desc = "<ESC>", noremap = true, silent = true })

-- Undo/Redo
setkey("i", "<c-z>", "<ESC>u", { desc = "Undo and back to normal mode", noremap = true, silent = true })
setkey("i", "<c-r>", "<ESC><c-r>", { desc = "Redo and back to normal mode", noremap = true, silent = true })
setkey({ "n", "v" }, "<c-z>", "u", { desc = "Undo", noremap = true, silent = true })

-- Escape terminal mode.
setkey("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape to normal mode", noremap = true, silent = true })

--[[ -- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>`", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end) ]]

-- Nvim 0.11: [<Space>, ]<Space> add an empty line above and below the cursor

-- Delete
-- <c-o> to perform normal mode while in insert mode
-- <c-o> db/dB : delete to begin of word
-- <c-o> de/dE : delete to end of word

-- BufferLine
setkey("n", "<Tab>l", "<cmd>:BufferLineCycleNext<CR>", { desc = "Jump to next buffer", noremap = true, silent = true })
setkey(
	"n",
	"<Tab>h",
	"<cmd>:BufferLineCyclePrev<CR>",
	{ desc = "Jump to previous buffer", noremap = true, silent = true }
)
setkey(
	"n",
	"<Tab><Right>",
	"<cmd>:BufferLineCycleNext<CR>",
	{ desc = "Jump to next buffer", noremap = true, silent = true }
)
setkey(
	"n",
	"<Tab><Left>",
	"<cmd>:BufferLineCyclePrev<CR>",
	{ desc = "Jump to previous buffer", noremap = true, silent = true }
)
setkey("n", "<Tab>c", "<cmd>:Bdelete<CR>", { desc = "Close current buffer", noremap = true, silent = true })
setkey("n", "<Tab>x", "<cmd>:Bdelete!<CR>", { desc = "Force close current buffer", noremap = true, silent = true })
setkey(
	"n",
	"<Tab>o",
	"<cmd>:BufferLineCloseOthers<CR>",
	{ desc = "Close all others buffer", noremap = true, silent = true }
)
