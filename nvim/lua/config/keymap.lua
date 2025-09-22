-- options:
--    noremap: no-recursive map
--    silent: show no message when the keybinding is used
--    desc: keys sequence description

-- Set leader to g
-- vim.g.mapleader = "g"

-- Fast navigations
vim.keymap.set({ "n", "v" }, "<c-Up>", "10k")
vim.keymap.set({ "n", "v" }, "<c-Down>", "10j")
vim.keymap.set({ "n", "v" }, "<c-k>", "10k")
vim.keymap.set({ "n", "v" }, "<c-j>", "10j")

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Save
vim.keymap.set({ "i", "v" }, "<c-s>", "<ESC><cmd>:w<CR>", { desc = "Save file and back to normal mode" })
vim.keymap.set("n", "<c-s>", "<cmd>:w<CR>", { desc = "Save file" })

-- Quit
vim.keymap.set({ "n", "i", "v" }, "<c-q>", "<ESC>", { desc = "<ESC>" })

-- Undo/Redo
vim.keymap.set("i", "<c-z>", "<ESC>u", { desc = "Undo and back to normal mode" })
vim.keymap.set("i", "<c-r>", "<ESC><c-r>", { desc = "Redo and back to normal mode" })
vim.keymap.set({ "n", "v" }, "<c-z>", "u", { desc = "Undo" })

-- Escape terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape to normal mode" })

--[[ -- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>`", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end) ]]
