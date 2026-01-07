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
require("utils.statusline").setup()

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

		local incremental_selection = require("utils.incremental_selection")
		vim.keymap.set("n", "||", incremental_selection.init_selection, { desc = "Treesitter init selection" })
		vim.keymap.set("x", "|+", incremental_selection.incr_selection, { desc = "Treesitter increase selection" })
		vim.keymap.set("x", "|-", incremental_selection.decr_selection, { desc = "Treesitter decrease selection" })
	end,
})
