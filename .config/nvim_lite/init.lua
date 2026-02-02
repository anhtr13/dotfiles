-- ========================
-- ======= Options ========
-- ========================

vim.o.termguicolors = true -- Enable 24-bit colors
vim.o.number = true -- Line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.cursorline = true -- Highlight current line
vim.o.wrap = true -- Wrap lines
vim.o.linebreak = true -- Companion to wrap, don't split words (default: false)
vim.o.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.o.scrolloff = 10 -- 10 lines above/below cursor
vim.g.airline_extensions_tabline_enabled = 1
vim.o.showtabline = 2
vim.o.mouse = "" -- Disable mouse support
vim.o.encoding = "UTF-8" -- Set encoding
vim.o.completeopt = "menuone,noinsert,noselect"
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)

vim.o.tabstop = 2 -- Tab width
vim.o.shiftwidth = 2 -- Indent width
vim.o.softtabstop = 2 -- Soft tab stop
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.smartindent = true -- Smart auto-indenting
vim.o.autoindent = true -- Copy indent from current line

vim.o.ignorecase = true -- Case insensitive search
vim.o.smartcase = true -- Case sensitive if uppercase in search
vim.o.incsearch = true -- Show matches as you type

vim.o.backup = false -- Don't create backup files
vim.o.writebackup = false -- Don't create backup before writing
vim.o.swapfile = false -- Don't create swap files
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 500 -- Key timeout duration
vim.o.ttimeoutlen = 0 -- Key code timeout
vim.o.autoread = true -- Auto reload files changed outside vim
vim.o.autowrite = false -- Don't auto save

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.splitbelow = true -- Horizontal splits go below
vim.o.splitright = true -- Vertical splits go right

-- ========================
-- ======= Keymaps ========
-- ========================

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

