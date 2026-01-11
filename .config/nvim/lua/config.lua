-- ============================
-- Appearance
-- ============================

vim.cmd.colorscheme("tokio_night")

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "BreakPointRed", linehl = "BreakPointRed", numhl = "BreakPointRed" })
vim.fn.sign_define("DapBreakpointCondition", { text = "󰟃", texthl = "BreakPointBlue", linehl = "BreakPointBlue", numhl = "BreakPointBlue" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "BreakPointRed", linehl = "BreakPointRed", numhl = "BreakPointRed" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "BreakPointYellow", linehl = "BreakPointYellow", numhl = "BreakPointYellow" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "BreakPointGreen", linehl = "BreakPointGreen", numhl = "BreakPointGreen" })

-- ============================
-- Options
-- ============================

-- Basic
vim.o.mouse = "" -- Disable mouse support
vim.o.encoding = "UTF-8" -- Set encoding
vim.o.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.o.completeopt = "menuone,noselect" -- Completion options
vim.o.winborder = "single"
vim.o.termguicolors = true -- Enable 24-bit colors
vim.o.number = true -- Line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.cursorline = true -- Highlight current line
vim.o.wrap = true -- Wrap lines
vim.o.linebreak = true -- Companion to wrap, don't split words (default: false)
vim.o.scrolloff = 10 -- 10 lines above/below cursor
vim.o.showtabline = 2 -- show tabline
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate Vim plugins from Neovim in case Vim still in use
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Indentation
vim.o.tabstop = 4 -- Tab width
vim.o.shiftwidth = 4 -- Indent width
vim.o.softtabstop = 4 -- Soft tab stop
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.smartindent = true -- Smart auto-indenting
vim.o.autoindent = true -- Copy indent from current line

-- Search
vim.o.ignorecase = true -- Case insensitive search
vim.o.smartcase = true -- Case sensitive if uppercase in search
vim.o.incsearch = true -- Show matches as you type

-- File handling
vim.o.backup = false -- Don't create backup files
vim.o.writebackup = false -- Don't create backup before writing
vim.o.swapfile = false -- Don't create swap files
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 500 -- Key timeout duration
vim.o.ttimeoutlen = 0 -- Key code timeout
vim.o.autoread = true -- Auto reload files changed outside vim
vim.o.autowrite = false -- Don't auto save

-- Folding settings
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Split behavior
vim.o.splitbelow = true -- Horizontal splits go below
vim.o.splitright = true -- Vertical splits go right

-- ============================
-- Keymaps
-- ============================

vim.keymap.set("n", "<Tab>l", ":bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<Tab>h", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<Tab><Right>", ":bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<Tab><Left>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<Tab>x", ":bdelete!<CR>", { desc = "Force close current buffer", silent = true })
vim.keymap.set("n", "<Tab>cc", ":bdelete<CR>", { desc = "Close current buffer", silent = true })
vim.keymap.set("n", "<Tab>ca", ":BufDeleteAll<CR>", { desc = "Close all buffers", silent = true })
vim.keymap.set("n", "<Tab>co", ":BufDeleteOther<CR>", { desc = "Close all other buffers", silent = true })

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()", noremap = true })
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "vim.lsp.buf.type_definition()", noremap = true })
vim.keymap.set("n", "grh", function()
	vim.lsp.buf.hover({ max_height = 32, max_width = 132 })
end, { desc = "vim.lsp.buf.hover()" })
vim.keymap.set("n", "grI", function()
	vim.diagnostic.open_float({ max_height = 32, max_width = 132 })
end, { desc = "vim.diagnostic.open_float()," })

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

-- ============================
-- User commands
-- ============================

function DeleteOtherBufs()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = vim.api.nvim_list_bufs()
	for _, buf_id in ipairs(buffers) do
		if buf_id ~= current_buf and vim.api.nvim_buf_is_loaded(buf_id) then
			pcall(vim.api.nvim_buf_delete, buf_id, { force = false })
		end
	end
end

function DeleteAllBufs()
	local buffers = vim.api.nvim_list_bufs()
	for _, buf_id in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf_id) then
			pcall(vim.api.nvim_buf_delete, buf_id, { force = false })
		end
	end
end

vim.api.nvim_create_user_command("BufDeleteOther", DeleteOtherBufs, { bang = true, desc = "Delete all other buffers" })
vim.api.nvim_create_user_command("BufDeleteAll", DeleteAllBufs, { bang = true, desc = "Delete all buffers" })

vim.api.nvim_create_user_command(
	"InstallLSPs",
	"MasonInstall bash-language-server cmake-language-server dockerfile-lsp gopls json-lsp lua-language-server nginx-language-server pylyzer systemd-language-server tailwindcss-language-server vtsls vue-language-server yaml-language-server",
	{ bang = true, desc = "Install formatter via Mason" }
)

vim.api.nvim_create_user_command(
	"InstallFomatters",
	"MasonInstall black codespell goimports-reviser golines isort nginx-config-formatter prettierd shfmt sql-formatter stylua tombi",
	{ bang = true, desc = "Install formatter via Mason" }
)

-- ===================================
-- Register additional file extensions
-- ===================================

-- vim.filetype.add({
--   pattern = {
--     ["compose.*%.ya?ml"] = "yaml.docker-compose",
--     ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
--   },
-- })
-- vim.filetype.add({ extension = { tf = "terraform" } })
-- vim.filetype.add({ extension = { tfvars = "terraform" } })
-- vim.filetype.add({ extension = { pipeline = "groovy" } })
-- vim.filetype.add({ extension = { multibranch = "groovy" } })
