-- ============================
-- Appearance
-- ============================

vim.cmd.colorscheme("tokyo_night")

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
vim.o.tabstop = 2 -- Tab width
vim.o.shiftwidth = 2 -- Indent width
vim.o.softtabstop = 2 -- Soft tab stop
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

-- Plugin keys
vim.keymap.set("n", "<leader>/f", ":FzfLua files<CR>", { desc = "FzfLua [f]iles" })
vim.keymap.set("n", "<leader>/g", ":FzfLua live_grep<CR>", { desc = "FzfLua live_[g]rep" })
vim.keymap.set("n", "<leader>/b", ":FzfLua buffers<CR>", { desc = "FzfLua [b]uffers" })
vim.keymap.set("n", "<leader>/m", ":FzfLua marks<CR>", { desc = "FzfLua [m]arks" })
vim.keymap.set("n", "<leader>/c", ":FzfLua command_history<CR>", { desc = "FzfLua [c]command_history" })
vim.keymap.set("n", "<leader>//", ":FzfLua grep_curbuf<CR>", { desc = "FzfLua grep_curbuf" })
vim.keymap.set("n", "<leader>/.", ":FzfLua resume<CR>", { desc = "FzfLua resume" })
vim.keymap.set("n", "<leader>/w", ":FzfLua diagnostics_workspace<CR>", { desc = "FzfLua diagnostics_[w]orkspace" })
vim.keymap.set("n", "<leader>/d", ":FzfLua diagnostics_document<CR>", { desc = "FzfLua diagnostics_[d]ocument" })
vim.keymap.set("n", "<leader>/k", ":FzfLua keymaps<CR>", { desc = "FzfLua [k]eymaps" })

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "File explorer" })

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- Lazy-plugin keys
local lazy_keys = vim.api.nvim_create_augroup("lazy.keys", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
	group = lazy_keys,
	once = true,
	callback = function()
		vim.keymap.set("n", "<Tab>l", ":bnext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<Tab>h", ":bprevious<CR>", { desc = "Previous buffer" })
		vim.keymap.set("n", "<Tab><Right>", ":bnext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<Tab><Left>", ":bprevious<CR>", { desc = "Previous buffer" })
		vim.keymap.set("n", "<Tab>x", ":bdelete!<CR>", { desc = "Force close current buffer" })
		vim.keymap.set("n", "<Tab>cc", ":bdelete<CR>", { desc = "Close current buffer" })
		vim.keymap.set("n", "<Tab>ca", ":%bd<CR>", { desc = "Close all buffers" })
		vim.keymap.set("n", "<Tab>co", ":%bd|e#|bd#<CR>", { desc = "Close all other buffers" })

		vim.keymap.set("n", "<leader>F", function()
			require("conform").format({ async = true })
		end, { noremap = true, desc = "[F]ormat buffer" })

		vim.keymap.set("n", "gdb", ":DapToggleBreakpoint<CR>", { desc = "[d]ebugger [b]reak point" })
		vim.keymap.set("n", "gdc", ":DapContinue<CR>", { desc = "[d]ebugger [c]ontinue" })
		vim.keymap.set("n", "gdo", ":DapStepOver<CR>", { desc = "[d]ebugger step [o]ver" })
		vim.keymap.set("n", "gdi", ":DapStepInto<CR>", { desc = "[d]ebugger step [i]nto" })
		vim.keymap.set("n", "gdu", ":DapStepOut<CR>", { desc = "[d]ebugger step o[u]t" })
		vim.keymap.set("n", "gdx", ":DapTerminate<CR>", { desc = "[d]ebugger e[x]it" })

		vim.keymap.set("n", "<leader>gf", ":GrugFar<CR>", { desc = "GrugFar" })
		vim.keymap.set("n", "<leader>gw", ":GrugFarWithin<CR>", { desc = "GrugFarWithin" })

		vim.keymap.set({ "n", "x", "o" }, "f", function()
			require("flash").jump()
		end, { noremap = true, desc = "Flash jump" })
		vim.keymap.set({ "n", "x", "o" }, "F", function()
			require("flash").treesitter()
		end, { noremap = true, desc = "Flash treesitter" })
		vim.keymap.set("c", "<c-f>", function()
			require("flash").toggle()
		end, { noremap = true, desc = "Toggle Flash (search mode)" })

		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
	end,
})