vim.keymap.set("n", "<Tab>l", ":bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<Tab>h", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<Tab><Right>", ":bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<Tab><Left>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<Tab>x", ":bdelete!<CR>", { desc = "Force close current buffer", silent = true })
vim.keymap.set("n", "<Tab>cc", ":bdelete<CR>", { desc = "Close current buffer", silent = true })
vim.keymap.set("n", "<Tab>ca", ":%bd<CR>", { desc = "Close all buffers", silent = true })
vim.keymap.set("n", "<Tab>co", ":%bd|e#|bd#<CR>", { desc = "Close all other buffers", silent = true })

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()", noremap = true })
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "vim.lsp.buf.type_definition()", noremap = true })
vim.keymap.set("n", "grh", function()
	vim.lsp.buf.hover({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.lsp.buf.hover()" })
vim.keymap.set("n", "grI", function()
	vim.diagnostic.open_float({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.diagnostic.open_float()," })

vim.cmd.colorscheme("lunaperche")

-- ================================
-- Custom utilities
-- ================================

-- Treesitter incremental selection
_G.selected_nodes = {} ---@type TSNode[]

local TsIncreSelection = {}

TsIncreSelection.get_node_at_cursor = function()
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

TsIncreSelection.select_node = function(node)
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

TsIncreSelection.init_selection = function()
	_G.selected_nodes = {}

	local current_node = TsIncreSelection.get_node_at_cursor()
	if not current_node then
		return
	end

	table.insert(_G.selected_nodes, current_node)
	TsIncreSelection.select_node(current_node)
end

TsIncreSelection.incr_selection = function()
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
			TsIncreSelection.select_node(parent)
			return
		end
		node = parent
	end
end

TsIncreSelection.decr_selection = function()
	if #_G.selected_nodes > 1 then
		table.remove(_G.selected_nodes)
		local current_node = _G.selected_nodes[#_G.selected_nodes]
		if current_node then
			TsIncreSelection.select_node(current_node)
		end
	end
end

-- Statusline
local StatusLine = {}

StatusLine.git_branch = function()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return " [" .. branch .. "]"
	end
	return ""
end

StatusLine.file_size = function()
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

StatusLine.mode_icon = function()
	local mode = vim.fn.mode()
	local modes = {
		n = "NOR",
		i = "INS",
		v = "VIS",
		V = "V-L",
		["\22"] = "V-B", -- Ctrl-V
		c = "CMD",
		s = "SEL",
		S = "S-L",
		["\19"] = "S-B", -- Ctrl-S
		R = "RPL",
		r = "RPL",
		["!"] = "SHELL",
		t = "TERM",
	}
	return modes[mode] or (mode:upper())
end

StatusLine.setup = function()
	_G.mode_icon = StatusLine.mode_icon
	_G.git_branch = StatusLine.git_branch
	_G.file_size = StatusLine.file_size

	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			vim.opt_local.statusline = table.concat({
				"%#Bold#",
				" %{v:lua.mode_icon()} ",
				"%#StatusLine#",
				"| %<%t%{v:lua.git_branch()} %m%=    %y ",
				"%{v:lua.file_size()} | %P / %l:%c ",
			})
		end,
	})

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = " %{v:lua.git_branch()} %<%f    %=%y | %P / %l:%c "
		end,
	})
end

-- ============================
-- Core plugins
-- ============================

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

--------------------------------------
require("oil").setup()
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil.nvim", silent = true })

--------------------------------------
require("fzf-lua").setup()
vim.keymap.set("n", "<leader>/f", ":FzfLua files<CR>", { desc = "FzfLua [f]iles", silent = true })
vim.keymap.set("n", "<leader>/g", ":FzfLua live_grep<CR>", { desc = "FzfLua live_[g]rep", silent = true })
vim.keymap.set("n", "<leader>/b", ":FzfLua buffers<CR>", { desc = "FzfLua [b]uffers", silent = true })
vim.keymap.set("n", "<leader>/m", ":FzfLua marks<CR>", { desc = "FzfLua [m]arks", silent = true })
vim.keymap.set("n", "<leader>/c", ":FzfLua command_history<CR>", { desc = "FzfLua [c]command_history", silent = true })
vim.keymap.set("n", "<leader>//", ":FzfLua grep_curbuf<CR>", { desc = "FzfLua grep_curbuf", silent = true })
vim.keymap.set("n", "<leader>/w", ":FzfLua diagnostics_workspace<CR>", { desc = "FzfLua diagnostics_[w]orkspace", silent = true })
vim.keymap.set("n", "<leader>/d", ":FzfLua diagnostics_document<CR>", { desc = "FzfLua diagnostics_[d]ocument", silent = true })
vim.keymap.set("n", "<leader>/k", ":FzfLua keymaps<CR>", { desc = "FzfLua [k]eymaps", silent = true })

--------------------------------------
local ts = require("nvim-treesitter")
local ts_setup_group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true })
local parsers = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"bash",
	"regex",
	"yaml",
	"make",
	"cmake",
	"dockerfile",
	"toml",
	"json",
	"python",
	"gitignore",
}

local ignore_filetypes = {
	checkhealth = true,
	lazy = true,
	mason = true,
	notify = true,
	noice = true,
	qf = true,
	toggleterm = true,
	NvimTree = true,
	fzf = true,
}

vim.api.nvim_create_autocmd("VimEnter", {
	group = ts_setup_group,
	once = true,
	desc = "Install treesitter parsers",
	callback = function()
		ts.install(parsers, { max_jobs = 8 })
		-- vim.api.nvim_command("TSUpdate")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = ts_setup_group,
	desc = "Enable treesitter highlighting and folds",
	callback = function(event)
		if not vim.api.nvim_buf_is_valid(event.buf) or ignore_filetypes[event.match] then
			return
		end
		local lang = vim.treesitter.language.get_lang(event.match) or event.match
		local ok = pcall(vim.treesitter.start, event.buf, lang)
		if ok then
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
		end
	end,
})

