-- ============================
-- Core plugins
-- ============================

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.icons" },

	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
})

--------------------------------------
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

--------------------------------------
require("fzf-lua").setup()

vim.keymap.set("n", "<leader>/f", require("fzf-lua").files, { desc = "FzfLua [f]iles", silent = true })
vim.keymap.set("n", "<leader>/g", require("fzf-lua").live_grep, { desc = "FzfLua live_[g]rep", silent = true })
vim.keymap.set("n", "<leader>/b", require("fzf-lua").buffers, { desc = "FzfLua [b]uffers", silent = true })
vim.keymap.set("n", "<leader>/m", require("fzf-lua").marks, { desc = "FzfLua [m]arks", silent = true })
vim.keymap.set("n", "<leader>/c", require("fzf-lua").command_history, { desc = "FzfLua [c]command_history", silent = true })
vim.keymap.set("n", "<leader>//", require("fzf-lua").grep_curbuf, { desc = "FzfLua grep_curbuf", silent = true })
vim.keymap.set("n", "<leader>/.", require("fzf-lua").resume, { desc = "FzfLua resume", silent = true })
vim.keymap.set("n", "<leader>/w", require("fzf-lua").diagnostics_workspace, { desc = "FzfLua diagnostics_[w]orkspace", silent = true })
vim.keymap.set("n", "<leader>/d", require("fzf-lua").diagnostics_document, { desc = "FzfLua diagnostics_[d]ocument", silent = true })
vim.keymap.set("n", "<leader>/k", require("fzf-lua").keymaps, { desc = "FzfLua [k]eymaps", silent = true })

