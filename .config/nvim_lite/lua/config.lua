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

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()", noremap = true })
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "vim.lsp.buf.type_definition()", noremap = true })
vim.keymap.set("n", "grh", function()
	vim.lsp.buf.hover({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.lsp.buf.hover()" })
vim.keymap.set("n", "grI", function()
	vim.diagnostic.open_float({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.diagnostic.open_float()," })

vim.keymap.set("n", "<leader>/f", ":FzfLua files<CR>", { desc = "FzfLua [f]iles", silent = true })
vim.keymap.set("n", "<leader>/g", ":FzfLua live_grep<CR>", { desc = "FzfLua live_[g]rep", silent = true })
vim.keymap.set("n", "<leader>/b", ":FzfLua buffers<CR>", { desc = "FzfLua [b]uffers", silent = true })
vim.keymap.set("n", "<leader>/m", ":FzfLua marks<CR>", { desc = "FzfLua [m]arks", silent = true })
vim.keymap.set("n", "<leader>/c", ":FzfLua command_history<CR>", { desc = "FzfLua [c]command_history", silent = true })
vim.keymap.set("n", "<leader>//", ":FzfLua grep_curbuf<CR>", { desc = "FzfLua grep_curbuf", silent = true })
vim.keymap.set("n", "<leader>/w", ":FzfLua diagnostics_workspace<CR>", { desc = "FzfLua diagnostics_[w]orkspace", silent = true })
vim.keymap.set("n", "<leader>/d", ":FzfLua diagnostics_document<CR>", { desc = "FzfLua diagnostics_[d]ocument", silent = true })
vim.keymap.set("n", "<leader>/k", ":FzfLua keymaps<CR>", { desc = "FzfLua [k]eymaps", silent = true })

vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil.nvim", silent = true })

vim.keymap.set("n", "<Tab>l", ":bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<Tab>h", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<Tab><Right>", ":bnext<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<Tab><Left>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<Tab>x", ":bdelete!<CR>", { desc = "Force close current buffer", silent = true })
vim.keymap.set("n", "<Tab>cc", ":bdelete<CR>", { desc = "Close current buffer", silent = true })
vim.keymap.set("n", "<Tab>ca", ":%bd<CR>", { desc = "Close all buffers", silent = true })
vim.keymap.set("n", "<Tab>co", ":%bd|e#|bd#<CR>", { desc = "Close all other buffers", silent = true })

-- ========================
-- ====== Statusline ======
-- ========================

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

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_size = file_size

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	callback = function()
		vim.opt_local.statusline = table.concat({
			"%#Bold#",
			" %{v:lua.mode_icon()} ",
			"%#StatusLine#",
			"| %<%t%{v:lua.git_branch()} %m%=    %y ",
			"%{v:lua.file_size()} | %l:%c / %P ",
		})
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	callback = function()
		vim.opt_local.statusline = " %{v:lua.git_branch()} %<%f    %=%y | %l:%c / %P "
	end,
})
