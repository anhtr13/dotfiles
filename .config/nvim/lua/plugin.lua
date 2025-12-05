---@diagnostic disable:undefined-field

-- ============================
-- First load
-- ============================

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.icons" },

	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/refractalize/oil-git-status.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
})

--------------------------------------
require("mini.icons").setup()

--------------------------------------
require("fzf-lua").setup()

--------------------------------------
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
	win_options = {
		signcolumn = "yes:2",
	},
})
require("oil-git-status").setup({})

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

-- ============================
-- Lazy load
-- ============================

local lazy_plugs = vim.api.nvim_create_augroup("lazy.plugs", { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
	group = lazy_plugs,
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/3rd/image.nvim" },
			{ src = "https://github.com/lewis6991/gitsigns.nvim" },
			{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
		})

		--------------------------------------
		require("image").setup({
			integrations = {
				markdown = {
					enabled = false,
				},
				neorg = {
					enabled = false,
				},
				typst = {
					enabled = false,
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
		require("render-markdown").setup({
			render_modes = { "n", "c", "t" },
		})
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = lazy_plugs,
	once = true, -- Ensures the command only runs once
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/rafamadriz/friendly-snippets" },
			{ src = "https://github.com/kevinhwang91/promise-async" },
			{ src = "https://github.com/rcarriga/nvim-dap-ui" },
			{ src = "https://github.com/leoluz/nvim-dap-go" },
			{ src = "https://github.com/nvim-neotest/nvim-nio" },

			{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
			{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
			{ src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
			{ src = "https://github.com/numToStr/Comment.nvim" },
			{ src = "https://github.com/stevearc/conform.nvim" },
			{ src = "https://github.com/mfussenegger/nvim-dap" },
			{ src = "https://github.com/folke/flash.nvim" },
			{ src = "https://github.com/MagicDuck/grug-far.nvim" },
			{ src = "https://github.com/saghen/blink.indent" },
			{ src = "https://github.com/windwp/nvim-ts-autotag" },
			{ src = "https://github.com/kevinhwang91/nvim-ufo" },
		})

		--------------------------------------
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"bash",
				"regex",
				-- 'terraform',
				"yaml",
				"make",
				"cmake",
				"sql",
				"dockerfile",
				-- "toml",
				"json",
				-- 'java',
				-- 'groovy',
				"python",
				"go",
				"rust",
				"zig",
				"cpp",
				"gitignore",
				-- 'graphql',
				"javascript",
				"typescript",
				"tsx",
				-- 'css',
				-- 'html',
				"vue",
			},
			modules = {},
			ignore_install = {},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "{}",
					node_incremental = "{+",
					node_decremental = "{-",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["<leader>("] = "@parameter.inner",
						["<leader>)"] = "@parameter.outer",
						["<leader>{"] = "@function.inner",
						["<leader>}"] = "@function.outer",
						["<leader>["] = "@class.inner",
						["<leader>]"] = "@class.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
					},
				},
				swap = {
					enable = false,
				},
			},
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

		--------------------------------------
		require("dapui").setup()
		require("dap-go").setup()
		local dap = require("dap")
		local dapui = require("dapui")
		-- Setup gdb for debugging C/C++/Rust, requires gdb 14.0+
		-- Make sure build file with -g flag before debugging
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
		dap.configurations.c = {
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
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = {
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
		-- Binding dap & dap-ui
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		--------------------------------------
		require("flash").setup({
			modes = {
				char = {
					enabled = false,
				},
			},
		})

		--------------------------------------
		require("grug-far").setup({})

		--------------------------------------
		require("blink.indent").setup({
			static = {
				char = "▏",
			},
			scope = {
				char = "|",
			},
		})

		--------------------------------------
		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
		})

		--------------------------------------
		require("ufo").setup({
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	group = lazy_plugs,
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/windwp/nvim-autopairs" },
		})

		--------------------------------------
		require("nvim-autopairs").setup()
	end,
})
