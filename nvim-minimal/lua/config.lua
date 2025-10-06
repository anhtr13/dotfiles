-- ========================
-- ======== Option ========
-- ========================

vim.wo.number = true -- Make line numbers default (default: false)
vim.o.relativenumber = true -- Set relative numbered lines (default: false)
vim.o.linebreak = true -- Companion to wrap, don't split words (default: false)
vim.o.mouse = "a" -- Enable mouse mode (default: '')
vim.o.autoindent = true -- Copy indent from current line when starting new one (default: true)
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.o.smartcase = true -- Smart case (default: false)
vim.o.shiftwidth = 2 -- The number of spaces inserted for each indentation (default: 8)
vim.o.tabstop = 2 -- Insert n spaces for a tab (default: 8)
vim.o.softtabstop = 2 -- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.o.expandtab = true -- Convert tabs to spaces (default: false)
vim.o.scrolloff = 6 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.o.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
vim.o.cursorline = false -- Highlight the current line (default: false)
vim.o.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.o.swapfile = false -- Creates a swapfile (default: true)
vim.o.smartindent = true -- Make indenting smarter again (default: false)
vim.o.showtabline = 2 -- Always show tabs (default: 1)
vim.o.breakindent = true -- Enable break indent (default: false)
vim.o.updatetime = 250 -- Decrease update time (default: 4000)
vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
vim.o.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited (default: true)
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience (default: 'menu,preview')

vim.opt.iskeyword:append("-") -- Hyphenated words recognized by searches (default: does not include '-')
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)
vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)

-- =======================
-- ========= LSP =========
-- =======================

vim.lsp.enable({
	"lua_ls",
	"bash_ls",
	"pylyzer",
})
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})
vim.diagnostic.config({ virtual_text = true })

-- ========================
-- ======== Keymap ========
-- ========================

-- Set leader to <space>
-- vim.g.mapleader = " "

-- Fast navigations
vim.keymap.set({ "n", "v" }, "<c-Up>", "10k")
vim.keymap.set({ "n", "v" }, "<c-Down>", "10j")
vim.keymap.set({ "n", "v" }, "<c-k>", "10k")
vim.keymap.set({ "n", "v" }, "<c-j>", "10j")
vim.keymap.set({ "n", "v" }, "<c-h>", "10h")
vim.keymap.set({ "n", "v" }, "<c-l>", "10l")

-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete and yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>c", '"+c', { desc = "Change and yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste (right) from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste (left) from system clipboard" })

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

-- LSP keymap
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
