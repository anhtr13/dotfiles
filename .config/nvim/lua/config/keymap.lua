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

-- Lsp
vim.keymap.set("n", "grh", function()
	vim.lsp.buf.hover({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.lsp.buf.hover()", noremap = true, silent = true })
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"grt",
	vim.lsp.buf.type_definition,
	{ desc = "vim.lsp.buf.type_definition()", noremap = true, silent = true }
)
vim.keymap.set("n", "grI", function()
	vim.diagnostic.open_float({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.diagnostic.open_float(),", noremap = true, silent = true })