--------------------------------------
require("mason").setup({
	PATH = "prepend",
	max_concurrent_installers = 3,
	ui = {
		border = "single",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

--------------------------------------
StatusLine.setup()

-- ============================
-- Lazy load
-- ============================

local lazy = vim.api.nvim_create_augroup("lazy.plugins", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	group = lazy,
	once = true, -- Ensures the command only runs once
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
		})

		--------------------------------------
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		local textobjects_select = require("nvim-treesitter-textobjects.select")
		local textobjects_move = require("nvim-treesitter-textobjects.move")

		vim.keymap.set({ "x", "o" }, "|(", function()
			textobjects_select.select_textobject("@parameter.inner", "textobjects")
		end, { desc = "Select inner parameter" })
		vim.keymap.set({ "x", "o" }, "|)", function()
			textobjects_select.select_textobject("@parameter.outer", "textobjects")
		end, { desc = "Select outer parameter" })
		vim.keymap.set({ "x", "o" }, "|{", function()
			textobjects_select.select_textobject("@function.inner", "textobjects")
		end, { desc = "Select inner function" })
		vim.keymap.set({ "x", "o" }, "|}", function()
			textobjects_select.select_textobject("@function.outer", "textobjects")
		end, { desc = "Select outer function" })
		vim.keymap.set({ "x", "o" }, "|[", function()
			textobjects_select.select_textobject("@class.inner", "textobjects")
		end, { desc = "Select inner class" })
		vim.keymap.set({ "x", "o" }, "|]", function()
			textobjects_select.select_textobject("@class.outer", "textobjects")
		end, { desc = "Select outer class" })

		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			textobjects_move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Go to next function start" })
		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			textobjects_move.goto_next_start("@class.outer", "textobjects")
		end, { desc = "Go to next class start" })

		vim.keymap.set({ "n", "x", "o" }, "]F", function()
			textobjects_move.goto_next_end("@function.outer", "textobjects")
		end, { desc = "Go to next function end" })
		vim.keymap.set({ "n", "x", "o" }, "]C", function()
			textobjects_move.goto_next_end("@class.outer", "textobjects")
		end, { desc = "Go to next class end" })

		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			textobjects_move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Go to previous function start" })
		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			textobjects_move.goto_previous_start("@class.outer", "textobjects")
		end, { desc = "Go to previous class start" })

		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			textobjects_move.goto_previous_end("@function.outer", "textobjects")
		end, { desc = "Go to previous function end" })
		vim.keymap.set({ "n", "x", "o" }, "[C", function()
			textobjects_move.goto_previous_end("@class.outer", "textobjects")
		end, { desc = "Go to previous class end" })

		vim.keymap.set("n", "||", TsIncreSelection.init_selection, { desc = "Treesitter init selection" })
		vim.keymap.set("x", "|+", TsIncreSelection.incr_selection, { desc = "Treesitter increase selection" })
		vim.keymap.set("x", "|-", TsIncreSelection.decr_selection, { desc = "Treesitter decrease selection" })
	end,
})

-- =======================
-- ======== LSPs =========
-- =======================

vim.lsp.config["bash_ls"] = {
	cmd = { "bash-language-server", "start" },
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
		},
	},
	filetypes = { "bash", "sh", "zsh" },
	root_markers = { ".git" },
}

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}

vim.lsp.config["pylyzer"] = {
	cmd = { "pylyzer", "--server" },
	filetypes = { "python" },
	root_markers = {
		"setup.py",
		"tox.ini",
		"requirements.txt",
		"Pipfile",
		"pyproject.toml",
		".git",
	},
	settings = {
		python = {
			diagnostics = true,
			inlayHints = true,
			smartCompletion = true,
			checkOnType = false,
		},
	},
	cmd_env = {
		ERG_PATH = vim.env.ERG_PATH or vim.fs.joinpath(vim.uv.os_homedir(), ".erg"),
	},
}

vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})

vim.lsp.enable({
	"bash_ls",
	"lua_ls",
	"pylyzer",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

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
		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