-- Lsp keys
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()", noremap = true })
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "vim.lsp.buf.type_definition()", noremap = true })
vim.keymap.set("n", "grh", function()
	vim.lsp.buf.hover({ max_height = 32, max_width = 132 })
end, { desc = "vim.lsp.buf.hover()" })
vim.keymap.set("n", "grI", function()
	vim.diagnostic.open_float({ max_height = 32, max_width = 132 })
end, { desc = "vim.diagnostic.open_float()," })

-- Other keys
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

-- ========================
-- ====== Statusline ======
-- ========================

local function mode_highlight()
	local mode = vim.fn.mode()
	if mode == "n" then
		return "%#StatusLineNormal#"
	elseif mode == "i" or mode == "ic" then
		return "%#StatusLineInsert#"
	elseif mode == "v" or mode == "V" or mode == "s" or mode == "S" then
		return "%#StatusLineVisual#"
	elseif mode == "r" or mode == "R" then
		return "%#StatusLineReplace#"
	elseif mode == "c" then
		return "%#StatusLineCommand#"
	elseif mode == "t" then
		return "%#StatusLineTerminal#"
	else
		return "%#StatusLineNormal#"
	end
end

local function mode_icon()
	local mode = vim.fn.mode()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		["\22"] = "V-BLOCK", -- Ctrl-V
		c = "COMMAND",
		s = "SELECT",
		S = "S-LINE",
		["\19"] = "S-BLOCK", -- Ctrl-S
		R = "REPLACE",
		r = "REPLACE",
		["!"] = "SHELL",
		t = "TERMINAL",
	}
	return modes[mode] or (mode:upper())
end

local function git_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return " [" .. branch .. "]"
	end
	return ""
end

local function file_size()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size < 0 then
		return ""
	end
	if size < 1024 then
		return size .. "B"
	elseif size < 1024 * 1024 then
		return string.format("%.1fK", size / 1024)
	else
		return string.format("%.1fM", size / 1024 / 1024)
	end
end

_G.mode_highlight = mode_highlight
_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_size = file_size

vim.api.nvim_create_autocmd({ "ModeChanged", "BufEnter", "WinEnter", "VimEnter", "InsertEnter", "InsertLeave" }, {
	callback = function()
		local mode_hl = mode_highlight()
		vim.opt_local.statusline = table.concat({
			mode_hl,
			"  %{v:lua.mode_icon()} ",
			"%#StatusLine#",
			"  %<%t%{v:lua.git_branch()} %m%=    %y ",
			"%{v:lua.file_size()}  ",
			mode_hl,
			" %l:%c / %P ",
		})
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	callback = function()
		vim.opt_local.statusline = " %{v:lua.git_branch()} %<%f    %=%y | %l:%c / %P "
	end,
})

-- ============================
-- User commands
-- ============================

vim.api.nvim_create_user_command(
	"InstallLSPs",
	"MasonInstall bash-language-server cmake-language-server dockerfile-language-server gopls json-lsp lua-language-server nginx-language-server pylyzer systemd-language-server tailwindcss-language-server vtsls vue-language-server yaml-language-server",
	{
		bang = true,
		desc = "Install formatter via Mason",
	}
)

vim.api.nvim_create_user_command(
	"InstallFomatters",
	"MasonInstall black codespell goimports-reviser golines isort nginx-config-formatter prettierd shfmt sql-formatter stylua tombi",
	{
		bang = true,
		desc = "Install formatter via Mason",
	}
)

-- ============================
-- Break-points
-- ============================

vim.api.nvim_set_hl(0, "red", { ctermbg = 0, fg = "#ff6969", bg = "#262626" })
vim.api.nvim_set_hl(0, "blue", { ctermbg = 0, fg = "#6996ff", bg = "#262626" })
vim.api.nvim_set_hl(0, "green", { ctermbg = 0, fg = "#96ff96", bg = "#262626" })
vim.api.nvim_set_hl(0, "yellow", { ctermbg = 0, fg = "#ffff96", bg = "#262626" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red", linehl = "red", numhl = "red" })
vim.fn.sign_define("DapBreakpointCondition", { text = "󰟃", texthl = "blue", linehl = "blue", numhl = "blue" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "red", linehl = "red", numhl = "red" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow", linehl = "yellow", numhl = "yellow" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "green", linehl = "green", numhl = "green" })

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
