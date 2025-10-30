-- ======================
-- === Global keymaps ===
-- ======================

-- Set leader to <space>
-- vim.g.mapleader = " "

-- Fast navigations
vim.keymap.set({ "n", "v" }, "<c-Up>", "10k", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-Down>", "10j", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-k>", "10k", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-j>", "10j", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-h>", "10h", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-l>", "10l", { noremap = true })

-- System clipboard
-- vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
-- vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete and yank to clipboard" })
-- vim.keymap.set({ "n", "v" }, "<leader>c", '"+c', { desc = "Change and yank to clipboard" })
-- vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste (right) from system clipboard" })
-- vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste (left) from system clipboard" })

-- Save
vim.keymap.set(
	{ "i", "v" },
	"<c-s>",
	"<ESC><cmd>:w<CR>",
	{ desc = "Save file and back to normal mode", noremap = true }
)
vim.keymap.set("n", "<c-s>", "<cmd>:w<CR>", { desc = "Save file", noremap = true })

-- Quit
vim.keymap.set({ "n", "i", "v" }, "<c-q>", "<ESC>", { desc = "<ESC>", noremap = true })

-- Undo/Redo
vim.keymap.set("i", "<c-z>", "<ESC>u", { desc = "Undo and back to normal mode", noremap = true })
vim.keymap.set("i", "<c-r>", "<ESC><c-r>", { desc = "Redo and back to normal mode", noremap = true })
vim.keymap.set({ "n", "v" }, "<c-z>", "u", { desc = "Undo", noremap = true })

-- Escape terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape to normal mode", noremap = true })
