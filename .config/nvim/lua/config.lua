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

-- ========================
-- Statusline
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

-- ================================
-- Treesitter incremental selection
-- ================================

_G.selected_nodes = {} ---@type TSNode[]

local function ts_get_node_at_cursor()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1
	local col = cursor[2]

	local ok, root_parser = pcall(vim.treesitter.get_parser, 0, nil, {})
	if not ok or not root_parser then
		return
	end

	root_parser:parse({ vim.fn.line("w0") - 1, vim.fn.line("w$") })
	local lang_tree = root_parser:language_for_range({ row, col, row, col })

	return lang_tree:named_node_for_range({ row, col, row, col }, { ignore_injections = false })
end

local function ts_select_node(node)
	if not node then
		return
	end
	local start_row, start_col, end_row, end_col = node:range()

	local last_line = vim.api.nvim_buf_line_count(0)
	local end_row_pos = math.min(end_row + 1, last_line)
	local end_col_pos = end_col

	if end_row + 1 > last_line then
		local last_line_text = vim.api.nvim_buf_get_lines(0, last_line - 1, last_line, true)[1]
		end_col_pos = #last_line_text
	end

	local mode = vim.api.nvim_get_mode()
	if mode.mode ~= "v" then
		vim.api.nvim_cmd({ cmd = "normal", bang = true, args = { "v" } }, {})
	end

	vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
	vim.cmd("normal! o")
	vim.api.nvim_win_set_cursor(0, { end_row_pos, end_col_pos > 0 and end_col_pos - 1 or 0 })
end

local function init_selection()
	_G.selected_nodes = {}

	local current_node = ts_get_node_at_cursor()
	if not current_node then
		return
	end

	table.insert(_G.selected_nodes, current_node)
	ts_select_node(current_node)
end

local function incr_selection()
	if #_G.selected_nodes == 0 then
		return
	end

	local current_node = _G.selected_nodes[#_G.selected_nodes]

	if not current_node then
		return
	end

	local node = current_node
	local root_searched = false
	while true do
		local parent = node:parent()
		if not parent then
			if root_searched then
				return
			end
			local ok, root_parser = pcall(vim.treesitter.get_parser)
			if not ok or root_parser == nil then
				return
			end
			root_parser:parse({ vim.fn.line("w0") - 1, vim.fn.line("w$") })

			local range = { node:range() }
			local current_parser = root_parser:language_for_range(range)

			if root_parser ~= current_parser then
				local parser = current_parser:parent()
				if parser == nil then
					return
				end
				current_parser = parser
			end

			if root_parser == current_parser then
				root_searched = true
			end

			parent = current_parser:named_node_for_range(range)
			if parent == nil then
				return
			end
		end

		local range = { node:range() }
		local parent_range = { parent:range() }
		if not vim.deep_equal(range, parent_range) then
			table.insert(_G.selected_nodes, parent)
			ts_select_node(parent)
			return
		end
		node = parent
	end
end

local function decr_selection()
	if #_G.selected_nodes > 1 then
		table.remove(_G.selected_nodes)
		local current_node = _G.selected_nodes[#_G.selected_nodes]
		if current_node then
			ts_select_node(current_node)
		end
	end
end

vim.keymap.set("n", "||", init_selection, { desc = "Treesitter init selection" })
vim.keymap.set("x", "|+", incr_selection, { desc = "Treesitter increase selection" })
vim.keymap.set("x", "|-", decr_selection, { desc = "Treesitter decrease selection" })

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
	"MasonInstall bash-language-server cmake-language-server dockerfile-language-server gopls json-lsp lua-language-server nginx-language-server pylyzer systemd-language-server tailwindcss-language-server vtsls vue-language-server yaml-language-server",
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
