local setmap = vim.keymap.set

-- Save
setmap({ "i", "v" }, "<c-s>", "<ESC><cmd>:w<CR>", { desc = "Save file and back to normal mode", silent = true })
setmap("n", "<c-s>", "<cmd>:w<CR>", { desc = "Save file", silent = true })

-- Quit
setmap({ "n", "i", "v" }, "<c-q>", "<ESC>", { desc = "<ESC>", silent = true })

-- Undo/Redo
setmap("i", "<c-z>", "<ESC>u", { desc = "Undo and back to normal mode", silent = true })
setmap("i", "<c-r>", "<ESC><c-r>", { desc = "Redo and back to normal mode", silent = true })
setmap({ "n", "v" }, "<c-z>", "u", { desc = "Undo", silent = true })

-- Escape terminal mode.
setmap("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape to normal mode", silent = true })

--[[ -- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>`", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end) ]]

-- Newline in normal mode
setmap("n", "<leader>o", "o<Esc>", { desc = "Add new line below", silent = true })
setmap("n", "<leader>O", "O<Esc>", { desc = "Add new line above", silent = true })

-- Delete
-- <c-o> to perform normal mode while in insert mode
-- <c-o> db/dB : delete to begin of word
-- <c-o> de/dE : delete to end of word

-- BufferLine
setmap("n", "<Tab>l", "<cmd>:BufferLineCycleNext<CR>", { desc = "Jump to next buffer", silent = true })
setmap("n", "<Tab>h", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Jump to previous buffer", silent = true })
setmap("n", "<Tab>x", "<cmd>:Bdelete<CR>", { desc = "Force close current buffer", silent = true })
setmap("n", "<Tab>fx", "<cmd>:Bdelete!<CR>", { desc = "Jump to next buffer", silent = true })
setmap("n", "<Tab>co", "<cmd>:BufferLineCloseOthers<CR>", { desc = "Close all others buffer", silent = true })


