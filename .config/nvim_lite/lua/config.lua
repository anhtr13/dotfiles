-- ========================
-- ======= Options ========
-- ========================

vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap = true -- Wrap lines
vim.opt.linebreak = true -- Companion to wrap, don't split words (default: false)
vim.opt.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.opt.scrolloff = 10 -- 10 lines above/below cursor
vim.opt.mouse = "" -- Disable mouse support
vim.opt.encoding = "UTF-8" -- Set encoding
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)

vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search
vim.opt.incsearch = true -- Show matches as you type

vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before writing
vim.opt.swapfile = false -- Don't create swap files
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save

vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

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

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"grt",
	vim.lsp.buf.type_definition,
	{ desc = "vim.lsp.buf.type_definition()", noremap = true, silent = true }
)
vim.keymap.set("n", "grh", function()
	vim.lsp.buf.hover({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.lsp.buf.hover()", silent = true })
vim.keymap.set("n", "grI", function()
	vim.diagnostic.open_float({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.diagnostic.open_float(),", silent = true })

vim.keymap.set("n", "<leader>/f", ":FzfLua files<CR>", { silent = true, desc = "FzfLua [f]iles" })
vim.keymap.set("n", "<leader>/g", ":FzfLua live_grep<CR>", { silent = true, desc = "FzfLua live_[g]rep" })
vim.keymap.set("n", "<leader>/b", ":FzfLua buffers<CR>", { silent = true, desc = "FzfLua [b]uffers" })
vim.keymap.set("n", "<leader>//", ":FzfLua grep_curbuf<CR>", { silent = true, desc = "FzfLua grep_curbuf" })
vim.keymap.set(
	"n",
	"<leader>/w",
	":FzfLua diagnostics_workspace<CR>",
	{ silent = true, desc = "FzfLua diagnostics_[w]orkspace" }
)
vim.keymap.set(
	"n",
	"<leader>/d",
	":FzfLua diagnostics_document<CR>",
	{ silent = true, desc = "FzfLua diagnostics_[d]ocument" }
)
vim.keymap.set("n", "<leader>/k", ":FzfLua keymaps<CR>", { silent = true, desc = "FzfLua [k]eymaps" })

vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil.nvim" })

vim.keymap.set("n", "<Tab>l", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<Tab>h", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<Tab><Right>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<Tab><Left>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<Tab>x", ":bdelete!<CR>", { silent = true, desc = "Force close current buffer" })
vim.keymap.set("n", "<Tab>cc", ":bdelete<CR>", { silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "<Tab>ca", ":%bd", { silent = true, desc = "Close all buffers" })
vim.keymap.set("n", "<Tab>co", ":%bd|e#|bd#<CR>", { silent = true, desc = "Close all other buffers" })

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

local function file_type()
	return vim.bo.filetype
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
_G.file_type = file_type
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	callback = function()
		vim.opt_local.statusline = table.concat({
			"  ",
			"%#StatusLineBold#",
			"%{v:lua.mode_icon()}  | ",
			"%{v:lua.git_branch()} %f",
			"%#StatusLine#",
			"%=", -- Right-align everything after this
			"%{v:lua.file_size()} / %{v:lua.file_type()}  |  %l:%c / %P  ",
		})
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	callback = function()
		vim.opt_local.statusline = "  %{v:lua.git_branch()} %f%=%{v:lua.file_type()}  |  %l:%c / %P  "
	end,
})