--------------------------------------
require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	renderer = {
		indent_markers = {
			enable = true,
			inline_arrows = false,
		},
		icons = {
			git_placement = "after",
			glyphs = {
				git = {
					untracked = "",
					deleted = "✗",
					unstaged = "",
					staged = "",
					renamed = "",
					ignored = "",
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader>e", require("nvim-tree.api").tree.toggle, { desc = "File explorer", silent = true })

--------------------------------------
local ts = require("nvim-treesitter")
local ts_setup_group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true })
local parsers = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"go",
	"rust",
	"zig",
	"cpp",
	"haskell",
	"bash",
	"python",
	"commonlisp",
	-- 'terraform',
	"kdl",
	"rasi",
	"regex",
	"yaml",
	"json",
	"toml",
	"nix",
	"make",
	"cmake",
	"editorconfig",
	"http",
	"ini",
	"sql",
	"dockerfile",
	"nginx",
	-- 'java',
	-- 'groovy',
	"gitignore",
	-- 'graphql',
	"javascript",
	"typescript",
	"css",
	-- 'html',
	"xml",
	"vue",
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
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

--------------------------------------
require("which-key").setup({
	preset = "modern",
})

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

--------------------------------------
require("utils.statusline").setup()

-- ============================
-- Lazy load
-- ============================

local lazy_load = vim.api.nvim_create_augroup("lazy_load_plugins", { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
	group = lazy_load,
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/rafamadriz/friendly-snippets" },

			{ src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
			{ src = "https://github.com/lewis6991/gitsigns.nvim" },
			{ src = "https://github.com/3rd/image.nvim" },
		})

		--------------------------------------
		require("blink.cmp").setup({
			keymap = {
				preset = "none",
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-y>"] = { "select_and_accept", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-c>"] = { "cancel", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono", -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			},
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				documentation = {
					auto_show = true, -- auto show the documentation popup
				},
				menu = {
					draw = {
						padding = { 0, 1 }, -- padding only on right side
						components = {
							kind_icon = {
								text = function(ctx)
									return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
								end,
							},
						},
						treesitter = { "lsp" },
					},
				},
			},
			sources = {
				default = { "lsp", "buffer", "snippets", "path" },
			},
			fuzzy = {
				implementation = "rust",
				sorts = {
					"exact",
					"score",
					"sort_text",
				},
			},
		})

		--------------------------------------
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		})

		--------------------------------------
		require("image").setup({
			integrations = {
				markdown = {
					enabled = true,
					only_render_image_at_cursor = false,
				},
				neorg = {
					enabled = false,
				},
				typst = {
					enabled = false,
				},
			},
		})
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = lazy_load,
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/kevinhwang91/promise-async" },
			{ src = "https://github.com/igorlfs/nvim-dap-view" },
			{ src = "https://github.com/leoluz/nvim-dap-go" },

			{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
			{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
			{ src = "https://github.com/numToStr/Comment.nvim" },
			{ src = "https://github.com/stevearc/conform.nvim" },
			{ src = "https://github.com/mfussenegger/nvim-dap" },
			{ src = "https://github.com/folke/flash.nvim" },
			{ src = "https://github.com/MagicDuck/grug-far.nvim" },
			{ src = "https://github.com/saghen/blink.indent" },
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

		local incremental_selection = require("utils.ts_incremental_selection")
		vim.keymap.set("n", "||", incremental_selection.init_selection, { desc = "Treesitter init selection" })
		vim.keymap.set("x", "|+", incremental_selection.incr_selection, { desc = "Treesitter increase selection" })
		vim.keymap.set("x", "|-", incremental_selection.decr_selection, { desc = "Treesitter decrease selection" })

		--------------------------------------
		require("treesitter-context").setup()

		--------------------------------------
		require("Comment").setup()

		--------------------------------------
		require("conform").setup({
			formatters = {
				clang_format = {
					command = "clang-format",
					args = { "--style", "file", "--fallback-style", "LLVM" },
				},
				goimports_reviser = {
					command = "goimports-reviser",
					args = { "-rm-unused", "-set-alias", "-output", "stdout", "-format", "$FILENAME" },
				},
				golines = {
					command = "golines",
					args = { "--max-len", "132", "--tab-len", "2", "--shorten-comments" }, -- no "$FILENAME" to read from stdout of the previous plugin (goimports_reviser)
				},
				json_fmt = {
					command = "jq",
					args = { ".", "$FILENAME" },
				},
				nginxfmt = {
					command = "nginxfmt",
					args = { "-p", "-i", "4", "$FILENAME" },
				},
				sql_formatter = {
					command = "sql-formatter",
					args = {
						"--config",
						[[{
                            "language": "postgresql",
                            "useTabs": true,
                            "tabWidth": 2,
                            "keywordCase": "upper",
                            "dataTypeCase": "lower",
                            "identifierCase": "lower",
                            "functionCase": "lower",
                            "linesBetweenQueries": 1,
                            "newlineBeforeSemicolon": false
                        }]],
					},
				},
			},
			formatters_by_ft = {
				go = { "goimports_reviser", "golines" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				bash = { "shfmt" },
				sql = { "sql_formatter" },
				nginx = { "nginxfmt" },
				json = { "json_fmt" },
				jsonc = { "json_fmt" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				-- ["*"] = { "codespell" }, -- formatter on all filetypes.
				["_"] = { "trim_whitespace" }, -- formatter on filetypes that don't have other formatters configured.
			},
			default_format_opts = {
				lsp_format = "fallback",
				stop_after_first = false,
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true })
		end, { noremap = true, desc = "[F]ormat buffer" })

		--------------------------------------
		require("dap-view").setup({
			auto_toggle = true,
		})

		require("dap-go").setup()

		local dap = require("dap")

		-- gdb for debugging C/C++/Rust, requires gdb 14.0+
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}

		dap.adapters["rust-gdb"] = {
			type = "executable",
			command = "rust-gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}

		dap.configurations["c"] = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}

		dap.configurations["cpp"] = dap.configurations.c

		dap.configurations["rust"] = {
			{
				name = "Launch",
				type = "rust-gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = {}, -- provide arguments if needed
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "rust-gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "rust-gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}

		vim.keymap.set("n", "gdb", require("dap").toggle_breakpoint, { desc = "[d]ebugger [b]reak point", silent = true })
		vim.keymap.set("n", "gdc", require("dap").continue, { desc = "[d]ebugger [c]ontinue", silent = true })
		vim.keymap.set("n", "gdo", require("dap").step_over, { desc = "[d]ebugger step [o]ver", silent = true })
		vim.keymap.set("n", "gdi", require("dap").step_into, { desc = "[d]ebugger step [i]nto", silent = true })
		vim.keymap.set("n", "gdu", require("dap").step_out, { desc = "[d]ebugger step o[u]t", silent = true })
		vim.keymap.set("n", "gdx", require("dap").terminate, { desc = "[d]ebugger e[x]it", silent = true })

		--------------------------------------
		require("flash").setup({
			modes = {
				char = {
					enabled = false,
				},
			},
		})

		vim.keymap.set({ "n", "x", "o" }, "f", require("flash").jump, { noremap = true, desc = "Flash jump" })
		vim.keymap.set({ "n", "x", "o" }, "F", require("flash").treesitter, { noremap = true, desc = "Flash treesitter" })
		vim.keymap.set("c", "<c-f>", require("flash").toggle, { noremap = true, desc = "Toggle Flash (search mode)" })

		--------------------------------------
		require("grug-far").setup({})

		vim.keymap.set("n", "<leader>gf", ":GrugFar<CR>", { desc = "GrugFar", silent = true })
		vim.keymap.set("n", "<leader>gw", ":GrugFarWithin<CR>", { desc = "GrugFarWithin", silent = true })

		--------------------------------------
		require("blink.indent").setup({
			static = {
				char = "▏",
			},
			scope = {
				char = "|",
			},
		})
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	group = lazy_load,
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/windwp/nvim-autopairs" },
			{ src = "https://github.com/windwp/nvim-ts-autotag" },
		})

		--------------------------------------
		require("nvim-autopairs").setup()

		--------------------------------------
		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
		})
	end,
})
