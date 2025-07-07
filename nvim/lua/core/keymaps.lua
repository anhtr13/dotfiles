local setkey = vim.keymap.set
-- options:
--    noremap: no-recursive map
--    silent: show no message when the keybinding is used
--    desc: keys sequence description



-- <========== Unbind keys ==========>
-- Use <PageUp>, <PageDown> for scrolling
setkey({ "n", "v" }, "<s-Up>", "<Nop>")
setkey({ "n", "v" }, "<s-Down>", "<Nop>")
setkey({ "n", "v" }, "<s-j>", "<Nop>")
setkey({ "n", "v" }, "<s-k>", "<Nop>")



-- <========== Bind keys ==========>
-- Save
setkey({ "i", "v" }, "<c-s>", "<ESC><cmd>:w<CR>", { desc = "Save file and back to normal mode" })
setkey("n", "<c-s>", "<cmd>:w<CR>", { desc = "Save file" })

-- Quit
setkey({ "n", "i", "v" }, "<c-q>", "<ESC>", { desc = "<ESC>" })

-- Undo/Redo
setkey("i", "<c-z>", "<ESC>u", { desc = "Undo and back to normal mode" })
setkey("i", "<c-r>", "<ESC><c-r>", { desc = "Redo and back to normal mode" })
setkey({ "n", "v" }, "<c-z>", "u", { desc = "Undo" })

-- Escape terminal mode.
setkey("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape to normal mode" })

--[[ -- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>`", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end) ]]

-- BufferLine
setkey("n", "<Tab>l", "<cmd>:BufferLineCycleNext<CR>", { desc = "Jump to next buffer" })
setkey("n", "<Tab>h", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Jump to previous buffer" })
setkey("n", "<Tab><Right>", "<cmd>:BufferLineCycleNext<CR>", { desc = "Jump to next buffer" })
setkey("n", "<Tab><Left>", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Jump to previous buffer" })
setkey("n", "<Tab>c", "<cmd>:Bdelete<CR>", { desc = "Close current buffer" })
setkey("n", "<Tab>x", "<cmd>:Bdelete!<CR>", { desc = "Force close current buffer" })
setkey("n", "<Tab>o", "<cmd>:BufferLineCloseOthers<CR>", { desc = "Close all others buffer" })
