local setkey = vim.keymap.set
-- options:
--    noremap: no-recursive map
--    silent: show no message when the keybinding is used
--    desc: keys sequence description

-- Use <PageUp>, <PageDown> for scrolling only
setkey({ "n", "v" }, "<s-Up>", "<Nop>")
setkey({ "n", "v" }, "<s-Down>", "<Nop>")
setkey({ "n", "v" }, "<s-j>", "<Nop>")
setkey({ "n", "v" }, "<s-k>", "<Nop>")

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
