-- ============================
-- Plugin keys
-- ============================

vim.keymap.set("n", "<leader>/f", ":FzfLua files<CR>", { silent = true, desc = "FzfLua [f]iles" })
vim.keymap.set("n", "<leader>/g", ":FzfLua live_grep<CR>", { silent = true, desc = "FzfLua live_[g]rep" })
vim.keymap.set("n", "<leader>/b", ":FzfLua buffers<CR>", { silent = true, desc = "FzfLua [b]uffers" })
vim.keymap.set("n", "<leader>//", ":FzfLua grep_curbuf<CR>", { silent = true, desc = "FzfLua grep_curbuf" })
vim.keymap.set("n", "<leader>/w", ":FzfLua diagnostics_workspace<CR>", { silent = true, desc = "FzfLua diagnostics_[w]orkspace" })
vim.keymap.set("n", "<leader>/d", ":FzfLua diagnostics_document<CR>", { silent = true, desc = "FzfLua diagnostics_[d]ocument" })
vim.keymap.set("n", "<leader>/k", ":FzfLua keymaps<CR>", { silent = true, desc = "FzfLua [k]eymaps" })

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { silent = true, desc = "Buffer Local Keymaps (which-key)" })

vim.keymap.set("n", "<leader>f", ":Yazi<CR>", { desc = "Open yazi at the current file" })
vim.keymap.set("n", "<leader>e", ":Yazi cwd<CR>", { desc = "Open the file manager in nvim's working directory" })
vim.keymap.set("n", "<leader>Y", ":Yazi toggle<CR>", { desc = "Resume the last yazi session" })

-- ============================
-- Lazy-plugin keys
-- ============================

local lazy = vim.api.nvim_create_augroup("LazyKeys", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = lazy,
	once = true,
	callback = function()
		vim.keymap.set("n", "<Tab>l", ":bnext<CR>", { silent = true, desc = "Next buffer" })
		vim.keymap.set("n", "<Tab>h", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
		vim.keymap.set("n", "<Tab><Right>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
		vim.keymap.set("n", "<Tab><Left>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
		vim.keymap.set("n", "<Tab>x", ":bdelete!<CR>", { silent = true, desc = "Force close current buffer" })
		vim.keymap.set("n", "<Tab>cc", ":bdelete<CR>", { silent = true, desc = "Close current buffer" })
		vim.keymap.set("n", "<Tab>ca", ":%bd", { silent = true, desc = "Close all buffers" })
		vim.keymap.set("n", "<Tab>co", ":BufferLineCloseOthers<CR>", { silent = true, desc = "Close all others buffer" })
		vim.keymap.set("n", "<Tab>ch", ":BufferLineCloseLeft<CR>", { silent = true, desc = "Close all left buffers" })
		vim.keymap.set("n", "<Tab>cl", ":BufferLineCloseRight<CR>", { silent = true, desc = "Close all right buffers" })
		vim.keymap.set("n", "<Tab>c<Left>", ":BufferLineCloseLeft<CR>", { silent = true, desc = "Close all left buffers" })
		vim.keymap.set("n", "<Tab>c<Right>", ":BufferLineCloseRight<CR>", { silent = true, desc = "Close all right buffers" })
		vim.keymap.set("n", "<Tab>od", ":BufferLineSortByDirectory<CR>", { silent = true, desc = "Sort buffer by directory" })
		vim.keymap.set("n", "<Tab>oe", ":BufferLineSortByExtension<CR>", { silent = true, desc = "Sort buffer by extensiton" })

		vim.keymap.set("n", "<leader>F", function()
			require("conform").format({ async = true })
		end, { noremap = true, silent = true, desc = "[F]ormat buffer" })

		vim.keymap.set("n", "gdb", ":DapToggleBreakpoint<CR>", { silent = true, desc = "[d]ebugger [b]reak point" })
		vim.keymap.set("n", "gdc", ":DapContinue<CR>", { silent = true, desc = "[d]ebugger [c]ontinue" })
		vim.keymap.set("n", "gdo", ":DapStepOver<CR>", { silent = true, desc = "[d]ebugger step [o]ver" })
		vim.keymap.set("n", "gdi", ":DapStepInto<CR>", { silent = true, desc = "[d]ebugger step [i]nto" })
		vim.keymap.set("n", "gdu", ":DapStepOut<CR>", { silent = true, desc = "[d]ebugger step o[u]t" })
		vim.keymap.set("n", "gdx", ":DapTerminate<CR>", { silent = true, desc = "[d]ebugger e[x]it" })

		vim.keymap.set("n", "<leader>gf", ":GrugFar<CR>", { silent = true, desc = "GrugFar" })
		vim.keymap.set("n", "<leader>gw", ":GrugFarWithin<CR>", { silent = true, desc = "GrugFarWithin" })

		vim.keymap.set({ "n", "x", "o" }, "f", function()
			require("flash").jump()
		end, { noremap = true, silent = true, desc = "Flash jump" })
		vim.keymap.set({ "n", "x", "o" }, "F", function()
			require("flash").treesitter()
		end, { noremap = true, silent = true, desc = "Flash treesitter" })
		vim.keymap.set("c", "<c-f>", function()
			require("flash").toggle()
		end, { noremap = true, silent = true, desc = "Toggle Flash (search mode)" })

		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { silent = true, desc = "Open all folds" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { silent = true, desc = "Close all folds" })
	end,
})

-- ============================
-- Lsp
-- ============================

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()", noremap = true, silent = true })
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "vim.lsp.buf.type_definition()", noremap = true, silent = true })
vim.keymap.set("n", "grh", function()
	vim.lsp.buf.hover({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.lsp.buf.hover()", silent = true })
vim.keymap.set("n", "grI", function()
	vim.diagnostic.open_float({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.diagnostic.open_float(),", silent = true })

-- ============================
-- Others
-- ============================

vim.keymap.set({ "n", "v" }, "<c-Up>", "10k", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-Down>", "10j", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-k>", "10k", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-j>", "10j", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-h>", "10h", { noremap = true })
vim.keymap.set({ "n", "v" }, "<c-l>", "10l", { noremap = true })

vim.keymap.set("i", "<c-z>", "<ESC>u", { desc = "Undo and back to normal mode", noremap = true })
vim.keymap.set("i", "<c-r>", "<ESC><c-r>", { desc = "Redo and back to normal mode", noremap = true })
vim.keymap.set({ "n", "v" }, "<c-z>", "u", { desc = "Undo", noremap = true })

vim.keymap.set("n", "<c-s>", "<cmd>:w<CR>", { desc = "Save file", noremap = true })
vim.keymap.set({ "i", "v" }, "<c-s>", "<ESC><cmd>:w<CR>", { desc = "Save and back to normal mode", noremap = true })

vim.keymap.set({ "n", "i", "v", "x", "s", "o", "t", "c", "l" }, "<c-q>", "<ESC>", { desc = "<ESC>", noremap = true })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape to normal mode", noremap = true })

vim.keymap.set("n", "<c-c>", ":nohlsearch<CR>", { desc = "Clear search highlights", noremap = true })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position", noremap = true })
